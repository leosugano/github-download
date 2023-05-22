#!/bin/bash

set -eo pipefail

xcodebuild -workspace Github.xcworkspace \
            -scheme Github\
            -destination platform=iOS\ Simulator,OS=16.4,name=iPhone\ 11 \
            clean test | xcpretty