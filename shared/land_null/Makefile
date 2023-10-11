# Configuration
BUILD ?= build
FMS_BUILD ?= ../fms/$(BUILD)
CODEBASE ?= ../../src/land_null

TARGET = libland_null.a
CONFIGURE_AC = ../config/configure.land_null.ac

FCFLAGS += -I$(abspath $(FMS_BUILD))
LDFLAGS += -L$(abspath $(FMS_BUILD))

include ../config/Libs.mk
