add_llvm_library(
  LibcUnitTest
  Test.cpp
  Test.h
  LINK_COMPONENTS Support
)
target_include_directories(LibcUnitTest PUBLIC ${LIBC_SOURCE_DIR})
add_dependencies(LibcUnitTest standalone_cpp)
