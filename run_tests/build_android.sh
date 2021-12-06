# change path to android
cd ../android

# build test runner app -> ../build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk
./gradlew app:assembleAndroidTest

# build system under test
./gradlew app:assembleDebug -Ptarget="integration_test/first_test.dart"

# go back path to integration_test_app/.run-tests
cd ../run_tests

# copy test runner
cp ../build/app/outputs/apk/debug/app-debug.apk ./app-debug.apk

# copy system under test
cp ../build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk ./app-debug-androidTest.apk

