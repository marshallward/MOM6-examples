CC = nvc
MPICC = mpicc
FC = nvfortran
MPIFC = mpifort
FCFLAGS = -g -O0 -mp=gpu -stdpar=gpu -gpu=mem:separate -Mnofma -Minfo=all
LDFLAGS = -mp=gpu
PYTHON = python3

# FMS cannot currently accept -stdpar=gpu
FMS_FCFLAGS = -g -O0 -mp=gpu -gpu=mem:separate -Mnofma -Minfo=all
