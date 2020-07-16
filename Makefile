## Build Settings
# Name of generated executable
OBJNAME :=  dslc

# Source code locations
INCFLDRS := include
SRCFLDRS := src test
LIBFLDRS := lib

# Compiler settings
CPPC :=     g++
LD :=       g++

ifdef DEBUG
CPPFLAGS := -g -Wall -std=c++17
else
CPPFLAGS := -O2 -std=c++17
endif

LDFLAGS :=  

## Auto generation
# Construct actual file name lists from folders
INC :=      $(addprefix -I,$(INCFLDRS))
LIB :=      $(addprefix -L,$(LIBFLDRS))
HFILES :=   $(foreach folder,$(INCFLDRS),$(wildcard $(folder)/*.hpp))
SRC :=      $(foreach folder,$(SRCFLDRS),$(wildcard $(folder)/*.cpp))
LIBFILES := $(foreach folder,$(SRCFLDRS),$(wildcard $(folder)/*))

## Targets
# Main compiler
$(OBJNAME) : $(SRC) $(HFILES) $(LIBFILES)
	mkdir -p obj
	$(foreach file,$(SRC),$(CPPC) $(INC) $(CPPFLAGS) -o obj/$(basename $(notdir $(file))).o -c $(file);)
	$(LD) $(LIB) $(foreach file,$(SRC),obj/$(basename $(notdir $(file))).o) $(LDFLAGS) -o $(OBJNAME)


# Clean up
.PHONY : clean
clean :
	rm -rf obj/
	rm $(OBJNAME)
	