#!/bin/bash

stack clean
stack build --profile
stack install
stack exec --profile -- haskell-fold-exe +RTS -p < input.txt 