#!/bin/bash -x
#SBATCH --account=icei-hbp-2022-0013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=ans-out.%j
#SBATCH --error=ans-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/msg_lu.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/msg_sp.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/msg_sppm.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/msg_sweep3d.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/num_brain.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/num_comet.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/num_control.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/num_plasma.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/obs_error.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/obs_info.fp64
srun /p/project/icei-hbp-2022-0013/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_ans_chunked -f /p/scratch/icei-hbp-2022-0013/vogel6/fp64/obs_spitzer.fp64
