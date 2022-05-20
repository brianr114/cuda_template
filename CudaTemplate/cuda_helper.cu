#include "cuda_helper.cuh"

unsigned long long sdiv(unsigned long long a, unsigned long long b) {
    return (a + b - 1) / b;
}