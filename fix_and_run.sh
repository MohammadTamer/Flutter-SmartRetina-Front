#!/bin/bash

# Smart Retina App - Automated Fix Script for M1 Mac
# Run this script in your project directory

set -e  # Exit on error

echo "🏥 Smart Retina App - M1 Mac Fix Script"
echo "========================================"
echo ""

# Check if we're in a Flutter project
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: pubspec.yaml not found!"
    echo "Please run this script from your Flutter project directory."
    exit 1
fi

echo "📍 Current directory: $(pwd)"
echo ""

# Step 1: Clean everything
echo "🧹 Step 1: Cleaning project..."
flutter clean
rm -rf ios/.symlinks 2>/dev/null || true
rm -rf macos/.symlinks 2>/dev/null || true
rm -rf ios/Pods 2>/dev/null || true
rm -rf macos/Pods 2>/dev/null || true
rm -rf ios/Podfile.lock 2>/dev/null || true
rm -rf macos/Podfile.lock 2>/dev/null || true
rm -rf pubspec.lock 2>/dev/null || true
rm -rf build/ 2>/dev/null || true
echo "✅ Clean complete!"
echo ""

# Step 2: Get dependencies
echo "📦 Step 2: Getting Flutter dependencies..."
flutter pub get
echo "✅ Dependencies fetched!"
echo ""

# Step 3: Check for iOS
if [ -d "ios" ]; then
    echo "📱 Step 3: Setting up iOS (for Simulator)..."
    cd ios
    echo "   Installing CocoaPods dependencies..."
    arch -arm64 pod install --repo-update 2>&1 | grep -v "^\[" || true
    cd ..
    echo "✅ iOS setup complete!"
    echo ""
fi

# Step 4: Check for macOS
if [ -d "macos" ]; then
    echo "💻 Step 4: Setting up macOS..."
    cd macos
    echo "   Installing CocoaPods dependencies..."
    arch -arm64 pod install --repo-update 2>&1 | grep -v "^\[" || true
    cd ..
    echo "✅ macOS setup complete!"
    echo ""
fi

# Step 5: Check available devices
echo "🔍 Step 5: Checking available devices..."
flutter devices
echo ""

# Step 6: Provide run options
echo "🎉 Setup complete! Ready to run."
echo ""
echo "Choose how to run the app:"
echo ""
echo "Option 1 - Run on macOS (Desktop App):"
echo "   flutter run -d macos"
echo ""
echo "Option 2 - Run on iOS Simulator:"
echo "   open -a Simulator"
echo "   flutter run"
echo ""
echo "Option 3 - Run in Chrome (Quick Test):"
echo "   flutter run -d chrome"
echo ""
echo "💡 Tip: Use 'flutter devices' to see all available devices"
echo ""

# Ask user what they want to do
read -p "Would you like to run the app now? (macos/ios/chrome/no): " choice

case "$choice" in
    macos|m)
        echo "🚀 Launching on macOS..."
        flutter run -d macos
        ;;
    ios|i)
        echo "🚀 Opening iOS Simulator and launching app..."
        open -a Simulator
        sleep 3
        flutter run
        ;;
    chrome|c|web|w)
        echo "🚀 Launching in Chrome..."
        flutter run -d chrome
        ;;
    no|n|*)
        echo "👍 Okay! You can run the app later with one of the commands above."
        ;;
esac
