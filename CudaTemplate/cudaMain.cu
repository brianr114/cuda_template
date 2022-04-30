
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <assert.h>
#include <iostream>
#include <cstdint>

#include "cuda_helper.cuh"

#define NUM_GPUS 1

int main()
{
    int deviceId{ 0 };
    cudaDeviceProp cudaProperties;

    for (int i = 0; i < NUM_GPUS; i++) {
        checkCuda(cudaSetDevice(i), "Set Device");
        checkCuda(cudaGetDeviceProperties(&cudaProperties, i), "Get Device Properties");
        std::cout << cudaProperties.name << std::endl;
    }

    return 0;
}