# alert_manager

A Grafana alert manager basic clone.

## See it running [here](alert-manager.surge.sh)

### Requirements

- To run this app you will need to install the [flutter dev tools](https://flutter.dev/docs/get-started/install).
I recommend to install Flutter master and [enable web](https://flutter.dev/docs/get-started/web) and [desktop support](https://flutter.dev/desktop) by running 

    *For desktop run*
    
    `flutter config --enable-macos-desktop`
    
    `flutter config --enable-linux-desktop`
    
    then
    
    `flutter run -d macos`
    
    `flutter run -d linux`
    
    *For web run *
    
    ` flutter config --enable-web` 
    
    then 
    
    `flutter run -d chrome` 
    
    to run it with Chrome (You need to have Chrome installed) 

- You'll also need to install Android Studio for the Android SDK. The Flutter installation guide will guide you, and you can see what you need to install by running `flutter doctor` after extracting the flutter sdk tools.

### Important packages used

- Provider / I decided to use Provider to manage the state of the app across the entire application.


For help getting started with Flutter, view 
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
