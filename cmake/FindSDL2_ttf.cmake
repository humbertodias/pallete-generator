# FindSDL2_ttf.cmake
# Locate SDL2_ttf library
#
# This module defines:
#  SDL2_TTF_FOUND - system has SDL2_ttf
#  SDL2_TTF_INCLUDE_DIRS - the SDL2_ttf include directories
#  SDL2_TTF_LIBRARIES - the libraries needed to use SDL2_ttf

# Find the SDL2_ttf include directory
find_path(SDL2_TTF_INCLUDE_DIR
    NAMES SDL_ttf.h
    PATHS
        /usr/local/include/SDL2
        /usr/include/SDL2
        /opt/homebrew/include/SDL2
        /usr/local/opt/sdl2_ttf/include/SDL2
        $ENV{SDL2TTFDIR}/include/SDL2
    PATH_SUFFIXES SDL2
)

# Find the SDL2_ttf library
find_library(SDL2_TTF_LIBRARY
    NAMES SDL2_ttf
    PATHS
        /usr/local/lib
        /usr/lib
        /opt/homebrew/lib
        /usr/local/opt/sdl2_ttf/lib
        $ENV{SDL2TTFDIR}/lib
)

# Handle the QUIETLY and REQUIRED arguments
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2_ttf
    REQUIRED_VARS SDL2_TTF_LIBRARY SDL2_TTF_INCLUDE_DIR
)

if(SDL2_TTF_FOUND)
    set(SDL2_TTF_LIBRARIES ${SDL2_TTF_LIBRARY})
    # Set SDL2_TTF_INCLUDE_DIRS to the parent directory so <SDL2/SDL_ttf.h> works
    get_filename_component(SDL2_TTF_INCLUDE_PARENT "${SDL2_TTF_INCLUDE_DIR}" DIRECTORY)
    set(SDL2_TTF_INCLUDE_DIRS ${SDL2_TTF_INCLUDE_PARENT})
    
    # Create imported target
    if(NOT TARGET SDL2::SDL2_ttf)
        add_library(SDL2::SDL2_ttf UNKNOWN IMPORTED)
        set_target_properties(SDL2::SDL2_ttf PROPERTIES
            IMPORTED_LOCATION "${SDL2_TTF_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${SDL2_TTF_INCLUDE_PARENT}"
        )
    endif()
endif()

mark_as_advanced(SDL2_TTF_INCLUDE_DIR SDL2_TTF_LIBRARY)

