================================================================================
                    SMART RETINA - HOW TO RUN THE PROJECT
================================================================================

This guide will help you run the Smart Retina Flutter app on different platforms.

================================================================================
                        PREREQUISITES (INSTALL FIRST)
================================================================================

1. FLUTTER SDK
   - Download from: https://flutter.dev/docs/get-started/install
   - Choose your operating system (Windows, macOS, Linux)
   - Follow the installation steps for your OS
   - Add Flutter to your system PATH

2. VERIFY INSTALLATION
   Open terminal/command prompt and run:
   
   flutter doctor
   
   This will show what's installed and what's missing.

================================================================================
                        INITIAL PROJECT SETUP
================================================================================

1. EXTRACT THE PROJECT
   - Unzip the project folder to your desired location
   - Example: C:\Projects\smart_retina (Windows)
   - Example: ~/Projects/smart_retina (Mac/Linux)

2. OPEN TERMINAL IN PROJECT FOLDER
   - Navigate to the project root folder (where pubspec.yaml is located)
   - Windows: Right-click in folder → "Open in Terminal" or use Command Prompt
   - Mac: Right-click → "New Terminal at Folder" or use Terminal app
   - Linux: Right-click → "Open in Terminal"

3. INSTALL DEPENDENCIES
   Run this command in the project folder:
   
   flutter pub get
   
   This downloads all required packages for the project.

================================================================================
                          RUN ON WINDOWS
================================================================================

OPTION 1: Using Command Line
-----------------------------
1. Make sure you're in the project folder
2. Run:
   
   flutter run -d windows
   
3. The app will build and launch as a Windows desktop application

OPTION 2: Using Visual Studio Code
-----------------------------------
1. Install Visual Studio Code
2. Install Flutter extension in VS Code
3. Open the project folder in VS Code
4. Press F5 or click "Run" → "Start Debugging"
5. Select "Windows (windows-x64)" from the device list

OPTION 3: Using Android Studio
-------------------------------
1. Install Android Studio
2. Install Flutter plugin
3. Open the project folder
4. Click the device dropdown → Select "Windows (desktop)"
5. Click the green play button (Run)

================================================================================
                          RUN ON macOS
================================================================================

OPTION 1: Using Command Line
-----------------------------
1. Make sure you're in the project folder
2. Run:
   
   flutter run -d macos
   
3. The app will build and launch as a macOS desktop application

OPTION 2: Using Visual Studio Code
-----------------------------------
1. Install Visual Studio Code
2. Install Flutter extension in VS Code
3. Open the project folder in VS Code
4. Press F5 or click "Run" → "Start Debugging"
5. Select "macOS (darwin)" from the device list

OPTION 3: Using Android Studio
-------------------------------
1. Install Android Studio
2. Install Flutter plugin
3. Open the project folder
4. Click the device dropdown → Select "macOS (desktop)"
5. Click the green play button (Run)

================================================================================
                    RUN ON ANDROID MOBILE DEVICE
================================================================================

PREREQUISITES:
- Android device with USB debugging enabled
- USB cable to connect device to computer

ENABLE USB DEBUGGING ON ANDROID:
1. Go to Settings → About Phone
2. Tap "Build Number" 7 times (enables Developer Options)
3. Go back to Settings → Developer Options
4. Enable "USB Debugging"
5. Connect device via USB
6. Accept the debugging prompt on your phone

RUN THE APP:
------------
Method 1: Automatic Device Detection
1. Connect your Android device via USB
2. In project folder, run:
   
   flutter devices
   
   This shows all connected devices
3. Run:
   
   flutter run
   
   Flutter will automatically detect your device

Method 2: Specify Device by ID
1. Get your device ID:
   
   flutter devices
   
   Example output: "Samsung Galaxy (01147352011)"
2. Run with device ID:
   
   flutter run -d 01147352011
   
   (Replace 01147352011 with your actual device ID)

Method 3: Using Android Studio
1. Connect Android device via USB
2. Open project in Android Studio
3. Device should appear in the device dropdown
4. Click the green play button (Run)

TROUBLESHOOTING:
- If device not detected: Check USB cable, try different port
- If "unauthorized": Accept debugging prompt on phone
- If still issues: Run "flutter doctor" to check setup

================================================================================
                    RUN ON iOS MOBILE DEVICE (Mac Only)
================================================================================

PREREQUISITES:
- macOS computer (iOS development only works on Mac)
- Xcode installed from App Store
- Apple Developer account (free or paid)
- iOS device

SETUP:
1. Install Xcode from Mac App Store
2. Open Xcode, accept license agreement
3. Connect your iOS device via USB
4. Trust the computer on your iPhone (popup will appear)

RUN THE APP:
------------
1. In project folder, run:
   
   flutter devices
   
   Your iPhone should appear in the list
2. Run:
   
   flutter run
   
   Or specify device:
   
   flutter run -d [device-id]

FIRST TIME SETUP:
- Xcode will ask you to register your device
- You may need to select a development team in Xcode
- Open ios/Runner.xcworkspace in Xcode to configure signing

================================================================================
                        RUN ON WEB BROWSER
================================================================================

ENABLE WEB SUPPORT (One-time setup):
------------------------------------
Run this command:

flutter config --enable-web

VERIFY WEB IS ENABLED:
----------------------
flutter devices

You should see "Chrome (web)" in the device list

RUN IN CHROME:
--------------
Method 1: Default Browser
   flutter run -d chrome

Method 2: Any Browser
   flutter run -d web-server
   
   Then open the URL shown (usually http://localhost:XXXX) in any browser

Method 3: Build for Production
   flutter build web
   
   This creates a "build/web" folder
   Deploy this folder to any web hosting service

OPEN IN BROWSER:
After running, the app automatically opens in Chrome
Or manually visit: http://localhost:PORT (PORT will be shown in terminal)

================================================================================
                    RUN ON ANDROID EMULATOR
================================================================================

SETUP ANDROID EMULATOR:
-----------------------
1. Install Android Studio
2. Open Android Studio → Tools → AVD Manager
3. Click "Create Virtual Device"
4. Select a device (e.g., Pixel 4)
5. Select a system image (e.g., Android 11)
6. Click Finish

RUN ON EMULATOR:
----------------
1. Start the emulator:
   - Open AVD Manager in Android Studio
   - Click the play button next to your emulator
   
   OR use command line:
   
   flutter emulators
   flutter emulators --launch [emulator-id]

2. Run the app:
   
   flutter run
   
   Flutter will detect the running emulator

================================================================================
                      RUN ON iOS SIMULATOR (Mac Only)
================================================================================

SETUP:
------
1. Install Xcode from Mac App Store
2. iOS Simulator is included with Xcode

START SIMULATOR:
----------------
1. Open Simulator from Applications folder
   OR run from terminal:
   
   open -a Simulator

2. Choose a device from the Simulator menu
   Hardware → Device → [Select iPhone model]

RUN THE APP:
------------
   flutter run
   
   Flutter will automatically detect the simulator

================================================================================
                        COMMON COMMANDS
================================================================================

Check Flutter Installation:
   flutter doctor

List All Available Devices:
   flutter devices

Install Dependencies:
   flutter pub get

Clean Build Files:
   flutter clean

Run on Specific Device:
   flutter run -d [device-id]

Run in Release Mode (Faster):
   flutter run --release

Build APK for Android:
   flutter build apk

Build for Web:
   flutter build web

Build for Windows:
   flutter build windows

Build for macOS:
   flutter build macos

Hot Reload (while app is running):
   Press 'r' in terminal

Hot Restart (while app is running):
   Press 'R' in terminal

Quit Running App:
   Press 'q' in terminal

================================================================================
                          TROUBLESHOOTING
================================================================================

ISSUE: "flutter: command not found"
SOLUTION: Flutter is not in your system PATH. Reinstall Flutter and add to PATH.

ISSUE: "No devices available"
SOLUTION: 
   - For mobile: Connect device or start emulator/simulator
   - For desktop: Run "flutter config --enable-[platform]"
   - For web: Run "flutter config --enable-web"

ISSUE: "Gradle build failed" (Android)
SOLUTION: 
   - Update Android SDK in Android Studio
   - Run "flutter clean" then "flutter pub get"

ISSUE: "Pod install failed" (iOS)
SOLUTION:
   - cd ios
   - pod install
   - cd ..
   - flutter run

ISSUE: App building very slowly
SOLUTION:
   - First build always takes long (5-10 minutes)
   - Subsequent builds are much faster
   - Use "flutter run --release" for faster builds

ISSUE: Hot reload not working
SOLUTION:
   - Press 'R' for full restart
   - If still not working, stop and run "flutter run" again

================================================================================
                      RECOMMENDED TOOLS
================================================================================

EDITORS:
1. Visual Studio Code (Recommended for beginners)
   - Install Flutter extension
   - Install Dart extension
   
2. Android Studio (Full-featured IDE)
   - Install Flutter plugin
   - Install Dart plugin

3. IntelliJ IDEA
   - Install Flutter plugin
   - Install Dart plugin

DEBUGGING TOOLS:
- Flutter DevTools: flutter pub global activate devtools
- Chrome DevTools (for web)

================================================================================
                          QUICK START GUIDE
================================================================================

FOR ABSOLUTE BEGINNERS:

1. Install Flutter SDK from https://flutter.dev
2. Open Terminal/Command Prompt
3. Navigate to project folder:
   cd path/to/smart_retina
4. Run:
   flutter pub get
5. Run:
   flutter run

Flutter will automatically find an available device and run the app!

================================================================================
                        PLATFORM REQUIREMENTS
================================================================================

WINDOWS:
   - Windows 10 or later
   - Visual Studio 2022 (for desktop apps)
   - Android Studio (for Android apps)

macOS:
   - macOS 10.14 or later
   - Xcode (for iOS/macOS apps)
   - CocoaPods (automatically installed with Xcode)

LINUX:
   - Any modern Linux distribution
   - Required libraries (check "flutter doctor")

ANDROID:
   - Android SDK (via Android Studio)
   - Android device with USB debugging
   OR Android Emulator

iOS:
   - macOS computer (required)
   - Xcode installed
   - Apple Developer account
   - iOS device OR iOS Simulator

WEB:
   - Any modern web browser
   - No additional requirements

================================================================================
                          NEED MORE HELP?
================================================================================

Official Flutter Documentation:
   https://docs.flutter.dev

Flutter Installation Guide:
   https://docs.flutter.dev/get-started/install

Flutter Troubleshooting:
   https://docs.flutter.dev/resources/bug-reports

YouTube Tutorial:
   Search "Flutter installation [your-os]" on YouTube

Community Support:
   - Stack Overflow: https://stackoverflow.com/questions/tagged/flutter
   - Flutter Discord: https://discord.gg/flutter
   - Reddit: https://reddit.com/r/flutterdev

================================================================================
                              END OF GUIDE
================================================================================