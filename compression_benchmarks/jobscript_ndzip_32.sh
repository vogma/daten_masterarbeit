#!/bin/bash -x
#SBATCH --account=icei-hbp-2022-0013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=ndzip-out.%j
#SBATCH --error=ndzip-err.%j
#SBATCH --time=00:25:00
#SBATCH --partition=develgpus

$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/msg_lu_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_lu32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/msg_sp_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_sp32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/msg_sppm_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_sppm32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/msg_sweep3d_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/msg_sweep3d32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/num_brain_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_brain32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/num_comet_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_comet32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/num_control_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_control32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/num_plasma_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/num_plasma32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/obs_error_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/obs_error32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/obs_info_bench32.csv -r 5 -a ndzip-cuda > $SCRATCH/vogel6/obs_info32.csv
$PROJECT/vogel6/ndzip_copy/build/benchmark $PROJECT/vogel6/jobs/ndzip/fp32/obs_spitzer_bench32.csv -a ndzip-cuda > $SCRATCH/vogel6/obs_spitzer32.csv
