FROM ubuntu:15.04

MAINTAINER futabooo <mail@futabooo.com>

RUN \
  apt-get update -y && apt-get install -y curl unzip

# Install Java7, Java6
RUN \
#  apt-get install -y openjdk-8-jdk && \
  apt-get install -y openjdk-7-jdk openjdk-6-jdk

# Install Android SDK
RUN \
  cd /tmp && \
  curl -L -O http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
  tar xf android-sdk_r24.4.1-linux.tgz -C /opt && \
  rm android-sdk_r24.4.1-linux.tgz
  echo y | /opt/android-sdk-linux/tools/android update sdk --no-ui --all --filter tools && \
  echo y | /opt/android-sdk-linux/tools/android update sdk --no-ui --all --filter platform-tools,build-tools-23.0.2,android-23 && \
  echo y | /opt/android-sdk-linux/tools/android update sdk --no-ui --all --filter extra-google-google_play_services,extra-google-m2repository,extra-android-m2repository

# Install Gradle
RUN \
  cd /tmp && \
  curl -L -O http://services.gradle.org/distributions/gradle-2.10-all.zip && \
  unzip gradle-2.10-all.zip -d /opt && \
  rm gradle-2.10-all.zip

# Setup Environment
ENV \
  JAVA8_HOME /usr/lib/jvm/java-8-openjdk-amd64 \
  JAVA7_HOME /usr/lib/jvm/java-7-openjdk-amd64 \
  JAVA6_HOME /usr/lib/jvm/java-6-openjdk-amd64 \
  JAVA_HOME JAVA8_HOME \
  ANDROID_HOME /opt/android-sdk-linux \
  GRADLE_HOME /opt/gradle-2.10 \
  PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platfomr-tools:$GRADLE_HOME/bin
