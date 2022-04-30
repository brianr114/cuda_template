#pragma once

#include <assert.h>
#include <iostream>

#include "cuda_runtime.h"

struct concurrent_stream_chunks {
    unsigned long long n;
    unsigned long long stream_chunk;
    unsigned long long gpu_chunk;
};

struct conccurrent_stream_memory_bounds {
    unsigned long long stream_offset;
    unsigned long long lower;
    unsigned long long upper;
    unsigned long long width;
};

inline cudaError_t checkCuda(cudaError_t result, const char* error_step)
{
    if (result != cudaSuccess) {
        printf("CUDA Step: %s\nCUDA Runtime Error: %s\n", error_step, cudaGetErrorString(result));
        assert(result == cudaSuccess);
    }
    return result;
}

unsigned long long sdiv(unsigned long long a, unsigned long long b) {
    return (a + b - 1) / b;
}

concurrent_stream_chunks calc_concurrent_stream_chunks(unsigned long long n, unsigned long long num_gpus, unsigned long long num_streams)
{
    concurrent_stream_chunks params_out;

    params_out.n = n;
    params_out.stream_chunk = sdiv(sdiv(n, num_gpus), num_streams);
    params_out.gpu_chunk = params_out.stream_chunk * num_streams;

    return params_out;
}

conccurrent_stream_memory_bounds calc_concurrent_stream_bounds(concurrent_stream_chunks chunk_params, unsigned long long gpu, unsigned long long stream)
{
    conccurrent_stream_memory_bounds params_out;

    params_out.stream_offset = chunk_params.stream_chunk * stream;
    params_out.lower = chunk_params.gpu_chunk * gpu + params_out.stream_offset;
    params_out.upper = std::min(params_out.lower + chunk_params.stream_chunk, chunk_params.n);
    params_out.width = params_out.upper - params_out.lower;

    return params_out;
}