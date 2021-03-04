FROM tmalseed/jenkins-android:latest

USER root

# Install Cmake & NDK
RUN cd $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/ \
    && ./sdkmanager \
    --update \
    --include_obsolete \
    && echo y | ./sdkmanager 'cmake;3.10.2.4988404' \
    && echo y | ./sdkmanager 'ndk;21.4.7075529'

# Become Jenkins user again
USER ${user}
