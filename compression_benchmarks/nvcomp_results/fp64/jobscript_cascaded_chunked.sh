#!/bin/bash -x
#SBATCH --account=icei-hbp-2022-0013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=cascaded-out.%j
#SBATCH --error=cascaded-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/msg_lu.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/msg_sp.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/msg_sppm.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/msg_sweep3d.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/num_brain.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/num_comet.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/num_control.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/num_plasma.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/obs_error.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/obs_info.fp64
$PROJECT/vogel6/nvcomp_library/nvcomp_build/bin/benchmark_cascaded_chunked -f $SCRATCH/vogel6/fp64/obs_spitzer.fp64

