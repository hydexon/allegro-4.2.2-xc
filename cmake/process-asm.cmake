file(GLOB ASSEMBLY_SRCS ${ROOT_DIR}/src/*.s ${ROOT_DIR}/src/dos/*.s ${ROOT_DIR}/src/misc/*.s ${ROOT_DIR}/src/i386/*.s)

foreach(F IN LISTS ASSEMBLY_SRCS)
     get_filename_component(FO_FILE ${F} NAME)
     file(RELATIVE_PATH F ${ROOT_DIR} ${F})
     file(TO_NATIVE_PATH ${F} F)
     message(STATUS ${F})
     execute_process(COMMAND wcc386 "${F}" -p -I. -Iinclude -fo=obj\\watcom\\${FO_FILE} WORKING_DIRECTORY ${ROOT_DIR})
     #break()
endforeach()

set(DJGPP_AS "E:/djgpp/bin/i586-pc-msdosdjgpp-as.exe")

file(GLOB ASM_OBJSRC ${ROOT_DIR}/obj/watcom/*.s)


foreach(F IN LISTS ASM_OBJSRC)
     get_filename_component(FO_FILE ${F} NAME_WE)
     set(FO_FILE ${FO_FILE}.o)
     file(RELATIVE_PATH F ${ROOT_DIR} ${F})
     #file(TO_NATIVE_PATH ${F} F)
     #message(STATUS "File: ${F} | FO: ${FO_FILE}")
     execute_process(COMMAND ${DJGPP_AS} -o obj/watcom/${FO_FILE} ${F})
     FILE(REMOVE ${F})
endforeach()