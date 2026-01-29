#!/bin/bash
set -e

echo "Emulator ready, running tests"
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
adb shell input keyevent 82

adb kill-server
adb start-server
adb wait-for-device

echo "Installing APK"
adb install -r apk/app-debug.apk

echo "Starting Appium"
appium --log-level error &
APPIUM_PID=$!
sleep 15

echo "Running tests"
python scripts/execute-tests.py
TEST_EXIT_CODE=$?

kill $APPIUM_PID || true
exit $TEST_EXIT_CODE