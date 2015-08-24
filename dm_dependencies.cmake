#
# Date: 4/15/2015
# Author: Alessandro Saccoia <alessandro@dinahmoe.com>
#
# These functions are meant to be used together.
# - DM_START_TARGET() creates/cleans the following in the caller scope
#   ${DM_CURRENT_TARGET_LINK_FLAGS} linker flags
#   ${DM_CURRENT_TARGET_COMPILE_FLAGS}
#
# - DM_USE_LIBRARY(LIBRARY_NAME)
#   creates a global variable that says wether the library specified has
#   already been included or not. if not, calls add_subdirectory. then looks
#   for LIBRARY_NAME_COMPILE_FLAGS and LIBRARY_NAME_LINK_FLAGS and adds them
#   to the aforementioned variables
#
# example:
# DM_START_TARGET()
# DM_USE_LIBRARY("dm-utils", "${CMAKE_CURRENT_SOURCE_DIR}/../dm-utils")
# SET_TARGET_PROPERTIES(parserTest PROPERTIES LINK_FLAGS "${DM_CURRENT_TARGET_LINK_FLAGS}")
# SET_TARGET_PROPERTIES(parserTest PROPERTIES COMPILE_FLAGS "${DM_CURRENT_TARGET_COMPILE_FLAGS}")

FUNCTION(DM_START_TARGET)
  SET(DM_CURRENT_TARGET_COMPILE_FLAGS "" PARENT_SCOPE)
  SET(DM_CURRENT_TARGET_LINKER_FLAGS "" PARENT_SCOPE)
ENDFUNCTION()

FUNCTION(DM_USE_LIBRARY LIBRARY_NAME LIBRARY_PATH)
  IF(NOT DEFINED DM_CURRENT_TARGET_COMPILE_FLAGS)
    MESSAGE(FATAL "Please call DM_START_TARGET() before using DM_USE_LIBRARY")
  ENDIF()
  IF(NOT DEFINED DM_CURRENT_TARGET_LINKER_FLAGS)
    MESSAGE(FATAL "Please call DM_START_TARGET() before using DM_USE_LIBRARY")
  ENDIF()
  IF(NOT DEFINED ${LIBRARY_NAME}_INCLUDED)
    SET(${LIBRARY_NAME}_INCLUDED TRUE CACHE INTERNAL ${LIBRARY_NAME})
    ADD_SUBDIRECTORY(${LIBRARY_PATH} ${LIBRARY_NAME})
  ENDIF()
  INCLUDE_DIRECTORIES(${LIBRARY_PATH}/include)
  IF(DEFINED ${LIBRARY_NAME}_COMPILE_FLAGS)
    SET(DM_CURRENT_TARGET_COMPILE_FLAGS "${DM_CURRENT_TARGET_COMPILE_FLAGS} ${LIBRARY_NAME}_COMPILE_FLAGS" PARENT_SCOPE)
  ENDIF()
  IF(DEFINED ${LIBRARY_NAME}_LINK_FLAGS)
    SET(DM_CURRENT_TARGET_LINK_FLAGS "${DM_CURRENT_TARGET_LINK_FLAGS} ${LIBRARY_NAME}_LINK_FLAGS" PARENT_SCOPE)
  ENDIF()
ENDFUNCTION()