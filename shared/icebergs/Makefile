# Configuration
BUILD ?= build
FMS_BUILD ?= ../fms/build

CODEBASE = ../../src/icebergs/src
TARGET = libicebergs.a
CONFIGURE_AC = ../config/configure.icebergs.ac

# TODO: this macro should be determined by autoconf
$(info CFLAGS = $(CFLAGS))
$(info FCFLAGS = $(FCFLAGS))
$(info FMS_BUILD = $(FMS_BUILD))
override CPPFLAGS += -DUSE_FMS2_IO
override FCFLAGS += -I$(abspath $(FMS_BUILD))
override LDFLAGS += -L$(abspath $(FMS_BUILD))
$(info CFLAGS = $(CFLAGS))
$(info FCFLAGS = $(FCFLAGS))
$(info FMS_BUILD = $(FMS_BUILD))

include ../config/Libs.mk

$(BUILD)/$(TARGET): $(BUILD)/Makefile $(call find_src_files,$(CODEBASE))
	$(MAKE) -C $(BUILD) $(TARGET)
