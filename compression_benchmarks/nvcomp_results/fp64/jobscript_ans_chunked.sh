#!/bin/bash -x
#SBATCH --account=project
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=ans-out.%j
#SBATCH --error=ans-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/msg_lu.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/msg_sp.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/msg_sppm.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/msg_sweep3d.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/num_brain.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/num_comet.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/num_control.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/num_plasma.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/obs_error.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/obs_info.fp64
srun /p/project/project/user/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/project/user/fp64/obs_spitzer.fp64
