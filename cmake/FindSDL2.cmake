# FindSDL2.cmake
# Locate SDL2 library
#
# This module defines:
#  SDL2_FOUND - system has SDL2
#  SDL2_INCLUDE_DIRS - the SDL2 include directories
#  SDL2_LIBRARIES - the libraries needed to use SDL2

# Find the SDL2 include directory
find_path(SDL2_INCLUDE_DIR
    NAMES SDL.h
    PATHS
        /usr/local/include/SDL2
        /usr/include/SDL2
        /opt/homebrew/include/SDL2
        /usr/local/opt/sdl2/include/SDL2
        $ENV{SDL2DIR}/include/SDL2
    PATH_SUFFIXES SDL2
)

# Find the SDL2 library
find_library(SDL2_LIBRARY
    NAMES SDL2
    PATHS
        /usr/local/lib
        /usr/lib
        /opt/homebrew/lib
        /usr/local/opt/sdl2/lib
        $ENV{SDL2DIR}/lib
)

# On Windows, also find SDL2main
if(WIN32)
    find_library(SDL2MAIN_LIBRARY
        NAMES SDL2main
        PATHS
            /usr/local/lib
            /usr/lib
            /opt/homebrew/lib
            /usr/local/opt/sdl2/lib
            $ENV{SDL2DIR}/lib
            $ENV{VCPKG_INSTALLATION_ROOT}/installed/x86-windows/lib
            $ENV{VCPKG_INSTALLATION_ROOT}/installed/x64-windows/lib
    )
endif()

# Handle the QUIETLY and REQUIRED arguments
include(FindPackageHandleStandardArgs)
if(WIN32)
    find_package_handle_standard_args(SDL2
        REQUIRED_VARS SDL2_LIBRARY SDL2MAIN_LIBRARY SDL2_INCLUDE_DIR
    )
else()
    find_package_handle_standard_args(SDL2
        REQUIRED_VARS SDL2_LIBRARY SDL2_INCLUDE_DIR
    )
endif()

if(SDL2_FOUND)
    # Set libraries - include SDL2main on Windows
    if(WIN32)
        set(SDL2_LIBRARIES ${SDL2MAIN_LIBRARY} ${SDL2_LIBRARY})
    else()
        set(SDL2_LIBRARIES ${SDL2_LIBRARY})
    endif()
    
    # Set SDL2_INCLUDE_DIRS to the parent directory so <SDL2/SDL.h> works
    get_filename_component(SDL2_INCLUDE_PARENT "${SDL2_INCLUDE_DIR}" DIRECTORY)
    set(SDL2_INCLUDE_DIRS ${SDL2_INCLUDE_PARENT})
    
    # Create imported target
    if(NOT TARGET SDL2::SDL2)
        add_library(SDL2::SDL2 UNKNOWN IMPORTED)
        set_target_properties(SDL2::SDL2 PROPERTIES
            IMPORTED_LOCATION "${SDL2_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${SDL2_INCLUDE_PARENT}"
        )
    endif()
endif()

mark_as_advanced(SDL2_INCLUDE_DIR SDL2_LIBRARY SDL2MAIN_LIBRARY)

