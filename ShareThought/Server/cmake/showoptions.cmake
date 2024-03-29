# output generic information about the core and buildtype chosen
message("")
if( UNIX )
  message("* ShareThought_Server buildtype			: ${CMAKE_BUILD_TYPE}")
endif()
message("")

# output information about installation-directories and locations

message("* Install core to			: ${CMAKE_INSTALL_PREFIX}")
if( UNIX )
  message("* Install libraries to		: ${LIBSDIR}")
  message("* Install configs to			: ${CONF_DIR}")
endif()
message("")

# Show infomation about the options selected during configuration

if( SERVER )
  message("* Build server			: Yes (default)")
else()
  message("* Build server			: No")
endif()

if( USE_PCH )
  message("* Build server w/PCH			: Yes (default)")
else()
  message("* Build server w/PCH			: No")
endif()

if( WITH_WARNINGS )
  message("* Show all warnings			: Yes")
else()
  message("* Show compile-warnings		: No  (default)")
endif()

if( WITH_COREDEBUG )
  message("* Use coreside debug			: Yes")
  add_definitions(-DTUMORS_DEBUG)
else()
  message("* Use coreside debug			: No  (default)")
endif()

if( WIN32 )
  if( USE_MYSQL_SOURCES )
    message("* Use MySQL sourcetree		: Yes (default)")
  else()
    message("* Use MySQL sourcetree		: No")
  endif()
endif( WIN32 )

if ( WITHOUT_GIT )
  message("* Use GIT revision hash		: No")
  message("")
  message(" *** WITHOUT_GIT - WARNING!")
  message(" *** By choosing the WITHOUT_GIT option you have waived all rights for support,")
  message(" *** and accept that or all requests for support or assistance sent to the core")
  message(" *** developers will be rejected. This due to that we will be unable to detect")
  message(" *** what revision of the codebase you are using in a proper way.")
  message(" *** We remind you that you need to use the repository codebase and a supported")
  message(" *** version of git for the revision-hash to work, and be allowede to ask for")
  message(" *** support if needed.")
else()
  message("* Use GIT revision hash		: Yes")
endif()

if ( NOJEM )
  message("")
  message(" *** NOJEM - WARNING!")
  message(" *** jemalloc linking has been disabled!")
  message(" *** Please note that this is for DEBUGGING WITH VALGRIND only!")
  message(" *** DO NOT DISABLE IT UNLESS YOU KNOW WHAT YOU'RE DOING!")
endif()

message("")

