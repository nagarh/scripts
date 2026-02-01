#!/bin/bash

# If you use module load cuda/12.4.0 (or similar) at the start of your job, keep it.
# Unset LD_LIBRARY_PATH so TensorFlow and JAX use their pip-installed CUDA libs
# instead of system CUDA; otherwise you can get undefined symbols or cuSPARSE/cuDNN errors.
unset LD_LIBRARY_PATH

# OpenMM (used for AMBER relaxation) needs libstdc++ with GLIBCXX_3.4.30 (GCC 12+).
# The pixi env ships a suitable libstdc++.so.6 in .pixi/envs/default/lib — use it
# so you don't need "module load gcc/12". (See YoshitakaMo/localcolabfold#comments.)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PIXI_LIB="${SCRIPT_DIR}/.pixi/envs/default/lib"
if [[ -d "$PIXI_LIB" && -f "${PIXI_LIB}/libstdc++.so.6" ]]; then
  export LD_LIBRARY_PATH="${PIXI_LIB}"
else
  # Fallback: use GCC's lib if user has gcc >= 12 loaded (e.g. module load gcc/12).
  GCC_LIB=$(gcc -print-file-name=libstdc++.so 2>/dev/null)
  if [[ -n "$GCC_LIB" && -f "$GCC_LIB" ]]; then
    export LD_LIBRARY_PATH="$(dirname "$GCC_LIB")"
  fi
fi

INPUTFILE="1BJP_1"
OUTPUTDIR="${INPUTFILE}"
RANDOMSEED=0

# Use only pixi env packages (ignore ~/.local to avoid pandas/numpy ABI mismatch)
export PYTHONNOUSERSITE=1
export PATH="/home/hn533621/localcolabfold/.pixi/envs/default/bin:${PATH}"

colabfold_batch \
  --num-recycle 3 \
  --amber \
  --num-models 5 \
  --model-order 1,2,3,4,5 \
  --random-seed ${RANDOMSEED} \
  ${INPUTFILE}.fasta \
  ${OUTPUTDIR}
