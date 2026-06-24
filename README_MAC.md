# 🏥 Smart Retina App - AI-Powered Retinal Disease Detection

A Flutter-based mobile application for detecting retinal diseases using AI technology.

## 📱 App Screens

1. **Home View** (`/home`) - Landing page and navigation
2. **Login View** (`/login`) - User authentication
3. **Upload View** (`/upload`) - Upload retinal images for analysis
4. **Dashboard View** (`/dashboard`) - View analysis results and history

## 🚀 Quick Start for M1 Mac

### Automated Setup (Recommended)

```bash
cd ~/Downloads/smart_retina_app
chmod +x fix_and_run.sh
./fix_and_run.sh
```

The script will:
- Clean all build artifacts
- Install dependencies
- Set up iOS and macOS builds
- Show available devices
- Offer to run the app

### Manual Setup

1. **Clean the project**:
   ```bash
   flutter clean
   flutter pub get
   ```

2. **For macOS Desktop**:
   ```bash
   cd macos
   arch -arm64 pod install
   cd ..
   flutter run -d macos
   ```

3. **For iOS Simulator**:
   ```bash
   cd ios
   arch -arm64 pod install
   cd ..
   open -a Simulator
   flutter run
   ```

4. **For Web (Chrome)**:
   ```bash
   flutter run -d chrome
   ```

## 🔧 Dependencies

- **State Management**: Provider ^6.1.1
- **HTTP Client**: http ^1.1.0
- **Local Storage**: shared_preferences ^2.2.2
- **Image Selection**: image_picker ^1.0.7
- **UI Components**: cupertino_icons ^1.0.2

## 🎨 Theme

- Primary Color: Indigo (#6366F1)
- Background: Dark (#0A0B14)
- Font: Inter

## 📂 Project Structure

```
lib/
├── main.dart                      # App entry point
├── controllers/
│   ├── auth_controller.dart       # Authentication logic
│   └── upload_controller.dart     # Image upload & analysis
├── views/
│   ├── auth/
│   │   └── login_view.dart       # Login screen
│   ├── home/
│   │   └── home_view.dart        # Home screen
│   ├── upload/
│   │   └── upload_view.dart      # Upload screen
│   └── dashboard/
│       └── dashboard_view.dart   # Dashboard screen
├── models/
│   ├── user_model.dart           # User data model
│   └── diagnosis_model.dart      # Diagnosis data model
└── widgets/
    └── bottom_nav_bar.dart       # Navigation component
```

## ⚠️ M1 Mac Specific Issues & Fixes

### Problem 1: Architecture Mismatch
**Error**: `Unable to find a device matching the provided destination specifier: { platform:macOS, arch:arm64 }`

**Fix**: Always use `arch -arm64` when installing pods:
```bash
cd ios  # or macos
arch -arm64 pod install --repo-update
```

### Problem 2: Missing Dependencies
**Error**: `Couldn't resolve the package 'shared_preferences'`

**Fix**: 
```bash
flutter clean
rm pubspec.lock
flutter pub get
```

### Problem 3: Build Failures
**Error**: `Build process failed`

**Fix**:
```bash
flutter clean
rm -rf ios/Pods ios/Podfile.lock
rm -rf macos/Pods macos/Podfile.lock
flutter pub get
cd ios && arch -arm64 pod install && cd ..
cd macos && arch -arm64 pod install && cd ..
```

## 🔍 Check Flutter Setup

```bash
flutter doctor -v
```

This will show you any issues with your Flutter installation.

## 📱 Running on Different Platforms

### See Available Devices
```bash
flutter devices
```

### Run on Specific Device
```bash
flutter run -d "device_name"
```

Example:
```bash
flutter run -d "My Mac"
flutter run -d "iPhone 15 Pro"
flutter run -d "chrome"
```

## 🐛 Troubleshooting

### CocoaPods Issues
```bash
# Update CocoaPods
sudo gem install cocoapods

# Clean pod cache
cd ios  # or macos
rm -rf ~/Library/Caches/CocoaPods
rm -rf Pods Podfile.lock
arch -arm64 pod install --repo-update
```

### Simulator Not Starting
```bash
# Reset simulator
xcrun simctl shutdown all
xcrun simctl erase all

# Open simulator
open -a Simulator
```

### Build Still Failing
```bash
# Nuclear option - rebuild everything
flutter clean
rm -rf build/
rm -rf ios/Pods ios/.symlinks ios/Podfile.lock
rm -rf macos/Pods macos/.symlinks macos/Podfile.lock
rm pubspec.lock
flutter pub get
cd ios && arch -arm64 pod install && cd ..
cd macos && arch -arm64 pod install && cd ..
flutter run
```

## 📋 Development

### Running in Debug Mode
```bash
flutter run
```

### Running in Release Mode
```bash
flutter run --release
```

### Hot Reload
Press `r` in the terminal while the app is running.

### Hot Restart
Press `R` in the terminal while the app is running.

## 🏗️ Building for Production

### iOS
```bash
flutter build ios
```

### macOS
```bash
flutter build macos
```

### Web
```bash
flutter build web
```

## 📖 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Image Picker Package](https://pub.dev/packages/image_picker)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)

## 💡 Tips

1. **For M1 Macs**: Always use `arch -arm64 pod install`
2. **Quick Test**: Use `flutter run -d chrome` for fast iteration
3. **Clean Build**: Run `flutter clean` when switching between devices
4. **Check Logs**: Use `flutter run -v` for verbose output

## 🆘 Still Need Help?

If you're still having issues:

1. Check `SETUP_INSTRUCTIONS.md` for detailed troubleshooting
2. Run the automated `fix_and_run.sh` script
3. Ensure your Flutter version is up to date: `flutter upgrade`
4. Verify Xcode is properly installed: `xcode-select --install`

## 📄 License

This project is for educational and demonstration purposes.
