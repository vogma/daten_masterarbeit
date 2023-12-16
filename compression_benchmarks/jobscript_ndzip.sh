#!/bin/bash -x
#SBATCH --account=project
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=ndzip-out.%j
#SBATCH --error=ndzip-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/msg_lu_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/msg_lu.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/msg_sp_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/msg_sp.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/msg_sppm_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/msg_sppm.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/msg_sweep3d_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/msg_sweep3d.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/num_brain_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/num_brain.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/num_comet_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/num_comet.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/num_control_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/num_control.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/num_plasma_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/num_plasma.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/obs_error_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/obs_error.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/obs_info_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/user/obs_info.csv
$PROJECT/user/ndzip_copy/build/benchmark $PROJECT/user/jobs/ndzip/fp64/obs_spitzer_bench.csv -a ndzip-cuda > $SCRATCH/user/obs_spitzer.csv
