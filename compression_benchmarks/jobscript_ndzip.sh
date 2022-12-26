#!/bin/bash -x
#SBATCH --account=icei-hbp-2022-0013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=ndzip-out.%j
#SBATCH --error=ndzip-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/msg_lu_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_lu.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/msg_sp_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_sp.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/msg_sppm_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_sppm.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/msg_sweep3d_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_sweep3d.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/num_brain_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_brain.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/num_comet_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_comet.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/num_control_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_control.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/num_plasma_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_plasma.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/obs_error_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/obs_error.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/obs_info_bench.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/obs_info.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp64/obs_spitzer_bench.csv -a ndzip-cuda > $SCRATCH/vogel6/obs_spitzer.csv
