if(${actual_stderr_var} MATCHES "A required privilege is not held by the client")
  unset(msg)
else()
  if(NOT IS_DIRECTORY ${RunCMake_TEST_BINARY_DIR}/L)
    set(RunCMake_TEST_FAILED "Symlink 'L' not replaced correctly!")
  endif()
endif()