# Dylan's Stack-based Language (DSL)

## Description

Dylan's Stack-based Language. A small toy language I decided to make. I'd like it to be fully featured enough to compile itself

It will, naturally, be stack-based. It will also ideally be esoteric and annoying to use.

My inspiration was the esolang "Emoji." It made me want to make a stack based language is all.

## Features

There are several features I plan to implement

- [ ] - pointers/references

- [ ] - c structs

- [ ] - simple stack manipulation

- [ ] - low level access/bindings to assembly or C or something

- [ ] - modules

- [ ] - boolean types

- [ ] - casts

- [ ] - compilation, not interpretation

## Build system

Just run `make`

## File structure

 - Source code (\*.cpp) files go in src/

 - Source code *that is tests* goes in tests/ however

 - Header files (\*.hpp) for the source files go in include/

 - Static library files go in lib/

To add external source/headers/lib, modify the \*FLDRS options in the Makefile

## Dependencies

 - gcc

 - make

 - gtest (`sudo pacman -S gtest` \|\| `sudo apt install libgtest-dev`)
