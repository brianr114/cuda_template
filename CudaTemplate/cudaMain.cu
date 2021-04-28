
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

int main()
{
    int deviceId;
    cudaDeviceProp cudaProperties;

    checkCuda(cudaGetDevice(&deviceId), "Get Device ID");
    checkCuda(cudaGetDeviceProperties(&cudaProperties, deviceId), "Get Device Properties");
    
    return 0;
}