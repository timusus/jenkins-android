FROM tmalseed/jenkins-android:ndk-latest

USER root

# Install jq, make & xz
# jq is used for parsing changelog json when notifying Discord of successful builds
# make & xz-utils are used for building exoplayer with the ndk
RUN apt-get update \
    && apt-get install jq -y \
    && apt-get install make -y \
    && apt-get install xz-utils -y

# Seems to be required to allos emulator to run
RUN apt=get install libgl1-mesa-dev
    
# Install Android emulator image & create emulator
RUN cd $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/ \
    && ./sdkmanager --install "system-images;android-30;google_apis;x86_64" \
    && echo "no" | ./avdmanager --verbose create avd --force --name "android-30" --package "system-images;android-30;google_apis;x86_64" --abi google_apis/x86_64

USER ${user}
