set (doctest_lib_location ${CMAKE_SOURCE_DIR}/doctest)
set (doctest_registerlibrary_location ${CMAKE_SOURCE_DIR}/doctest_registerlibrary)


function (doctest_registercppfiles libraryName)
  get_target_property(sources ${libraryName} SOURCES)
  # Step 1 : Modify cpp files in order to add register function (see doctest_register.py -file)
  foreach(source ${sources})
    execute_process(COMMAND python ${doctest_registerlibrary_location}/doctest_registerlibrary.py -file ${source} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  endforeach(source)
  # Step 2 : Create doctest_registerlibrary.cpp file (call doctest_register.py -library)
  execute_process(COMMAND python ${doctest_registerlibrary_location}/doctest_registerlibrary.py -library ${sources} WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
endfunction()


function (doctest_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${doctest_lib_location}/doctest )
endfunction()


function (doctest_addincludepath libraryName)
  target_include_directories(${libraryName} PUBLIC ${doctest_lib_location}/doctest )
endfunction()


function (doctest_appendregisterlibrarycpp_tosources libraryName)
  get_target_property(sources ${libraryName} SOURCES)

  # Step 3 : append doctest_registerlibrary.cpp to the library sources if needed
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


function (doctest_registerlibrary libraryName)
  doctest_addincludepath(${libraryName})
  doctest_registercppfiles(${libraryName})
  doctest_appendregisterlibrarycpp_tosources(${libraryName})

  set(testTargetName ${libraryName}_DocTest)
  doctest_maketesttarget(${libraryName} ${testTargetName})
  doctest_register_ctest(${testTargetName})
endfunction()
