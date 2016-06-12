set (doctest_lib_location ${CMAKE_SOURCE_DIR}/doctest)
set (doctest_registerlibrary_location ${CMAKE_SOURCE_DIR}/doctest_registerlibrary)


function (doctest_registercppfiles libraryName)
  get_target_property(sources ${libraryName} SOURCES)
  # doctest_registercppfiles is a dependency of the library, so that
  # it will be called during the build
  add_custom_target(doctest_registercppfiles_${libraryName} COMMAND python ${doctest_registerlibrary_location}/doctest_registerlibrary.py -registercppfiles ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_dependencies(${libraryName} doctest_registercppfiles_${libraryName})

endfunction()

function (doctest_create_registermainfile libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # execute_process is executed during cmake : this is important, otherwise
  # the first cmake might fail if the file doctest_registerlibrary.cpp
  # was not yet created
  execute_process(COMMAND python ${doctest_registerlibrary_location}/doctest_registerlibrary.py -registermainfile ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

  # Also execute this step during the build
  add_custom_target(doctest_create_registermainfile${libraryName} COMMAND python ${doctest_registerlibrary_location}/doctest_registerlibrary.py -registermainfile ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  add_dependencies(${libraryName} doctest_create_registermainfile${libraryName})
  if(TARGET doctest_registercppfiles_${libraryName})
    add_dependencies(doctest_create_registermainfile${libraryName} doctest_registercppfiles_${libraryName})
  endif()
endfunction()


function (doctest_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${doctest_lib_location}/doctest )
endfunction()


function (doctest_appendregisterlibrarycpp_tosources libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # append doctest_registerlibrary.cpp to the library sources if needed
  if (NOT ";${SOURCES};" MATCHES ";doctest_registerlibrary.cpp;")
    set(sourcesWithRegisterDocTest ${SOURCES} doctest_registerlibrary.cpp)
    target_sources(${libraryName} PRIVATE ${sourcesWithRegisterDocTest})
  endif()
endfunction()

function (doctest_maketesttarget libraryName testTargetName)
  add_executable(${testTargetName} ${doctest_registerlibrary_location}/doctest_main.cpp)
  target_link_libraries(${testTargetName} ${libraryName})
endfunction()

function (doctest_register_ctest testTargetName)
  add_test(NAME ${testTargetName} COMMAND ${testTargetName})
endfunction()


function (doctest_registerlibrary libraryName testTargetName)
  message(doctest_registerlibrary ${libraryName})
  doctest_addincludepath(${libraryName})
  doctest_registercppfiles(${libraryName})
  doctest_create_registermainfile(${libraryName})
  doctest_appendregisterlibrarycpp_tosources(${libraryName})

  doctest_maketesttarget(${libraryName} ${testTargetName})
  doctest_register_ctest(${testTargetName})
endfunction()
