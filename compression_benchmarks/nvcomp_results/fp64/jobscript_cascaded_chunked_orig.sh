#!/bin/bash -x
#SBATCH --account=project
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=cascaded-out.%j
#SBATCH --error=cascaded-err.%j
#SBATCH --time=00:01:00
#SBATCH --partition=develgpus

srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f /p/scratch/project/user/obs_error.trace
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f /p/scratch/project/user/obs_info.trace
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f /p/scratch/project/user/obs_spitzer.trace
