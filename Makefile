# Attempt at a general Makefile for multiple drivers and compilers
# Rules are all phony at the moment, currently not filename-based
#
# This does not invoke the shell, but adds a redundant slash (-_-)
#BASE := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
BASE := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
LIST_PATHS := ${BASE}/src/mkmf/bin/list_paths
MKMF := ${BASE}/src/mkmf/bin/mkmf
TEMPLATES := ${BASE}/src/mkmf/templates
ENVIRONS := ${BASE}/environs

# "Lazy" evaluation of current build directory
BUILD = ${BASE}/build/$@/repro

all: ocean_only ice_ocean_SIS2

# TODO: Iterate smartly over platforms
#
ocean_only: gnu/ocean_only intel/ocean_only pgi/ocean_only

ice_ocean_SIS2: gnu/ice_ocean_SIS2 intel/ice_ocean_SIS2 pgi/ice_ocean_SIS2

shared: intel/shared gnu/shared pgi/shared

# Driver rules
# TODO: Better iteration over directories

%/ocean_only: %/shared
	mkdir -p ${BUILD}
	rm -f ${BUILD}/path_names
	cd ${BUILD} && ${LIST_PATHS} \
		-l ${BASE}/src/MOM6/{config_src/dynamic,config_src/solo_driver,src/{*,*/*}}
	cd ${BUILD} && ${MKMF} \
		-t ${TEMPLATES}/ncrc-$*.mk \
		-o '-I ${BASE}/build/$*/shared/repro' \
		-p MOM6 \
		-l '-L${BASE}/build/$*/shared/repro -lfms' \
		-c '-Duse_libMPI -Duse_netCDF -DSPMD' \
		${BUILD}/path_names
	source ${ENVIRONS}/$*.env && make \
		-j \
		-C ${BUILD} \
		NETCDF=3 \
		REPRO=1 \
		MOM6

%/ice_ocean_SIS2: %/shared
	mkdir -p ${BUILD}
	rm -f ${BUILD}/path_names
	cd ${BUILD} && ${LIST_PATHS} \
		-l \
			${BASE}/src/MOM6/config_src/{dynamic,coupled_driver} \
			${BASE}/src/MOM6/src/{*,*/*}/ \
			${BASE}/src/{atmos_null,coupler,land_null,ice_ocean_extras,icebergs,SIS2,FMS/coupler,FMS/include}
	cd ${BUILD} && ${MKMF} \
		-t ${TEMPLATES}/ncrc-$*.mk \
		-o '-I ${BASE}/build/$*/shared/repro' \
		-p MOM6 \
		-l '-L ${BASE}/build/$*/shared/repro -lfms' \
		-c '-Duse_libMPI -Duse_netCDF -DSPMD -Duse_AM3_physics -D_USE_LEGACY_LAND_' \
		${BUILD}/path_names
	source ${ENVIRONS}/$*.env && make \
		-j \
		-C ${BUILD} \
		NETCDF=3 \
		REPRO=1 \
		MOM6

%/shared:
	mkdir -p ${BUILD}
	rm -f ${BUILD}/path_names
	cd ${BUILD} && ${LIST_PATHS} \
		-l ${BASE}/src/FMS
	cd ${BUILD} && ${MKMF} \
		-t ${TEMPLATES}/ncrc-$*.mk \
		-p libfms.a \
		-c "-Duse_libMPI -Duse_netCDF -DSPMD" \
		${BUILD}/path_names
	source ${ENVIRONS}/$*.env && make \
		-j \
		-C ${BUILD} \
		NETCDF=3 \
		REPRO=1 \
		libfms.a
