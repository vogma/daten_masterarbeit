#!/bin/bash -x
#SBATCH --account=icei-hbp-2022-0013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=cascaded-out.%j
#SBATCH --error=cascaded-err.%j
#SBATCH --time=00:01:00
#SBATCH --partition=develgpus

srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/obs_error.trace
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/obs_info.trace
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/obs_spitzer.trace
