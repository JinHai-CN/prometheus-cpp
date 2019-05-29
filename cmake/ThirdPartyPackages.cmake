# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# ----------------------------------------------------------------------
# bzip2

message(STATUS "Building CivetWeb from source")
set(CIVETWEB_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/civetweb_ep-prefix/src/civetweb_ep")
set(CIVETWEB_INCLUDE_DIR "${CIVETWEB_PREFIX}/include")
set(CIVETWEB_CXX_INCLUDE_DIR "${CIVETWEB_PREFIX}/include")
set(MAKE "make")

set(CIVETWEB_STATIC_LIB
        "${CIVETWEB_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}civetweb${CMAKE_STATIC_LIBRARY_SUFFIX}")
set(CIVETWEB_LIBRARY
        "${CIVETWEB_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}civetweb${CMAKE_STATIC_LIBRARY_SUFFIX}")
set(CIVETWEB_CXX_LIBRARY
        "${CIVETWEB_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}civetweb${CMAKE_STATIC_LIBRARY_SUFFIX}")
message(STATUS ${CIVETWEB_PREFIX}/lib)
externalproject_add(civetweb_ep
                    ${EP_LOG_OPTIONS}
                    CONFIGURE_COMMAND
                    ""
                    BUILD_IN_SOURCE
                    1
                    BUILD_COMMAND
                    ${MAKE}
                    "PREFIX=${CIVETWEB_PREFIX}/lib"
                    INSTALL_COMMAND
                    ${MAKE}
                    PREFIX=${CIVETWEB_PREFIX} install-lib
                    URL
                    https://github.com/civetweb/civetweb/archive/v1.11.tar.gz
                    BUILD_BYPRODUCTS
                    "${CIVETWEB_STATIC_LIB}")

file(MAKE_DIRECTORY "${CIVETWEB_INCLUDE_DIR}")
add_library(civetweb STATIC IMPORTED)
set_target_properties(
        civetweb
        PROPERTIES IMPORTED_LOCATION "${CIVETWEB_STATIC_LIB}"
        INTERFACE_INCLUDE_DIRECTORIES "${CIVETWEB_INCLUDE_DIR}")

add_dependencies(civetweb civetweb_ep)

link_directories(SYSTEM ${CIVETWEB_PREFIX})
include_directories(SYSTEM "${CIVETWEB_INCLUDE_DIR}")
