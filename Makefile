BASE := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
# This does not invoke the shell, but adds a redundant slash (-_-)
#BASE := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
LIST_PATHS := ${BASE}/src/mkmf/bin/list_paths
MKMF := ${BASE}/src/mkmf/bin/mkmf
TEMPLATE := ${BASE}/src/mkmf/templates/ncrc-intel.mk

# "Lazy" define
BUILD = ${BASE}/build/intel/$@/repro

all: ocean_only ice_ocean_SIS2

ocean_only: shared
	mkdir -p ${BUILD}
	rm -f ${BUILD}/path_names
	cd ${BUILD} && ${LIST_PATHS} \
		-l ${BASE}/src/MOM6/{config_src/dynamic,config_src/solo_driver,src/{*,*/*}}
	cd ${BUILD} && ${MKMF} \
		-t ${TEMPLATE} \
		-o '-I ${BASE}/build/intel/shared/repro' \
		-p MOM6 \
		-l '-L${BASE}/build/intel/shared/repro -lfms' \
		-c '-Duse_libMPI -Duse_netCDF -DSPMD' \
		${BUILD}/path_names
	make -j \
		-C ${BUILD} \
		NETCDF=3 \
		REPRO=1 \
		MOM6

ice_ocean_SIS2: shared
	mkdir -p ${BUILD}
	rm -f ${BUILD}/path_names
	cd ${BUILD} && ${LIST_PATHS} \
		-l \
			${BASE}/src/MOM6/config_src/{dynamic,coupled_driver} \
			${BASE}/src/MOM6/src/{*,*/*}/ \
			${BASE}/src/{atmos_null,coupler,land_null,ice_ocean_extras,icebergs,SIS2,FMS/coupler,FMS/include}
	cd ${BUILD} && ${MKMF} \
		-t ${TEMPLATE} \
		-o '-I ${BASE}/build/intel/shared/repro' \
		-p MOM6 \
		-l '-L ${BASE}/build/intel/shared/repro -lfms' \
		-c '-Duse_libMPI -Duse_netCDF -DSPMD -Duse_AM3_physics -D_USE_LEGACY_LAND_' \
		${BUILD}/path_names
	make -j \
		-C ${BUILD} \
		NETCDF=3 \
		REPRO=1 \
		MOM6

shared:
	mkdir -p ${BUILD}
	rm -f ${BUILD}/path_names
	cd ${BUILD} && ${LIST_PATHS} \
		-l ${BASE}/src/FMS
	cd ${BUILD} && ${MKMF} \
		-t ${TEMPLATE} \
		-p libfms.a \
		-c "-Duse_libMPI -Duse_netCDF -DSPMD" \
		${BUILD}/path_names
	make -j \
		-C ${BUILD} \
		NETCDF=3 \
		REPRO=1 \
		libfms.a
