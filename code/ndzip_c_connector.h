#ifndef AAA_C_CONNECTOR_H
#define AAA_C_CONNECTOR_H

#ifdef __cplusplus
extern "C" {
#endif

void NDZIP_API_sayHi(const char *name);
int NDZIP_API_compressBuffer(double *d_buffer, int buffer_size,
                             unsigned long int *d_compressed_buffer);
double *NDZIP_API_decompressBuffer(unsigned long int *compressed_device_buffer,
                                   double *uncompressed_device_buffer,
                                   int buffer_size);

#ifdef __cplusplus
}
#endif

#endif