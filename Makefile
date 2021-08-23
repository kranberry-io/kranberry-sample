### BUILD ####
buildDebug:
	./gradlew assembleDebug

buildAndroidTestDebug:
	./gradlew assembleDebugAndroidTest

### INSTALL ###
installDebug:
	adb install app/build/outputs/apk/debug/app-debug.apk

installAndroidTestDebug:
	adb install app/build/outputs/apk/androidTest/debug/app-debug-androidTest.apk

buildInstallDebug: buildDebug installDebug

### TEST ###
testDebug:
	./gradlew testDebug

testFileDebug:
	./gradlew testDebug --tests $(file)

androidTestDebug:
	./gradlew connectedDebugAndroidTest

androidTestDebugModule:
	./gradlew :$(module):connectedDebugAndroidTest

androidTestFileDebugModule:
	./gradlew :$(module):connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=$(file)

clear-logcat-logs:
	@adb shell logcat -b all -c

copy-tests-outputs:
	@rm -rf kranberry-outputs; \
	mkdir kranberry-outputs; \
	adb pull /storage/emulated/0/Android/media/io.kranberry.sample kranberry-outputs; \

### RUN UI TESTS ###
# before run tests make sure to call: buildDebug buildAndroidTestDebug installDebug installAndroidTestDebug
test: buildDebug buildAndroidTestDebug installDebug installAndroidTestDebug clear-logcat-logs
	@adb logcat *:S KRANBERRY_LOG:V & LOGCAT_PID=$$!; \
	TERM=dumb adb shell am instrument -w io.kranberry.sample.test/androidx.test.runner.AndroidJUnitRunner ; \
	RESULT=$$?; \
	if [ -n "$$LOGCAT_PID" ]; then kill $$LOGCAT_PID; fi; \
	exit $$RESULT

run-kranberry:
	@make test && make copy-tests-outputs
