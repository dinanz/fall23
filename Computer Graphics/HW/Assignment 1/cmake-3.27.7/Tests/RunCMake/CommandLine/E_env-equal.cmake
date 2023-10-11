if (NOT DEFINED ENV{TEST_ENV_EXPECTED})
    if (NOT DEFINED ENV{TEST_ENV})
        message(STATUS "TEST_ENV is correctly not set in environment")
    else ()
        message(FATAL_ERROR "TEST_ENV is incorrectly set in environment")
    endif ()
else ()
    if (NOT DEFINED ENV{TEST_ENV})
        message(FATAL_ERROR "TEST_ENV is incorrectly not set in environment")
    elseif ("$ENV{TEST_ENV}" STREQUAL "$ENV{TEST_ENV_EXPECTED}")
        message(STATUS "TEST_ENV is correctly set in environment: $ENV{TEST_ENV}")
    else ()
        message(FATAL_ERROR "TEST_ENV is incorrectly set in environment!\n\tactual: $ENV{TEST_ENV}\n\texpected: $ENV{TEST_ENV_EXPECTED}")
    endif ()
endif ()
