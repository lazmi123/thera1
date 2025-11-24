# Troubleshoot "No Database Connected" Error

You're seeing the splash screens but then getting a red error screen saying "no database connected". Let's fix this step by step.

## 🔍 Step 1: Check What Error Message Says Exactly

When you see the red screen, look for the **exact error message**. Common ones:

- "FirebaseException: [permission-denied]"
- "FirebaseException: Missing or insufficient permissions"
- "FirebaseException: [not-found]"
- "No Firebase App '[DEFAULT]' has been created"

**Tell me the exact error** and I can help faster!

## ✅ Step 2: Verify Firebase Services Are Actually Enabled

Go to Firebase Console: https://console.firebase.google.com/

Select your project: **thera1-app**

### Check #1: Authentication

1. Click **"Authentication"** in left sidebar
2. Do you see the **"Users"** tab at the top?
   - ✅ **YES** = Authentication is enabled
   - ❌ **NO** = You see "Get started" button - Click it and enable Email/Password

### Check #2: Firestore Database

1. Click **"Firestore Database"** in left sidebar
2. Do you see **"Data"** tab with an empty database or collections?
   - ✅ **YES** = Firestore is enabled
   - ❌ **NO** = You see "Create database" button - You need to create it
     - Make sure billing is enabled first
     - Click "Create database"
     - Select "Start in test mode"
     - Choose region
     - Click "Enable"

### Check #3: Storage

1. Click **"Storage"** in left sidebar
2. Do you see **"Files"** tab?
   - ✅ **YES** = Storage is enabled
   - ❌ **NO** = You see "Get started" button - Click it
     - Select "Start in test mode"
     - Click "Done"

## 🔥 Step 3: Check Firestore Rules

If Firestore is created but rules are wrong, you'll get permission errors.

1. Go to **Firestore Database** → **Rules** tab
2. Check what's there

### ❌ BAD (Default test mode - expires in 30 days):
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2024, 12, 25);
    }
  }
}
```

### ✅ GOOD (What you need):
Should have rules for `users`, `appointments`, etc. with authentication checks.

### Fix: Update Rules

1. **Delete** everything in the Firestore Rules editor
2. **Copy** this and paste it:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && request.auth.uid == userId;
      allow update: if isOwner(userId);
      allow delete: if false;
    }
    
    match /appointments/{appointmentId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn();
      allow update: if isSignedIn();
      allow delete: if isSignedIn();
    }
    
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

3. Click **"Publish"**

## 📱 Step 4: Check Your Console/Terminal Output

When the red screen appears, look at your terminal/command prompt. You should see error messages like:

```
Firebase initialization error: ...
```

**Copy the full error message** - it will tell us exactly what's wrong!

## 🔄 Step 5: Restart Everything

Sometimes changes take time to propagate:

1. **Stop your app** (Ctrl + C in terminal)
2. **Wait 2-3 minutes** (important if you just enabled services)
3. **Clear build cache:**
   ```bash
   flutter clean
   flutter pub get
   ```
4. **Run again:**
   ```bash
   flutter run
   ```

## 🧪 Step 6: Test Authentication First

Let's test if the problem is Authentication or Firestore:

1. **Run the app**
2. **Skip to Sign Up screen** (click through splash screens)
3. **Try to create an account**:
   - Name: Test User
   - Email: test@example.com
   - Password: test123456
   - Select Role: Parent
4. **Click Sign Up**

### What happens?

**Scenario A: "User created but error saving to Firestore"**
- ✅ Authentication works
- ❌ Firestore has issues
- **Fix:** Check Firestore rules, make sure database is created

**Scenario B: "Error creating user" or "Permission denied"**
- ❌ Authentication has issues
- **Fix:** Make sure Email/Password is enabled in Authentication

**Scenario C: App crashes or freezes**
- ❌ Firebase not initialized properly
- **Fix:** Check console for error messages

## 🔍 Step 7: Verify firebase_options.dart

Open the file: `lib/firebase_options.dart`

Does it have **real values** or **placeholder values**?

### ❌ BAD (Placeholders):
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',  // ← Placeholders
  appId: 'YOUR_ANDROID_APP_ID',
  ...
);
```

### ✅ GOOD (Real values):
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyC...',  // ← Real API key
  appId: '1:123456:android:abc123',  // ← Real App ID
  ...
);
```

**If you see placeholders:**
- You need to run `flutterfire configure` again
- Or your configuration didn't complete properly

## 📋 Checklist: What Must Be Done

Go through this checklist in Firebase Console:

- [ ] **Billing enabled** (Blaze plan active)
- [ ] **Authentication enabled** (Email/Password toggle is ON)
- [ ] **Firestore Database created** (can see Data tab)
- [ ] **Firestore Rules published** (updated from default)
- [ ] **Storage enabled** (can see Files tab)
- [ ] **Storage Rules published** (updated from default)
- [ ] **Waited 2-3 minutes after enabling services**
- [ ] **App restarted** after enabling services

## 🆘 Quick Fix - Start Fresh

If nothing works, try this:

1. **Go to Firebase Console**
2. **Make sure these are ALL enabled:**
   - Authentication → Users tab visible ✅
   - Firestore Database → Data tab visible ✅
   - Storage → Files tab visible ✅

3. **Update Firestore Rules** (copy rules from above)

4. **In your terminal:**
   ```bash
   # Stop app
   # Then run:
   flutter clean
   flutter pub get
   flutter run
   ```

5. **Wait for app to load**

6. **Try signing up** with a test account

## 💬 What to Tell Me

To help you better, please provide:

1. **Exact error message** from the red screen
2. **Console/terminal output** when the error appears
3. **Firebase Console status:**
   - Authentication: Enabled? (Yes/No)
   - Firestore: Created? (Yes/No)
   - Storage: Enabled? (Yes/No)
4. **Did you update Firestore rules?** (Yes/No)
5. **How long ago did you enable billing?** (If less than 5 minutes, wait longer)

## 🎯 Most Common Issues

### Issue #1: Firestore Not Created
**Symptom:** Red error immediately after splash
**Fix:** Go to Firebase Console → Firestore Database → Create database

### Issue #2: Billing Not Enabled
**Symptom:** Can't create Firestore database
**Fix:** Enable Blaze plan, add credit card, wait 2-5 minutes

### Issue #3: Rules Not Updated
**Symptom:** "Permission denied" errors
**Fix:** Update Firestore rules (see Step 3 above)

### Issue #4: Services Just Enabled
**Symptom:** Error even though everything looks correct
**Fix:** Wait 3-5 minutes, restart app

### Issue #5: Authentication Not Enabled
**Symptom:** Can't create account
**Fix:** Firebase Console → Authentication → Enable Email/Password

---

**Next Step:** Follow the checklist above and let me know what you find! 🔍
