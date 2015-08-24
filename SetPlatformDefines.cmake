# -------------------------------------------------------------------------------------------
# DM_PLATFORM_IOS
# DM_PLATFORM_OSX
# DM_PLATFORM_LINUX
# DM_PLATFORM_ANDROID
#
# Author: Alessandro Saccoia <alessandro@dinahmoe.com>
# --------------------------------------------------------------------------------------------

FUNCTION(SET_PLATFORM_DEFINES)
#  IF(NOT DEFINED PLATFORM_DEFINES_SET)
    IF (APPLE)
      IF(NOT DEFINED BUILD_FOR)
        SET(BUILD_FOR "osx" CACHE INTERNAL "Flag to specify cross compiling on mac OS")
        MESSAGE("BUILD_FOR not specified. defaulting to osx")
      ENDIF(NOT DEFINED BUILD_FOR)
      IF("${BUILD_FOR}" STREQUAL "ios" )
        IF(NOT DEFINED IOS_ARCH)
          SET(IOS_ARCH "arm" CACHE INTERNAL "Flag to specify ios build type")
          MESSAGE("IOS_ARCH not specified. defaulting to arm")
          SET(IOS_ARCH "arm")
        ENDIF(NOT DEFINED IOS_ARCH)
        
        IF("${IOS_ARCH}" STREQUAL "arm" )
          ADD_DEFINITIONS("-DDM_PLATFORM_IOS_ARM=1")
        ELSEIF("${IOS_ARCH}" STREQUAL "simulator" )
          ADD_DEFINITIONS("-DDM_PLATFORM_IOS_SIMULATOR=1")
        ENDIF()

        ADD_DEFINITIONS("-DDM_PLATFORM_IOS=1")
      ELSEIF("${BUILD_FOR}" STREQUAL "osx")	
        ADD_DEFINITIONS("-DDM_PLATFORM_OSX=1")
      ENDIF() 
      ADD_DEFINITIONS("-DDM_PLATFORM_APPLE=1")
    ELSEIF(ANDROID)
      SET(BUILD_FOR "android" CACHE INTERNAL "Flag to specify cross compiling on mac OS")
      ADD_DEFINITIONS("-DDM_PLATFORM_ANDROID=1")
    ELSEIF(WIN32) # cygwin
      ADD_DEFINITIONS("-DDM_PLATFORM_CYGWIN=1")
    ELSEIF(UNIX)
      IF(NOT DEFINED BUILD_FOR)
        ADD_DEFINITIONS("-DDM_PLATFORM_LINUX=1")
      ENDIF()
      IF("${BUILD_FOR}" STREQUAL "raspberrypi" )
        ADD_DEFINITIONS("-DDM_PLATFORM_RASPBERRYPI=1")
      ENDIF()
    ELSEIF(LINUX)
      IF(NOT DEFINED BUILD_FOR)
        ADD_DEFINITIONS("-DDM_PLATFORM_LINUX=1")
      ENDIF()
      IF("${BUILD_FOR}" STREQUAL "raspberrypi" )
        ADD_DEFINITIONS("-DDM_PLATFORM_RASPBERRYPI=1")
      ENDIF()
    ENDIF()
    SET(PLATFORM_DEFINES_SET TRUE CACHE INTERNAL "Indicates wether this file has been executed or not" )
#  ENDIF(NOT DEFINED PLATFORM_DEFINES_SET)
ENDFUNCTION()

