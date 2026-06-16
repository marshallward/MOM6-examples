CC = nvc
MPICC = mpicc
FC = nvfortran
MPIFC = mpifort
PYTHON = python3

FCFLAGS = -g -O0 -mp=gpu -stdpar=gpu -gpu=mem:separate \
  -Mnovect -Mnofma -Minfo=all

# Currently required by NVIDIA GPU in MOM_continuity_PPM.F90
FCFLAGS += -Minline=name:flux_elem,name:flux_elem_OBC,name:ratio_max

# FMS cannot currently accept -stdpar=gpu
FMS_FCFLAGS = -g -O0 -mp=gpu -acc=gpu -gpu=mem:separate \
	-Minfo=all

LDFLAGS = -mp=gpu -acc=gpu

## Optionally set the compute capability
#FCFLAGS += -gpu=cc90
#FMS_FCFLAGS += -gpu=cc90
#LDFLAGS += -gpu=cc90
