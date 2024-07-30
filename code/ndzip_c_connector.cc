#include <cstdlib>
#include <ndzip/cuda.hh>

#include "ndzip_api.h"
#include "ndzip_c_connector.h"

#ifdef __cplusplus
extern "C" {
#endif

static NDZIP_API *NDZIP_API_instance = NULL;

void lazyNDZIP_API() {
  if (NDZIP_API_instance == NULL) {
    NDZIP_API_instance = new NDZIP_API();
  }
}

void NDZIP_API_sayHi(const char *name) {
  lazyNDZIP_API();
  NDZIP_API_instance->sayHi(name);
}

int NDZIP_API_compressBuffer(double *d_buffer, int buffer_size,
                             unsigned long int *d_compressed_buffer) {
  lazyNDZIP_API();
  return NDZIP_API_instance->compress_buffer(d_buffer, buffer_size,
                                             d_compressed_buffer);
}

double *NDZIP_API_decompressBuffer(unsigned long int *compressed_device_buffer,
                                   double *uncompressed_device_buffer,
                                   int buffer_size) {
  lazyNDZIP_API();
  return NDZIP_API_instance->decompress_buffer(compressed_device_buffer, uncompressed_device_buffer,
                                             buffer_size);
}

#ifdef __cplusplus
}
#endif
