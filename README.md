# NutriSnap Flutter Application

## How to Run

1.  Install required Android platform/NDK (only once):

    & "$HOME/AppData/Local/Android/Sdk/cmdline-tools/latest/bin/sdkmanager.bat" "platforms;android-36" "ndk;27.0.12077973"

2.  Fetch deps and regenerate code:

    flutter pub get
    dart run build_runner build --delete-conflicting-outputs

3.  Run on your emulator/device:

    flutter run -d emulator   # or your device id

Notes: The app now builds and runs; you may see a quick RenderFlex overflow message in the results screen on very small widths—adjust padding if needed.

# Backend

SAAD RAHMAN WARSI 300249227