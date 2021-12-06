# clear logcat
adb logcat --clear

# uninstall previous app versions
adb uninstall de.schilken.timeout_examples
adb uninstall de.schilken.timeout_examples.test


# install test runner app on device
adb install app-debug.apk

# install system under test on device
adb install app-debug-androidTest.apk

# lists all test runner on the device
adb shell pm list instrumentation

# runs the integration tests on the device
adb shell am instrument -w de.schilken.timeout_examples.test > test_results.txt

# clear log buffer
adb logcat -c

# get logcat output for tests filtered for flutter 
adb logcat -d  "flutter:D *:S" > logcat.txt