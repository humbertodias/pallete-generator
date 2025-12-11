# FindSDL2_image.cmake
# Locate SDL2_image library
#
# This module defines:
#  SDL2_IMAGE_FOUND - system has SDL2_image
#  SDL2_IMAGE_INCLUDE_DIRS - the SDL2_image include directories
#  SDL2_IMAGE_LIBRARIES - the libraries needed to use SDL2_image

# Find the SDL2_image include directory
find_path(SDL2_IMAGE_INCLUDE_DIR
    NAMES SDL_image.h
    PATHS
        /usr/local/include/SDL2
        /usr/include/SDL2
        /opt/homebrew/include/SDL2
        /usr/local/opt/sdl2_image/include/SDL2
        $ENV{SDL2IMAGEDIR}/include/SDL2
    PATH_SUFFIXES SDL2
)

# Find the SDL2_image library
find_library(SDL2_IMAGE_LIBRARY
    NAMES SDL2_image
    PATHS
        /usr/local/lib
        /usr/lib
        /opt/homebrew/lib
        /usr/local/opt/sdl2_image/lib
        $ENV{SDL2IMAGEDIR}/lib
)

# Handle the QUIETLY and REQUIRED arguments
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2_image
    REQUIRED_VARS SDL2_IMAGE_LIBRARY SDL2_IMAGE_INCLUDE_DIR
)

if(SDL2_IMAGE_FOUND)
    set(SDL2_IMAGE_LIBRARIES ${SDL2_IMAGE_LIBRARY})
    # Set SDL2_IMAGE_INCLUDE_DIRS to the parent directory so <SDL2/SDL_image.h> works
    get_filename_component(SDL2_IMAGE_INCLUDE_PARENT "${SDL2_IMAGE_INCLUDE_DIR}" DIRECTORY)
    set(SDL2_IMAGE_INCLUDE_DIRS ${SDL2_IMAGE_INCLUDE_PARENT})
    
    # Create imported target
    if(NOT TARGET SDL2::SDL2_image)
        add_library(SDL2::SDL2_image UNKNOWN IMPORTED)
        set_target_properties(SDL2::SDL2_image PROPERTIES
            IMPORTED_LOCATION "${SDL2_IMAGE_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${SDL2_IMAGE_INCLUDE_PARENT}"
        )
    endif()
endif()

mark_as_advanced(SDL2_IMAGE_INCLUDE_DIR SDL2_IMAGE_LIBRARY)

