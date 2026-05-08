# Default build directories
#BUILD = build
#FMS_BUILD = ../shared/fms/build

CC = nvc
MPICC = mpicc
FC = nvfortran
MPIFC = mpifort

# User-defined flags
# NOTE: -Mnovect is currently required for -O4/-O4 bit equivalence
FCFLAGS = -g -O0 -Mnovect -Mnofma -Minfo
# XXX: Mandatory inlining is currently required
FCFLAGS += -Minline=name:flux_elem,name:flux_elem_OBC,name:ratio_max
# Enable GPU kernels
FCFLAGS += -mp=gpu -stdpar=gpu -gpu=mem:separate

# NOTE: Define compute capability to reduce build time, e.g.
# 	A100: -gpu=cc80,mem:separate
# 	H100: -gpu=cc90,mem:separate

LDFLAGS = -mp=gpu
# NOTE: Can also set compute capability

PYTHON = python3

# NOTE: FMS cannot currently accept -stdpar=gpu
FMS_FCFLAGS = -g -O0
FMS_FCFLAGS += -mp=gpu -acc=gpu -gpu=mem:separate -Mnofma -Minfo=all
