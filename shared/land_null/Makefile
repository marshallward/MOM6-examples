# Configuration
BUILD ?= build
FMS_BUILD ?= ../fms/build

TARGET = libland_null.a
CODEBASE = ../../src/land_null
CONFIGURE_AC = ../config/configure.land_null.ac

$(info FCFLAGS = $(FCFLAGS))
$(info FMS_BUILD = $(FMS_BUILD))
override FCFLAGS += -I$(abspath $(FMS_BUILD))
override LDFLAGS += -L$(abspath $(FMS_BUILD))
$(info FCFLAGS = $(FCFLAGS))

include ../config/Libs.mk

$(BUILD)/$(TARGET): $(BUILD)/Makefile $(call find_src_files,$(CODEBASE))
	$(MAKE) -C $(BUILD) $(TARGET)
