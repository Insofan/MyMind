# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/ch9getBuf.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ch9getBuf.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ch9getBuf.dir/flags.make

CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o: CMakeFiles/ch9getBuf.dir/flags.make
CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o: ../ch9/ch9getBuf.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o -c /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch9/ch9getBuf.cpp

CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch9/ch9getBuf.cpp > CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.i

CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch9/ch9getBuf.cpp -o CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.s

CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.requires:

.PHONY : CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.requires

CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.provides: CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.requires
	$(MAKE) -f CMakeFiles/ch9getBuf.dir/build.make CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.provides.build
.PHONY : CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.provides

CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.provides.build: CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o


# Object files for target ch9getBuf
ch9getBuf_OBJECTS = \
"CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o"

# External object files for target ch9getBuf
ch9getBuf_EXTERNAL_OBJECTS =

ch9getBuf: CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o
ch9getBuf: CMakeFiles/ch9getBuf.dir/build.make
ch9getBuf: CMakeFiles/ch9getBuf.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ch9getBuf"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ch9getBuf.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ch9getBuf.dir/build: ch9getBuf

.PHONY : CMakeFiles/ch9getBuf.dir/build

CMakeFiles/ch9getBuf.dir/requires: CMakeFiles/ch9getBuf.dir/ch9/ch9getBuf.cpp.o.requires

.PHONY : CMakeFiles/ch9getBuf.dir/requires

CMakeFiles/ch9getBuf.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ch9getBuf.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ch9getBuf.dir/clean

CMakeFiles/ch9getBuf.dir/depend:
	cd /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles/ch9getBuf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ch9getBuf.dir/depend

