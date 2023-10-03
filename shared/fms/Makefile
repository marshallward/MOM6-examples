# Configuration
BUILD ?= build
CODEBASE ?= ../../src/FMS

TARGET = libFMS.a
MAKEFILE_IN = ../../src/MOM6/ac/deps/Makefile.fms.in
CONFIGURE_AC = ../../src/MOM6/ac/deps/configure.fms.ac
M4DIR = ../../src/MOM6/ac/deps/m4

# These are required by the FMS2 test suite
CPPFLAGS += -DAU_TEST_KIND_=r8_kind
CPPFLAGS += -DDO_TEST_KIND_=r8_kind
CPPFLAGS += -DFMS_CP_TEST_KIND_=r8_kind
CPPFLAGS += -DFMS_TEST_BC_TYPE_=bc
CPPFLAGS += -DMO_TEST_KIND_=8
CPPFLAGS += -DTI_TEST_KIND_=8
CPPFLAGS += -DTEST_AST_KIND_=r8_kind
CPPFLAGS += -DTEST_DI_KIND_=8
CPPFLAGS += -DTEST_FM_KIND_=8
CPPFLAGS += -DTEST_INTP_KIND_=8
CPPFLAGS += -DTEST_RN_KIND_=r8_kind
CPPFLAGS += -DTEST_SVP_KIND_=8
CPPFLAGS += -DTEST_TM_KIND_=8
# TODO: This is not sustainable...

include ../config/Libs.mk
