=====================
MOM6 GPU instructions
=====================

1. Clone this repo and move to the ``ocean_only`` directory.::

     git clone https://github.com/marshallward/MOM6-examples.git
     cd MOM6-examples/ocean_only

2. Set up modules.  This will differ on every system, but here is an example.::

     module load nvhpc
     module load cuda

   You may also need MPI (likely based on HPC-X) and NVIDIA-compatible netCDF
   libraries.  If you need to compile your own, then reach out.

3. Set up a ``config.mk`` build file::

     cat <<EOF > config.mk
     CC = nvc
     MPICC = mpicc
     FC = nvfortran
     MPIFC = mpifort
     FCFLAGS = -g -O0 -mp=gpu -stdpar=gpu -gpu=mem:separate -Minfo=all
     FMS_FCFLAGS = -g -O0 -mp=gpu -gpu=mem:separate -Mnofma -Minfo=all
     LDFLAGS = -mp=gpu
     PYTHON = python3
     EOF

4. Build the model::

     make -j

5. Test the model::

     cd double_gyre
     mpirun -np 1 ../build/MOM6

If you get this far, then you should be ready for development.  Set ``BUILD``
in ``config.mk`` if you want to define additional build targets (such as a CPU
build), and you can always hand-edit the ``Makefile`` in each ``BUILD``
directory.
