FROM jenkins/jenkins:lts-jdk11

ENV ANDROID_SDK_ROOT=/var/lib/android-sdk

# Download android SDK / tools
# SDK Tools location:
# https://developer.android.com/studio/index.html#command-tools
USER root
RUN apt-get update && apt-get install wget -y \
    && mkdir $ANDROID_SDK_ROOT \
    && cd $ANDROID_SDK_ROOT \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip 2> /dev/null \
    && unzip commandlinetools-linux-6858069_latest.zip -d temp \
    && mkdir -p cmdline-tools/latest \
    && mv temp/cmdline-tools/* cmdline-tools/latest \
    && rm -r temp \
    && rm commandlinetools-linux-6858069_latest.zip \
    && cd $JENKINS_HOME

# Install SDK packages & accept licenses
RUN cd $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/ \
    && ./sdkmanager \
    --update \
    --include_obsolete \
    && echo y | ./sdkmanager 'tools' \
    && echo y | ./sdkmanager 'platform-tools' \
    && echo y | ./sdkmanager 'build-tools;30.0.3' \
    && echo y | ./sdkmanager 'platforms;android-30' \
    && echo y | ./sdkmanager 'extras;google;m2repository' \
    && echo y | ./sdkmanager 'patcher;v4'

# Become Jenkins user again
USER ${user}
