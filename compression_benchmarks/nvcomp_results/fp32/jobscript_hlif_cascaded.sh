#!/bin/bash -x
#SBATCH --account=project
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=hlif_cascaded.%j
#SBATCH --error=hlif_cascaded_err.%j
#SBATCH --time=00:01:00
#SBATCH --partition=develgpus

$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/msg_lu.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/msg_sp.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/msg_sppm.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/msg_sweep3d.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/num_brain.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/num_comet.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/num_control.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/num_plasma.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/obs_error.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/obs_info.fp32
$PROJECT/user/nvcomp_library/nvcomp_build/bin/benchmark_hlif cascaded -f $SCRATCH/user/fp32/obs_spitzer.fp32

