#define BENCHMARK "OSU MPI%s Latency Test"
/*
 * Copyright (C) 2002-2021 the Network-Based Computing Laboratory
 * (NBCL), The Ohio State University.
 *
 * Contact: Dr. D. K. Panda (panda@cse.ohio-state.edu)
 *
 * For detailed copyright and licensing information, please refer to the
 * copyright file COPYRIGHT in the top level OMB directory.
 */
#include "cuda_runtime.h"
#include "ndzip_c_connector.h"
#include <osu_util_mpi.h>
#include <stdbool.h>

#ifdef _ENABLE_CUDA_KERNEL_
double measure_kernel_lo(char *, int);
void touch_managed_src(char *, int);
void touch_managed_dst(char *, int);
#endif /* #ifdef _ENABLE_CUDA_KERNEL_ */
double calculate_total(double, double, double);

int memory_buffer = 33554432;

void fill_buffer(double *send_buffer, int size) {

  FILE *fileptr;
  char *buffer;

  fileptr = fopen("/p/scratch/icei-hbp-2022-0013/vogel6/fp64/num_plasma.fp64", "rb");

  buffer = (char *)malloc(size * sizeof(char));
  fread(buffer, size, sizeof(char), fileptr);
  fclose(fileptr);

  memcpy(send_buffer, buffer, size);
  free(buffer);
}

int checkBuffer(double *device_ptr, double *host_pointer, int size) {

  double *host_buffer = (double *)malloc(size);
  cudaMemcpy(host_buffer, device_ptr, size, cudaMemcpyDeviceToHost);
  int legit = 1;

  for (int i = 0; i < 100; i++) {
    printf("%f ", host_pointer[i]);
    if (i % 15 == 0) {
      printf("\n");
    }
  }

  for (int i = 0; i < 100; i++) {
    printf("%f ", host_buffer[i]);
    if (i % 15 == 0) {
      printf("\n");
    }
  }

  for (int i = 0; i < size / 8; i++) {
    if (host_buffer[i] != host_pointer[i]) {
      legit = 0;
    }
  }
  free(host_buffer);

  return legit;
}

int main(int argc, char *argv[]) {
  NDZIP_API_sayHi("Init");
  void *compression_buffer_mem;
  void *decompression_buffer_mem;
  void *d_send_buffer_mem;
  void *d_receive_buffer_mem;

  double *send_buffer;
  double *receive_buffer;
  double *d_send_buffer;
  double *d_receive_buffer;

  cudaMalloc(&compression_buffer_mem, memory_buffer);
  cudaMalloc(&decompression_buffer_mem, memory_buffer);

  double *compression_buffer = compression_buffer_mem;
  double *decompression_buffer = decompression_buffer_mem;

  int myid, numprocs, i, j;
  int size;
  MPI_Status reqstat;
  // char *s_buf, *r_buf;
  double t_start = 0.0, t_end = 0.0, t_lo = 0.0, t_total = 0.0;
  int po_ret = 0;
  int errors = 0;

  options.bench = PT2PT;
  options.subtype = LAT;

  set_header(HEADER);
  set_benchmark_name("osu_latency");

  po_ret = process_options(argc, argv);

  if (PO_OKAY == po_ret && NONE != options.accel) {
    if (init_accel()) {
      fprintf(stderr, "Error initializing device\n");
      exit(EXIT_FAILURE);
    }
  }

  MPI_CHECK(MPI_Init(&argc, &argv));
  MPI_CHECK(MPI_Comm_size(MPI_COMM_WORLD, &numprocs));
  MPI_CHECK(MPI_Comm_rank(MPI_COMM_WORLD, &myid));

  if (0 == myid) {
    switch (po_ret) {
    case PO_CUDA_NOT_AVAIL:
      fprintf(stderr, "CUDA support not enabled.  Please recompile "
                      "benchmark with CUDA support.\n");
      break;
    case PO_OPENACC_NOT_AVAIL:
      fprintf(stderr, "OPENACC support not enabled.  Please "
                      "recompile benchmark with OPENACC support.\n");
      break;
    case PO_BAD_USAGE:
      print_bad_usage_message(myid);
      break;
    case PO_HELP_MESSAGE:
      print_help_message(myid);
      break;
    case PO_VERSION_MESSAGE:
      print_version_message(myid);
      MPI_CHECK(MPI_Finalize());
      exit(EXIT_SUCCESS);
    case PO_OKAY:
      break;
    }
  }

  switch (po_ret) {
  case PO_CUDA_NOT_AVAIL:
  case PO_OPENACC_NOT_AVAIL:
  case PO_BAD_USAGE:
    MPI_CHECK(MPI_Finalize());
    exit(EXIT_FAILURE);
  case PO_HELP_MESSAGE:
  case PO_VERSION_MESSAGE:
    MPI_CHECK(MPI_Finalize());
    exit(EXIT_SUCCESS);
  case PO_OKAY:
    break;
  }

  if (numprocs != 2) {
    if (myid == 0) {
      fprintf(stderr, "This test requires exactly two processes\n");
    }

    MPI_CHECK(MPI_Finalize());
    exit(EXIT_FAILURE);
  }

  if (options.buf_num == SINGLE) {

    send_buffer = (double *)malloc(memory_buffer);
    receive_buffer = (double *)malloc(memory_buffer);

    cudaMalloc(&d_send_buffer_mem, memory_buffer);
    cudaMalloc(&d_receive_buffer_mem, memory_buffer);

    d_send_buffer = d_send_buffer_mem;
    d_receive_buffer = d_receive_buffer_mem;
  }

  print_header(myid, LAT);

  /* Latency test */
  for (size = options.min_message_size; size <= options.max_message_size;
       size = (size ? size * 2 : 1)) {

    int once = 1;

    fill_buffer(send_buffer, size);
    fill_buffer(receive_buffer, size);

    cudaMemcpy(d_send_buffer, send_buffer, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_receive_buffer, receive_buffer, size, cudaMemcpyHostToDevice);

    if (size > LARGE_MESSAGE_SIZE) {
      options.iterations = options.iterations_large;
      options.skip = options.skip_large;
    }

#ifdef _ENABLE_CUDA_KERNEL_
    //  if ((options.src == 'M' && options.MMsrc == 'D') ||
    //     (options.dst == 'M' && options.MMdst == 'D')) {
    //    t_lo = measure_kernel_lo(s_buf, size);
    // }
#endif /* #ifdef _ENABLE_CUDA_KERNEL_ */

    MPI_CHECK(MPI_Barrier(MPI_COMM_WORLD));
    t_total = 0.0;

    for (i = 0; i < options.iterations + options.skip; i++) {
      if (options.validate) {
        MPI_CHECK(MPI_Barrier(MPI_COMM_WORLD));
      }
      if (myid == 0) {
        for (j = 0; j <= options.warmup_validation; j++) {
          if (i >= options.skip && j == options.warmup_validation) {
            t_start = MPI_Wtime();
          }
#ifdef _ENABLE_CUDA_KERNEL_
          if (options.src == 'M') {
            //             touch_managed_src(s_buf, size);
          }
#endif /* #ifdef _ENABLE_CUDA_KERNEL_ */
          int compressed_length = 0;

          /*only compress messages above given size*/
          if (size > 1000) {

            // compress d_send_buffer
            compressed_length = NDZIP_API_compressBuffer(
                d_send_buffer, size, (long unsigned int *)compression_buffer);

            // send length of compressed buffer to other node
            MPI_CHECK(
                MPI_Send(&compressed_length, 1, MPI_INT, 1, 1, MPI_COMM_WORLD));

            // send compressed buffer to other rank
            MPI_CHECK(MPI_Send(compression_buffer, compressed_length,
                               MPI_DOUBLE, 1, 1, MPI_COMM_WORLD));

            int buff_length;

            // receive length of compressed buffer from other rank
            MPI_CHECK(MPI_Recv(&buff_length, 1, MPI_INT, 1, 1, MPI_COMM_WORLD,
                               &reqstat));

            // receive compressed stream from other rank
            MPI_CHECK(MPI_Recv(d_receive_buffer, buff_length, MPI_DOUBLE, 1, 1,
                               MPI_COMM_WORLD, &reqstat));

            // decompress received buffer
            double *buffer_ptr = NDZIP_API_decompressBuffer(
                (long unsigned int *)d_receive_buffer, decompression_buffer,
                size);

            /*if (once) {
              if (!checkBuffer(buffer_ptr, send_buffer, size)) {
                printf("corrupt buffer");
              }
              once = 0;
            }*/

          } else {

            MPI_CHECK(MPI_Send(send_buffer, size / 8, MPI_DOUBLE, 1, 1,
                               MPI_COMM_WORLD));
            MPI_CHECK(MPI_Recv(receive_buffer, size / 8, MPI_DOUBLE, 1, 1,
                               MPI_COMM_WORLD, &reqstat));
          }

          if (i >= options.skip && j == options.warmup_validation) {
            t_end = MPI_Wtime();
            t_total += calculate_total(t_start, t_end, t_lo);
          }
        }
        if (options.validate) {
          int errors_recv = 0;
          MPI_CHECK(MPI_Recv(&errors_recv, 1, MPI_INT, 1, 2, MPI_COMM_WORLD,
                             &reqstat));
          errors += errors_recv;
        }
      } else if (myid == 1) {
        for (j = 0; j <= options.warmup_validation; j++) {

          if (size > 1000) {

            int buff_length;
            MPI_CHECK(MPI_Recv(&buff_length, 1, MPI_INT, 0, 1, MPI_COMM_WORLD,
                               &reqstat));

            MPI_CHECK(MPI_Recv(d_receive_buffer, buff_length, MPI_DOUBLE, 0, 1,
                               MPI_COMM_WORLD, &reqstat));
            double *device_ptr;
            device_ptr = NDZIP_API_decompressBuffer(
                (long unsigned int *)d_receive_buffer, decompression_buffer,
                size);

            int compressed_length;
            compressed_length = NDZIP_API_compressBuffer(
                d_send_buffer, size, (long unsigned int *)compression_buffer);

            MPI_CHECK(
                MPI_Send(&compressed_length, 1, MPI_INT, 0, 1, MPI_COMM_WORLD));

            MPI_CHECK(MPI_Send(compression_buffer, compressed_length,
                               MPI_DOUBLE, 0, 1, MPI_COMM_WORLD));

/*            if (once) {
              if (!checkBuffer(device_ptr, send_buffer, size)) {
                printf("corrupt buffer");
              }
              once = 0;
            }*/

          } else {
            MPI_CHECK(MPI_Recv(receive_buffer, size / 8, MPI_DOUBLE, 0, 1,
                               MPI_COMM_WORLD, &reqstat));
            MPI_CHECK(MPI_Send(send_buffer, size / 8, MPI_DOUBLE, 0, 1,
                               MPI_COMM_WORLD));
          }
        }
        if (options.validate) {
          //             errors = validate_data(r_buf, size, 1, options.accel,
          //             i);
          //           MPI_CHECK(MPI_Send(&errors, 1, MPI_INT, 0, 2,
          //                     MPI_COMM_WORLD));
        }
      }
    }

    if (myid == 0) {
      double latency = (t_total * 1e6) / (2.0 * options.iterations);
      if (options.validate) {
        fprintf(stdout, "%-*d%*.*f%*s\n", 10, size, FIELD_WIDTH,
                FLOAT_PRECISION, latency, FIELD_WIDTH,
                VALIDATION_STATUS(errors));
      } else {
        fprintf(stdout, "%-*d%*.*f\n", 10, size, FIELD_WIDTH, FLOAT_PRECISION,
                latency);
      }
      fflush(stdout);
    }
    if (options.buf_num == MULTIPLE) {
      //   free_memory(s_buf, r_buf, myid);
    }

    if (options.validate) {
      MPI_CHECK(MPI_Bcast(&errors, 1, MPI_INT, 0, MPI_COMM_WORLD));
      if (0 != errors) {
        break;
      }
    }
  }

  if (options.buf_num == SINGLE) {
    //        free_memory(s_buf, r_buf, myid);
  }

  MPI_CHECK(MPI_Finalize());

  /*if (NONE != options.accel) {
      if (cleanup_accel()) {
          fprintf(stderr, "Error cleaning up device\n");
          exit(EXIT_FAILURE);
      }
  }*/

  if (errors != 0 && options.validate && myid == 0) {
    fprintf(stdout,
            "DATA VALIDATION ERROR: %s exited with status %d on"
            " message size %d.\n",
            argv[0], EXIT_FAILURE, size);
    exit(EXIT_FAILURE);
  }
  cudaFree(compression_buffer);
  cudaFree(decompression_buffer);
  cudaFree(d_send_buffer);
  cudaFree(d_receive_buffer);
  free(send_buffer);
  free(receive_buffer);
  return EXIT_SUCCESS;
}

#ifdef _ENABLE_CUDA_KERNEL_
double measure_kernel_lo(char *buf, int size) {
  int i;
  double t_lo = 0.0, t_start, t_end;

  for (i = 0; i < 10; i++) {
    launch_empty_kernel(buf, size);
  }

  for (i = 0; i < 1000; i++) {
    t_start = MPI_Wtime();
    launch_empty_kernel(buf, size);
    synchronize_stream();
    t_end = MPI_Wtime();
    t_lo = t_lo + (t_end - t_start);
  }

  t_lo = t_lo / 1000;
  return t_lo;
}

void touch_managed_src(char *buf, int size) {
  if (options.src == 'M') {
    if (options.MMsrc == 'D') {
      touch_managed(buf, size);
      synchronize_stream();
    } else if ((options.MMsrc == 'H') && size > PREFETCH_THRESHOLD) {
      prefetch_data(buf, size, cudaCpuDeviceId);
      synchronize_stream();
    } else {
      memset(buf, 'c', size);
    }
  }
}

void touch_managed_dst(char *buf, int size) {
  if (options.dst == 'M') {
    if (options.MMdst == 'D') {
      touch_managed(buf, size);
      synchronize_stream();
    } else if ((options.MMdst == 'H') && size > PREFETCH_THRESHOLD) {
      prefetch_data(buf, size, -1);
      synchronize_stream();
    } else {
      memset(buf, 'c', size);
    }
  }
}
#endif /* #ifdef _ENABLE_CUDA_KERNEL_ */

double calculate_total(double t_start, double t_end, double t_lo) {
  double t_total;

  if ((options.src == 'M' && options.MMsrc == 'D') &&
      (options.dst == 'M' && options.MMdst == 'D')) {
    t_total = (t_end - t_start) - (2 * t_lo);
  } else if ((options.src == 'M' && options.MMsrc == 'D') ||
             (options.dst == 'M' && options.MMdst == 'D')) {
    t_total = (t_end - t_start) - t_lo;
  } else {
    t_total = (t_end - t_start);
  }

  return t_total;
}
