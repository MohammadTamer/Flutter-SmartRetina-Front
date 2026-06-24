# Smart Retina Mobile App

AI-Powered Retinal Disease Detection mobile application built with Flutter.

## Structure

```
lib/
├── models/
│   ├── user_model.dart          # User data model
│   └── diagnosis_model.dart     # Diagnosis data model
├── controllers/
│   ├── auth_controller.dart     # Login/logout API
│   └── upload_controller.dart   # Upload API
├── views/
│   ├── auth/
│   │   └── login_view.dart      # Login screen
│   ├── home/
│   │   └── home_view.dart       # Home page
│   ├── upload/
│   │   └── upload_view.dart     # Upload screen
│   └── dashboard/
│       └── dashboard_view.dart  # Dashboard screen
├── widgets/
│   └── bottom_nav_bar.dart      # Bottom navigation bar
└── main.dart
```

## Features

- ✅ User authentication (login/logout)
- ✅ Retinal image upload
- ✅ AI-powered disease diagnosis
- ✅ Dashboard with results
- ✅ Dark theme UI matching website
- ✅ Responsive design

## Setup

1. Install Flutter SDK
2. Clone repository
3. Run `flutter pub get`
4. Run `flutter run`

## API Integration

Update API base URL in:
- `lib/controllers/auth_controller.dart`
- `lib/controllers/upload_controller.dart`

Default: `https://smartretina.vercel.app/api`

## Supported Diseases

- Diabetic Retinopathy
- Age-Related Macular Degeneration
- Retinal Vein Occlusion
- Retinitis Pigmentosa
- Retinal Detachment

## Colors

- Background: `#0A0B14`
- Secondary: `#1A1B2E`
- Primary: `#6366F1`
- Text: `#FFFFFF`
- Muted: `#9CA3AF`
