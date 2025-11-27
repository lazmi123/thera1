# Firebase Setup Guide for Thera1 App

This guide will help you connect your Flutter app to Firebase.

## Prerequisites
- Flutter SDK installed
- A Google account
- Node.js installed (for Firebase CLI)

## Step 1: Install Required Tools

### Install Firebase CLI
```bash
npm install -g firebase-tools
```

### Install FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

Make sure the Dart pub global bin directory is in your PATH:
- **macOS/Linux**: Add `export PATH="$PATH":"$HOME/.pub-cache/bin"` to your shell profile
- **Windows**: Add `%USERPROFILE%\AppData\Local\Pub\Cache\bin` to your PATH

## Step 2: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or "Create a project"
3. Enter project name: `thera1-app` (or your preferred name)
4. (Optional) Enable Google Analytics
5. Click "Create project" and wait for it to be created

## Step 3: Configure Firebase for Your Flutter App

### Login to Firebase
```bash
firebase login
```

### Run FlutterFire Configure
In your project directory (`/workspace`), run:

```bash
flutterfire configure
```

This command will:
- Prompt you to select your Firebase project
- Ask which platforms you want to support (select all that you need):
  - Android
  - iOS
  - macOS
  - Web
- Automatically generate `lib/firebase_options.dart`
- Add configuration files to each platform:
  - `android/app/google-services.json`
  - `ios/Runner/GoogleService-Info.plist`
  - `macos/Runner/GoogleService-Info.plist`

## Step 4: Enable Firebase Services

### Enable Authentication
1. In Firebase Console, go to **Authentication**
2. Click **Get Started**
3. Enable **Email/Password** sign-in method:
   - Click on "Email/Password"
   - Toggle "Enable" switch
   - Click "Save"

### Enable Cloud Firestore
1. In Firebase Console, go to **Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** (for development) or **production mode** (for production)
4. Select a location (choose closest to your users)
5. Click "Enable"

### Enable Firebase Storage (for profile images)
1. In Firebase Console, go to **Storage**
2. Click **Get started**
3. Choose **Start in test mode** (for development)
4. Click "Done"

## Step 5: Configure Firestore Security Rules

In Firebase Console, go to **Firestore Database** → **Rules** and add:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper function to check if user is authenticated
    function isSignedIn() {
      return request.auth != null;
    }
    
    // Helper function to check if user owns the document
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    // Helper function to check if user is admin
    function isAdmin() {
      return isSignedIn() && 
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
    
    // Users collection
    match /users/{userId} {
      // Anyone can read user profiles
      allow read: if isSignedIn();
      // Users can create their own profile
      allow create: if isSignedIn() && request.auth.uid == userId;
      // Users can update their own profile, or admin can update any
      allow update: if isOwner(userId) || isAdmin();
      // Only admin can delete users
      allow delete: if isAdmin();
    }
    
    // Appointments collection
    match /appointments/{appointmentId} {
      // Users can read their own appointments, therapists can read their appointments
      allow read: if isSignedIn() && (
        resource.data.parentId == request.auth.uid ||
        resource.data.therapistId == request.auth.uid ||
        isAdmin()
      );
      // Parents can create appointments
      allow create: if isSignedIn();
      // Users can update their own appointments, therapists can update appointments assigned to them
      allow update: if isSignedIn() && (
        resource.data.parentId == request.auth.uid ||
        resource.data.therapistId == request.auth.uid ||
        isAdmin()
      );
      // Only admin can delete appointments
      allow delete: if isAdmin();
    }
    
    // Default: deny all other access
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

## Step 6: Configure Storage Security Rules

In Firebase Console, go to **Storage** → **Rules** and add:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User profile images
    match /profile_images/{userId}/{allPaths=**} {
      // Users can read any profile image
      allow read: if request.auth != null;
      // Users can only write to their own folder
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Default: deny all other access
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

## Step 7: Install Flutter Dependencies

```bash
flutter pub get
```

## Step 8: Test Your Setup

### For Android:
```bash
flutter run -d android
```

### For iOS:
```bash
cd ios
pod install
cd ..
flutter run -d ios
```

### For Web:
```bash
flutter run -d chrome
```

## Step 9: Create Test Users

You can create test users in two ways:

1. **Through the app**: Use the signup screen
2. **Through Firebase Console**:
   - Go to Authentication → Users
   - Click "Add user"
   - Enter email and password

### Creating an Admin User

After creating a user through the signup screen or Firebase Console:

1. Go to **Firestore Database**
2. Find the `users` collection
3. Find the user document by their UID
4. Click on the document
5. Find the `role` field and change it from `parent` to `admin`
6. Click "Update"

## Troubleshooting

### Error: "Default FirebaseApp is not initialized"
- Make sure you ran `flutterfire configure`
- Check that `lib/firebase_options.dart` exists
- Verify that platform-specific config files exist:
  - Android: `android/app/google-services.json`
  - iOS: `ios/Runner/GoogleService-Info.plist`

### Error: "No Firebase App '[DEFAULT]' has been created"
- Ensure `Firebase.initializeApp()` is called in `main.dart`
- Check that you're using the correct Firebase options

### Build Errors on Android
- Make sure your `android/build.gradle` has the Google Services plugin
- Check that `minSdkVersion` is at least 21 in `android/app/build.gradle`

### Build Errors on iOS
- Run `cd ios && pod install && cd ..`
- Open `ios/Runner.xcworkspace` (not `.xcodeproj`) in Xcode
- Check that the bundle identifier matches your Firebase iOS app

## Database Structure

Your app uses the following Firestore collections:

### users
```
{
  "uid": "string",
  "email": "string",
  "name": "string",
  "role": "parent" | "therapist" | "admin",
  "phoneNumber": "string?",
  "profileImageUrl": "string?",
  "createdAt": "timestamp",
  "updatedAt": "timestamp?",
  
  // Therapist-specific fields
  "specialization": "string?",
  "yearsOfExperience": "number?",
  "rating": "number?",
  "location": "string?",
  "availability": ["string"]?,
  "isActive": "boolean?"
}
```

### appointments (to be created when you add appointment features)
```
{
  "id": "string",
  "parentId": "string",
  "therapistId": "string",
  "childName": "string",
  "symptoms": "string",
  "appointmentDate": "timestamp",
  "status": "pending" | "confirmed" | "completed" | "cancelled",
  "createdAt": "timestamp",
  "updatedAt": "timestamp?"
}
```

## Next Steps

1. Run the setup commands above
2. Test authentication by creating a new account
3. Create an admin user by modifying a user's role in Firestore
4. Test different user roles (parent, therapist, admin)

## Support

If you encounter any issues:
- Check the [FlutterFire documentation](https://firebase.flutter.dev/)
- Review the [Firebase documentation](https://firebase.google.com/docs)
- Check your console logs for specific error messages
