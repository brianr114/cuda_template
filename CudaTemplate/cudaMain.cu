
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
    return 0;
}