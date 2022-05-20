#pragma once

#include <cstdint>

#include "cuda_helper.cuh"

struct buffer_chunk {
	uint64_t lower;
	uint64_t upper;
	uint64_t width;
	uint64_t stream_offset = 0;
};

class ConcurrentStreamParams
{
private:
	uint64_t num_gpus;
	uint64_t streams_per_gpu;
	uint64_t num_elements;
	uint64_t gpu_chunk;
	uint64_t stream_chunk;

public:
	ConcurrentStreamParams(uint64_t num_elements, uint64_t num_gpus, uint64_t num_streams);
	~ConcurrentStreamParams();

	buffer_chunk calc_gpu_chunk(uint64_t gpu);
	buffer_chunk calc_stream_chunk(uint64_t gpu, uint64_t stream);
};

