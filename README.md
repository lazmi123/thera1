# Thera1 - Therapy Management App

A Flutter application for managing therapy sessions, connecting parents with therapists, and facilitating appointment scheduling.

## Features

- **User Authentication**: Firebase-powered authentication with role-based access (Parent, Therapist, Admin)
- **Parent Features**:
  - Add child symptoms and get AI-powered therapist recommendations
  - View available therapists with specializations
  - Book and manage appointments
  - Track appointment history

- **Therapist Features**:
  - Manage profile and specializations
  - View and confirm appointments
  - Track client information

- **Admin Features**:
  - Manage all users (parents and therapists)
  - Oversee all appointments
  - System analytics and settings

## Firebase Setup

⚠️ **IMPORTANT**: Firebase must be configured before you can run this app.

### Quick Start (30-40 minutes)

For a step-by-step guide with exact commands, see: **[QUICK_START.md](QUICK_START.md)** 🚀

### What You'll Need

1. Flutter SDK installed
2. A Google account for Firebase
3. Node.js (for Firebase CLI)

### Setup Overview

1. Install Firebase CLI and FlutterFire CLI
2. Create a Firebase project
3. Run `flutterfire configure`
4. Enable Authentication, Firestore, and Storage
5. Deploy security rules
6. Run `flutter pub get`
7. Run your app!

### Documentation

- 🚀 **[DELL_WINDOWS_QUICK_REFERENCE.md](DELL_WINDOWS_QUICK_REFERENCE.md)** - Quick commands for Dell/Windows ⭐
- 📥 **[INSTALL_NODEJS.md](INSTALL_NODEJS.md)** - Download & install Node.js
- 📖 **[QUICK_START.md](QUICK_START.md)** - Fast setup guide (recommended)
- 💻 **[WINDOWS_SETUP.md](WINDOWS_SETUP.md)** - Windows/Dell specific instructions
- 📖 **[FIREBASE_SETUP.md](FIREBASE_SETUP.md)** - Comprehensive documentation
- ⚠️ **[IMPORTANT_NOTES.md](IMPORTANT_NOTES.md)** - Critical information about the setup

### Security Rules

Security rules for Firestore and Storage are provided in:
- `firestore.rules` - Firestore database security rules
- `storage.rules` - Firebase Storage security rules

These files are ready to be deployed to your Firebase project.

## Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd thera1
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (see Firebase Setup section above)

4. **Run the app**:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point with Firebase initialization
├── models/
│   └── user_model.dart      # User data model
├── services/
│   └── auth_service.dart    # Firebase authentication service
├── screens/
│   ├── splash/              # Onboarding screens
│   ├── auth/                # Login and signup screens
│   └── home/
│       ├── parent/          # Parent-specific screens
│       ├── therapist/       # Therapist-specific screens
│       └── admin/           # Admin-specific screens
└── utils/
    ├── colors.dart          # App color scheme
    └── routes.dart          # Route constants
```

## User Roles

The app supports three user roles with different permissions:

### Parent
- Can add child symptoms and track development
- View available therapists with specializations
- Book and manage appointments
- View appointment history

### Therapist
- Manage professional profile and specializations
- View and respond to appointment requests
- Manage client appointments
- Access patient information

### Admin
- Full system access
- Manage all users (parents and therapists)
- Oversee all appointments
- System configuration and analytics

**Note**: To create an admin user, first create a regular account, then manually change the `role` field to `admin` in Firestore Database.

## Development Notes

- **Theme**: The app uses a consistent blue color scheme (`#4A90E2` primary)
- **Firebase Integration**: Complete authentication and database services implemented
- **Authentication**: Email/password authentication with role-based access control
- **Database**: Firestore for user data, appointments, and symptom tracking
- **Storage**: Firebase Storage for profile images and documents
- **State Management**: Uses StatefulWidget and setState (can be upgraded to Provider/Riverpod)

## Tech Stack

- **Framework**: Flutter 3.9+
- **Backend**: Firebase
  - Authentication (Email/Password)
  - Cloud Firestore (NoSQL Database)
  - Cloud Storage (File Storage)
- **Language**: Dart 3.9+
- **State Management**: StatefulWidget (basic)
- **Dependencies**:
  - `firebase_core` - Firebase initialization
  - `firebase_auth` - Authentication
  - `cloud_firestore` - Database
  - `firebase_storage` - File storage
  - `shared_preferences` - Local storage
  - `image_picker` - Image selection

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is private and proprietary.
