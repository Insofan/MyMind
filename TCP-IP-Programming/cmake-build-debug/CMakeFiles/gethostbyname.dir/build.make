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
include CMakeFiles/gethostbyname.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gethostbyname.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gethostbyname.dir/flags.make

CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o: CMakeFiles/gethostbyname.dir/flags.make
CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o: ../ch8/gethostbyname.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o -c /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch8/gethostbyname.cpp

CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch8/gethostbyname.cpp > CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.i

CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/ch8/gethostbyname.cpp -o CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.s

CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.requires:

.PHONY : CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.requires

CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.provides: CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.requires
	$(MAKE) -f CMakeFiles/gethostbyname.dir/build.make CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.provides.build
.PHONY : CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.provides

CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.provides.build: CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o


# Object files for target gethostbyname
gethostbyname_OBJECTS = \
"CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o"

# External object files for target gethostbyname
gethostbyname_EXTERNAL_OBJECTS =

gethostbyname: CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o
gethostbyname: CMakeFiles/gethostbyname.dir/build.make
gethostbyname: CMakeFiles/gethostbyname.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable gethostbyname"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gethostbyname.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gethostbyname.dir/build: gethostbyname

.PHONY : CMakeFiles/gethostbyname.dir/build

CMakeFiles/gethostbyname.dir/requires: CMakeFiles/gethostbyname.dir/ch8/gethostbyname.cpp.o.requires

.PHONY : CMakeFiles/gethostbyname.dir/requires

CMakeFiles/gethostbyname.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gethostbyname.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gethostbyname.dir/clean

CMakeFiles/gethostbyname.dir/depend:
	cd /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug /Users/inso/Desktop/Workspace/MyMind/TCP-IP-Programming/cmake-build-debug/CMakeFiles/gethostbyname.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gethostbyname.dir/depend

