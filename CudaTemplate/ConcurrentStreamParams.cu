#include <algorithm>
#include "ConcurrentStreamParams.cuh"

ConcurrentStreamParams::ConcurrentStreamParams(uint64_t num_elements, uint64_t num_gpus, uint64_t num_streams)
{
	ConcurrentStreamParams::num_elements = num_elements;
	ConcurrentStreamParams::num_gpus = num_gpus;
	ConcurrentStreamParams::streams_per_gpu = num_streams;
	ConcurrentStreamParams::stream_chunk = sdiv(sdiv(num_elements, num_gpus), num_streams);
	ConcurrentStreamParams::gpu_chunk = ConcurrentStreamParams::stream_chunk * num_streams;
}

ConcurrentStreamParams::~ConcurrentStreamParams()
{
}

buffer_chunk ConcurrentStreamParams::calc_gpu_chunk(uint64_t gpu)
{
	buffer_chunk params;

	params.lower = gpu_chunk * gpu;
	params.upper = std::min(params.lower + gpu_chunk, num_elements);
	params.width = params.upper - params.lower;

	return params;
}

buffer_chunk ConcurrentStreamParams::calc_stream_chunk(uint64_t gpu, uint64_t stream)
{
	buffer_chunk params;

	params.stream_offset = stream_chunk * stream;
	params.lower = gpu_chunk * gpu + params.stream_offset;
	params.upper = std::min(params.lower + stream_chunk, num_elements);
	params.width = params.upper - params.lower;
	
	return params;
}
