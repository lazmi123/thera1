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

### Prerequisites
1. Install Flutter SDK
2. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

### Configuration Steps

1. **Create a Firebase Project**:
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project or select an existing one

2. **Configure FlutterFire**:
   ```bash
   flutterfire configure
   ```
   This command will:
   - Create a `firebase_options.dart` file
   - Configure Firebase for iOS, Android, and Web platforms

3. **Enable Authentication**:
   - In Firebase Console, go to Authentication
   - Enable Email/Password sign-in method

4. **Create Firestore Database**:
   - In Firebase Console, go to Firestore Database
   - Create a database (start in test mode for development)
   - Set up security rules (see below)

5. **Set up Firebase Storage** (optional):
   - In Firebase Console, go to Storage
   - Enable Storage for profile pictures

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
      allow create: if request.auth != null;
    }
    
    // Appointments collection
    match /appointments/{appointmentId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        (request.auth.uid == resource.data.parentId || 
         request.auth.uid == resource.data.therapistId ||
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin');
      allow delete: if request.auth != null &&
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    // Symptoms collection
    match /symptoms/{symptomId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        (request.auth.uid == resource.data.parentId ||
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin');
    }
  }
}
```

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

### Parent
- Email: any email (without 'therapist' or 'admin')
- Can add child symptoms, view therapists, and manage appointments

### Therapist
- Email: contains 'therapist'
- Can manage profile, view appointments, and manage clients

### Admin
- Email: contains 'admin'
- Full system access for user and appointment management

## Development Notes

- **Theme**: The app uses a consistent blue color scheme (`#4A90E2` primary)
- **Firebase Ready**: All services are structured to work with Firebase
- **Mock Data**: Screens include mock data for development/testing
- **TODO Comments**: Look for `// TODO:` comments to find Firebase integration points

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
