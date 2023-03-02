#!/bin/bash
[[ -d artifacts ]] && rm -r artifacts
mkdir artifacts
cp -R delta_team/build/web artifacts
