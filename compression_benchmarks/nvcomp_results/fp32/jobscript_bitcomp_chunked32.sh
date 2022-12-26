#!/bin/bash -x
#SBATCH --account=icei-hbp-2022-0013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=bitcomp-out.%j
#SBATCH --error=bitcomp-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/msg_lu.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/msg_sp.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/msg_sppm.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/msg_sweep3d.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/num_brain.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/num_comet.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/num_control.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/num_plasma.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/obs_error.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/obs_info.fp32
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_bitcomp_chunked -f $SCRATCH/vogel6/fp32/obs_spitzer.fp32

