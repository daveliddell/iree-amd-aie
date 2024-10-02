# Copyright 2023 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#-------------------------------------------------------------------------------
# Experimental XRT HAL driver
# Enable with: -DIREE_EXTERNAL_HAL_DRIVERS=xrt
#-------------------------------------------------------------------------------

iree_add_all_subdirs()

if(NOT DEFINED HIP_API_HEADERS_ROOT)
  set(HIP_API_HEADERS_ROOT "${IREE_SOURCE_DIR}/third_party/hip-build-deps/include")
endif()

if(NOT EXISTS "${HIP_API_HEADERS_ROOT}/hip/hip_version.h")
  message(SEND_ERROR "Could not find HIP headers at: ${HIP_API_HEADERS_ROOT}")
endif()

iree_register_external_hal_driver(
  NAME
    xrt
  DRIVER_TARGET
    iree-amd-aie::driver::xrt::registration
  REGISTER_FN
    iree_hal_xrt_driver_module_register
)

iree_cc_library(
  NAME
    xrt
  HDRS
    "api.h"
  SRCS
    "api.h"
    "direct_allocator.h"
    "direct_allocator.cc"
    "direct_command_buffer.h"
    "direct_command_buffer.cc"
    "xrt_buffer.h"
    "xrt_buffer.cc"
    "xrt_device.cc"
    "xrt_driver.cc"
    "native_executable.h"
    "native_executable.cc"
    "nop_semaphore.cc"
    "nop_executable_cache.h"
    "nop_executable_cache.cc"
  INCLUDES
    "${HIP_API_HEADERS_ROOT}"
  DEPS
    iree::base
    iree::base::core_headers
    iree::base::internal::arena
    iree::base::internal::flatcc::building
    iree::base::internal::flatcc::parsing
    iree::hal::utils::deferred_command_buffer
    iree::hal::utils::file_transfer
    iree::hal
    iree-amd-aie::schemas::xrt_executable_def_c_fbs
    # hide the target from all exports so it doesn't need to be installed
    # (effectively only available for link time symbol resolution)
    # note this requires CMake >= 3.26
    $<BUILD_LOCAL_INTERFACE:xrt_coreutil>
    $<BUILD_LOCAL_INTERFACE:xrt_hip>
  COPTS
    $<$<PLATFORM_ID:Linux>:-fexceptions -frtti>
    $<$<PLATFORM_ID:Windows>:/EHsc /GR>
  PUBLIC
)
