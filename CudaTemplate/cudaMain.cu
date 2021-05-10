
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <assert.h>

inline cudaError_t checkCuda(cudaError_t result, const char *error_step)
{
    if (result != cudaSuccess) {
        printf("CUDA Step: %s\nCUDA Runtime Error: %s\n", error_step, cudaGetErrorString(result));
        assert(result == cudaSuccess);
    }
    return result;
}

void calc_concurrent_stream_addr(unsigned long long N, unsigned long long num_streams, unsigned long long iterator, unsigned long long data_size, unsigned long long& lower, unsigned long long& width);

int main()
{
    int deviceId;
    cudaDeviceProp cudaProperties;

    checkCuda(cudaGetDevice(&deviceId), "Get Device ID");
    checkCuda(cudaGetDeviceProperties(&cudaProperties, deviceId), "Get Device Properties");

    return 0;
}

void calc_concurrent_stream_addr(unsigned long long N, unsigned long long num_streams, unsigned long long iterator, unsigned long long data_size, unsigned long long& lower, unsigned long long& width)
{
    unsigned long long chunk_size = (N + num_streams - 1) / num_streams;
    lower = chunk_size * iterator; 
    unsigned long long upper = min(lower + chunk_size, N);
    width = (upper - lower) * data_size;
}