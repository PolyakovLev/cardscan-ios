#!/bin/bash

# if we get an error bail
set -euxo pipefail

xcodebuild archive \
  -workspace ../CardScan.xcworkspace \
  -scheme CardScan \
  -destination "generic/platform=iOS" \
  -archivePath "build/CardScanArchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
  -workspace ../CardScan.xcworkspace \
  -scheme CardScan \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "build/CardScanSimulatorArchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
	   -framework "build/CardScanArchive.xcarchive/Products/Library/Frameworks/CardScan.framework" \
	   -framework "build/CardScanSimulatorArchive.xcarchive/Products/Library/Frameworks/CardScan.framework" \
	   -output ../CardScan.xcframework

cd build
cd ..
