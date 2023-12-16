#!/bin/bash -x
#SBATCH --account=project
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=gdeflate-out.%j
#SBATCH --error=gdeflate-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/msg_lu.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/msg_sp.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/msg_sppm.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/msg_sweep3d.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/num_brain.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/num_comet.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/num_control.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/num_plasma.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/obs_error.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/obs_info.fp64
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_gdeflate_chunked -f $SCRATCH/user/fp64/obs_spitzer.fp64

