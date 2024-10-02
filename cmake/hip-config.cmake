# Copyright 2024 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# Substitute .cmake file for enabling the build of XRT HIP.
# When the XRT HIP subdirectory builds, it normally looks for a .cmake file
# from an installation of HIP (for example, under /opt/rocm).  This one takes
# the place of the installed one to redirect the build to use IREE's HIP
# headers instead of the ones from the HIP installation.

message("Using local HIP include files for IREE")
set(IREE_HIP_SOURCE_DIR "${IREE_AMD_AIE_SOURCE_DIR}/third_party/iree/third_party/hip-build-deps")
set(HIP_INCLUDE_DIR "${IREE_HIP_SOURCE_DIR}/include")
set(HIP_INCLUDE_DIRS "${HIP_INCLUDE_DIR}")
