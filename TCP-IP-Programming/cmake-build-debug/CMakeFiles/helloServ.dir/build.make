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
include CMakeFiles/helloServ.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/helloServ.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/helloServ.dir/flags.make

CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o: CMakeFiles/helloServ.dir/flags.make
CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o: ../ch1/helloServ.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o -c /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch1/helloServ.cpp

CMakeFiles/helloServ.dir/ch1/helloServ.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/helloServ.dir/ch1/helloServ.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch1/helloServ.cpp > CMakeFiles/helloServ.dir/ch1/helloServ.cpp.i

CMakeFiles/helloServ.dir/ch1/helloServ.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/helloServ.dir/ch1/helloServ.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch1/helloServ.cpp -o CMakeFiles/helloServ.dir/ch1/helloServ.cpp.s

CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.requires:

.PHONY : CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.requires

CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.provides: CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.requires
	$(MAKE) -f CMakeFiles/helloServ.dir/build.make CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.provides.build
.PHONY : CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.provides

CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.provides.build: CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o


# Object files for target helloServ
helloServ_OBJECTS = \
"CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o"

# External object files for target helloServ
helloServ_EXTERNAL_OBJECTS =

helloServ: CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o
helloServ: CMakeFiles/helloServ.dir/build.make
helloServ: CMakeFiles/helloServ.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable helloServ"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/helloServ.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/helloServ.dir/build: helloServ

.PHONY : CMakeFiles/helloServ.dir/build

CMakeFiles/helloServ.dir/requires: CMakeFiles/helloServ.dir/ch1/helloServ.cpp.o.requires

.PHONY : CMakeFiles/helloServ.dir/requires

CMakeFiles/helloServ.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/helloServ.dir/cmake_clean.cmake
.PHONY : CMakeFiles/helloServ.dir/clean

CMakeFiles/helloServ.dir/depend:
	cd /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles/helloServ.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/helloServ.dir/depend

