if( USE_PCH )
	include_directories(${CMAKE_CURRENT_BINARY_DIR})
endif()

file(GLOB sources_localdir *.cpp *.h)

if (USE_PCH)
  set(sharethoughtserver_PCH_HDR PrecompiledHeaders/serverPCH.h)
  set(sharethoughtserver_PCH_SRC PrecompiledHeaders/serverPCH.cpp)
endif()

set(sharethoughtserver_SRCS
  ${sharethoughtserver_SRCS}
  ${sources_CommandLine}
  ${sources_localdir}
)

if( WIN32 )
  set(sharethoughtserver_SRCS
    ${sharethoughtserver_SRCS}
    #${sources_windows_Debugging}
  )
  if ( MSVC )
    set(sharethoughtserver_SRCS
      ${sharethoughtserver_SRCS}
      sharethoughtserver.rc
    )
  endif()
endif()

include_directories(
  	${CMAKE_BINARY_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}
	${OPENSSL_INCLUDE_DIR}
	${MYSQL_INCLUDE_DIR}
	${MYSQLCONNECTORCPP_INCLUDE_DIR}
)

add_executable(sharethought_server
	${sharethoughtserver_SRCS}
  	${sharethoughtserver_PCH_SRC}
)


add_dependencies(sharethought_server revision.h)

if( UNIX AND NOT NOJEM AND NOT APPLE )
  set(sharethoughtserver_LINK_FLAGS "-pthread -lncurses ${sharethoughtserver_LINK_FLAGS}")
endif()

set_target_properties(sharethought_server PROPERTIES LINK_FLAGS "${sharethoughtserver_LINK_FLAGS}")

target_link_libraries(sharethought_server
  ${JEMALLOC_LIBRARY}
  ${OPENSSL_LIBRARIES}
  ${CMAKE_THREAD_LIBS_INIT}
  ${Boost_LIBRARIES}
  ${MYSQL_LIBRARY}
  ${MYSQLCONNECTORCPP_LIBRARY}
)



if( UNIX )
	install(TARGETS sharethought_server DESTINATION bin)
endif()


if( USE_PCH )
	add_cxx_pch(sharethought_server ${sharethoughtserver_PCH_HDR} ${sharethoughtserver_PCH_SRC})
endif()
