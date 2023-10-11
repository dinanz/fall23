include("${CMAKE_CURRENT_LIST_DIR}/CMP0111-imported-target-prelude.cmake")

set_location(executable LOCATION "${CMAKE_CURRENT_BINARY_DIR}/executable${CMAKE_EXECUTABLE_SUFFIX}")

set_location(shared LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_SHARED_LIBRARY_PREFIX}shared${CMAKE_SHARED_LIBRARY_SUFFIX}")
if (CMAKE_IMPORT_LIBRARY_SUFFIX)
  set_location(shared IMPLIB "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_IMPORT_LIBRARY_PREFIX}shared${CMAKE_IMPORT_LIBRARY_SUFFIX}")
endif ()

set_location(static LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_IMPORT_LIBRARY_PREFIX}static${CMAKE_IMPORT_LIBRARY_SUFFIX}")
set_location(unknown LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_IMPORT_LIBRARY_PREFIX}unknown${CMAKE_IMPORT_LIBRARY_SUFFIX}")
set_location(module LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_SHARED_MODULE_PREFIX}module${CMAKE_SHARED_MODULE_SUFFIX}")

set_location(interface LIBNAME "interface")
