FROM tmalseed/jenkins-android:ndk-latest

USER root

# Install jq, make & xz
# jq is used for parsing changelog json when notifying Discord of successful builds
# make & xz-utils are used for building exoplayer with the ndk

RUN apt-get update \
    && apt-get install jq -y \
    && apt-get install make -y \
    && apt-get install xz-utils -y

USER ${user}
