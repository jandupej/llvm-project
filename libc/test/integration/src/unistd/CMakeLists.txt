add_custom_target(unistd-integration-tests)
add_dependencies(libc-integration-tests unistd-integration-tests)

add_integration_test(
  fork_test
  SUITE
    unistd-integration-tests
  SRCS
    fork_test.cpp
  LOADER
    libc.loader.linux.crt1
  DEPENDS
    libc.include.errno
    libc.include.signal
    libc.include.sys_wait
    libc.include.unistd
    libc.src.pthread.pthread_atfork
    libc.src.signal.raise
    libc.src.sys.wait.wait
    libc.src.sys.wait.wait4
    libc.src.sys.wait.waitpid
    libc.src.unistd.fork
)

add_executable(
  libc_execv_test_normal_exit
  EXCLUDE_FROM_ALL
  execv_test_normal_exit.cpp
)
set_target_properties(
  libc_execv_test_normal_exit
  PROPERTIES
    OUTPUT_NAME libc_execv_test_normal_exit
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_executable(
  libc_execv_test_signal_exit
  EXCLUDE_FROM_ALL
  execv_test_signal_exit.cpp
)
set_target_properties(
  libc_execv_test_signal_exit
  PROPERTIES
    OUTPUT_NAME libc_execv_test_signal_exit
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_integration_test(
  execv_test
  SUITE
    unistd-integration-tests
  SRCS
    execv_test.cpp
  LOADER
    libc.loader.linux.crt1
  DEPENDS
    libc_execv_test_normal_exit
    libc_execv_test_signal_exit
    libc.include.errno
    libc.src.sys.wait.waitpid
    libc.src.unistd.execv
    libc.src.unistd.fork
  ENV
    EXECV_TEST=PASS
)

add_integration_test(
  execve_test
  SUITE
    unistd-integration-tests
  SRCS
    execve_test.cpp
  LOADER
    libc.loader.linux.crt1
  DEPENDS
    libc_execv_test_normal_exit
    libc_execv_test_signal_exit
    libc.include.errno
    libc.src.sys.wait.waitpid
    libc.src.unistd.execve
    libc.src.unistd.fork
  ENV
    EXECV_TEST=PASS
)
