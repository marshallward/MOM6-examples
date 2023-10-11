# Configuration
BUILD ?= build
FMS_BUILD ?= ../fms/$(BUILD)
CODEBASE ?= ../../src/atmos_null

TARGET = libatmos_null.a
CONFIGURE_AC = ../config/configure.atmos_null.ac

FCFLAGS += -I$(abspath $(FMS_BUILD))
LDFLAGS += -L$(abspath $(FMS_BUILD))

include ../config/Libs.mk
