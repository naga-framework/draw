#!/bin/bash

COOKIE=cookie_draw
NODE_NAME=draw@127.0.0.1
CONFIG=sys.config
export ERL_EPMD_ADDRESS="127.0.0.1"
./mad deps comp repl -name $NODE_NAME


