#pragma once

#include <assert.h>
#include <iostream>

#include "cuda_runtime.h"

inline cudaError_t checkCuda(cudaError_t result, const char* error_step)
{
    if (result != cudaSuccess) {
        printf("CUDA Step: %s\nCUDA Runtime Error: %s\n", error_step, cudaGetErrorString(result));
        assert(result == cudaSuccess);
    }
    return result;
}

unsigned long long sdiv(unsigned long long a, unsigned long long b);