run:
    npm run tauri dev

build_a:
    pnpm tauri android build

install_a:
    adb install ~/code/phasor-integration-demo/src-tauri/gen/android/app/build/outputs/apk/universal/release/app-universal-release.apk

check_deps:
    echo "Checking environment variables:"
    echo $JAVA_HOME
    if test -d "$JAVA_HOME"; then echo "JAVA_HOME is set and exists"; else $((_ERRORS++)); echo "JAVA_HOME is not set"; fi;
    echo $ANDROID_HOME
    if test -d "$ANDROID_HOME"; then echo "ANDROID_HOME is set and exists"; else echo "ANDROID_HOME is not set"; fi;
    echo $NDK_HOME
    if test -d "$NDK_HOME"; then echo "NDK_HOME is set and exists"; else echo "NDK_HOME is not set"; fi;
    echo "Checking rustup targets (android only):"
    rustup target list | grep -n "aarch64-linux-android";
    rustup target list | grep -n "armv7-linux-androideabi";
    rustup target list | grep -n "i686-linux-android";
    rustup target list | grep -n "x86_64-linux-android";