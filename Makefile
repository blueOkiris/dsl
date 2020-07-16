## Build Settings
# Name of generated executable
OBJNAME :=      dslc

# Source code locations
INCFLDRS :=     include
SRCFLDRS :=     src
TESTSRCFLDRS := test
LIBFLDRS :=     lib

# Compiler settings
CPPC :=         g++
LD :=           g++

ifdef DEBUG
CPPFLAGS :=     -g -Wall -std=c++17
else
CPPFLAGS :=     -O2 -std=c++17
endif

LDFLAGS :=      

## Auto generation
# Construct actual file name lists from folders
INC :=          $(addprefix -I,$(INCFLDRS))
LIB :=          $(addprefix -L,$(LIBFLDRS))
HFILES :=       $(foreach folder,$(INCFLDRS),$(wildcard $(folder)/*.hpp))
SRC :=          $(foreach folder,$(SRCFLDRS),$(wildcard $(folder)/*.cpp))
TESTSRC :=      $(foreach folder,$(TESTSRCFLDRS),$(wildcard $(folder)/*.cpp))
LIBFILES :=     $(foreach folder,$(SRCFLDRS),$(wildcard $(folder)/*))

## Targets
.PHONY : all
all : $(OBJNAME) $(OBJNAME)-tests
	echo "Done."

# Main compiler
$(OBJNAME) : $(SRC) $(HFILES) $(LIBFILES)
	mkdir -p obj
	$(foreach file,$(SRC),$(CPPC) $(INC) $(CPPFLAGS) -o obj/$(basename $(notdir $(file))).o -c $(file);)
	$(LD) $(LIB) $(foreach file,$(SRC),obj/$(basename $(notdir $(file))).o) $(LDFLAGS) -o $(OBJNAME)

# Google test files
obj/gtest_main.o :
	$(CPPC) $(INC) $(CPPFLAGS) -o obj/gtest_main.o -c /usr/src/googletest/src/gtest_main.cc

obj/gtest-all.o :
	$(CPPC) $(INC) -I/usr/src/googletest/ $(CPPFLAGS) -o obj/gtest-all.o -c /usr/src/googletest/src/gtest-all.cc

# Unit tests
$(OBJNAME)-tests : $(TESTSRC) $(HFILES) $(LIBFILES) obj/gtest_main.o obj/gtest-all.o
	mkdir -p obj
	$(foreach file,$(TESTSRC),$(CPPC) $(INC) $(CPPFLAGS) -o obj/$(basename $(notdir $(file))).o -c $(file);)
	$(LD) $(LIB) $(foreach file,$(TESTSRC),obj/$(basename $(notdir $(file))).o) obj/gtest_main.o obj/gtest-all.o $(LDFLAGS) -lpthread -o $(OBJNAME)-tests

# Clean up
.PHONY : clean
clean :
	rm -rf obj/
	rm -f $(OBJNAME)
	rm -f $(OBJNAME)-tests
