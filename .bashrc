# ~/.bashrc
export JAVA_HOME=/opt/homebrew/Caskroom/zulu@17/17.0.11,17.50.19
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
eval "$(starship init bash)"
