# 🔥 Fix: Firebase Network Error on Login

## 🚨 Error You're Seeing:
```
E/RecaptchaCallWrapper: Initial task failed for action RecaptchaAction(action=signInWithPassword)
with exception - A network error (such as timeout, interrupted connection or unreachable host) has occurred.
```

## 🎯 Root Cause:
This is **NOT a network/internet issue** - it's a **Firebase configuration issue**!

The error means:
1. Firebase Authentication is not properly configured, OR
2. Firebase services are not enabled in Firebase Console, OR
3. `google-services.json` is missing/incorrect, OR
4. Firebase project doesn't have proper permissions

---

## ✅ SOLUTION - Step by Step:

### Step 1: Verify Internet Connection (Quick Check)
Just to be sure:
- Open browser → Go to google.com
- If it loads → Internet is fine ✅
- If not → Fix internet first

---

### Step 2: Check Firebase Configuration File

#### For Android:
**File location:** `android/app/google-services.json`

**Check if it exists:**
1. Open your project folder
2. Navigate to: `android/app/`
3. Look for: `google-services.json`

**If file is MISSING:**
❌ This is your problem! You need to download it from Firebase Console.

**How to download:**
1. Go to: https://console.firebase.google.com/
2. Select project: **thera1-app**
3. Click **Project Settings** (gear icon)
4. Scroll down to **"Your apps"**
5. Click on **Android app** (if not added, click "Add app")
6. Download **google-services.json**
7. Place it in: `android/app/google-services.json`

**If file EXISTS but old:**
- Download fresh copy from Firebase Console
- Replace the old one
- Rebuild app

---

### Step 3: Enable Firebase Authentication

**This is the most common issue!**

1. **Go to Firebase Console:**
   - URL: https://console.firebase.google.com/
   - Select project: **thera1-app**

2. **Enable Authentication:**
   - Click **"Authentication"** in left menu
   - Click **"Get Started"** (if not enabled)
   - Go to **"Sign-in method"** tab
   - Enable **"Email/Password"**
     - Toggle: ON ✅
     - Click "Save"

3. **Verify it's enabled:**
   - You should see **"Email/Password"** with status: **Enabled** ✅

---

### Step 4: Check Firestore Database

1. **Go to Firebase Console**
2. **Click "Firestore Database"** in left menu
3. **Is database created?**
   - ✅ Yes → Good!
   - ❌ No → Click **"Create database"**

4. **If creating database:**
   - Select **"Start in test mode"** (for development)
   - Choose location: **us-central** (or closest to you)
   - Click **"Enable"**

5. **Wait 1-2 minutes** for database to be ready

---

### Step 5: Update Security Rules (If Database Exists)

**Go to Firestore → Rules tab**

Replace with these rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow all reads/writes for testing (TEMPORARY!)
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

Click **"Publish"**

⚠️ **Note:** These are TEST rules (wide open). Use proper rules later (see `firestore.rules` file).

---

### Step 6: Rebuild Your App

After making Firebase changes:

```bash
# Stop the app (Ctrl+C)

# Clean build
flutter clean

# Get dependencies
flutter pub get

# Rebuild and run
flutter run
```

---

### Step 7: Test Login

1. **Open app**
2. **Try logging in**
3. **If no user exists yet:**
   - Click "Sign Up"
   - Create new account
   - Then try logging in

---

## 🔍 Additional Checks:

### Check 1: Firebase Project ID

**In Firebase Console:**
1. Project Settings → General
2. Note down: **Project ID** (should be: `thera1-app`)

**In your code:**
Check `android/app/google-services.json`:
```json
{
  "project_info": {
    "project_id": "thera1-app"  // Should match!
  }
}
```

### Check 2: App Check Warning (Optional)

The warning about `No AppCheckProvider installed` is **not critical** - you can ignore it for now.

To fix it (optional):
1. Firebase Console → App Check
2. Enable App Check for your app
3. Follow instructions

But this won't solve your current network error.

### Check 3: Package Name Match

**In Firebase Console:**
- Project Settings → Your apps → Android app
- Note the **Package name** (e.g., `com.example.thera1`)

**In your project:**
Check `android/app/build.gradle.kts`:
```kotlin
android {
    namespace = "com.example.thera1"  // Should match Firebase!
    ...
    defaultConfig {
        applicationId = "com.example.thera1"  // Should match Firebase!
    }
}
```

---

## 🎯 Most Common Solutions:

### Solution A: Missing google-services.json
**Fix:** Download from Firebase Console → Place in `android/app/`

### Solution B: Authentication Not Enabled
**Fix:** Firebase Console → Authentication → Enable Email/Password

### Solution C: Database Not Created
**Fix:** Firebase Console → Firestore → Create database

### Solution D: Old Configuration
**Fix:** 
```bash
flutter clean
rm -rf android/.gradle
flutter pub get
flutter run
```

---

## 🧪 Quick Test:

### Test 1: Firebase Connection
Run this command to test Firebase:
```bash
flutter run --verbose
```

Look for lines like:
- ✅ `Firebase initialized successfully`
- ✅ `FirebaseAuth instance created`
- ❌ `Firebase initialization error` (if this appears, Firebase not configured)

### Test 2: Create Test User

**Instead of logging in, try signing up first:**
1. Open app
2. Click **"Sign Up"**
3. Enter:
   - Name: Test User
   - Email: test@example.com
   - Password: test123456
   - Role: Parent
4. Click "Sign Up"
5. If it works → Firebase is connected! ✅
6. If it fails with same error → Go back to Step 2 (google-services.json)

---

## 📋 Complete Checklist:

**Firebase Console:**
- [ ] Project created: thera1-app
- [ ] Authentication enabled: Email/Password
- [ ] Firestore Database created
- [ ] Security rules set to test mode (allow all)

**Your Project:**
- [ ] `google-services.json` exists in `android/app/`
- [ ] Package name matches Firebase Console
- [ ] App rebuilt after adding google-services.json
- [ ] `flutter clean` run before building

**Testing:**
- [ ] Internet connection working
- [ ] Tried signing up (not just logging in)
- [ ] Waited 1-2 minutes after enabling Firebase services

---

## 🆘 Still Not Working?

### Check Console Output:

Run app and look for these specific errors:

**Error 1: "Unable to resolve host"**
→ Internet/DNS issue
→ Try different network (mobile hotspot?)

**Error 2: "API key not valid"**
→ google-services.json is wrong
→ Download fresh copy from Firebase

**Error 3: "Project not found"**
→ Firebase project doesn't exist or wrong project ID
→ Verify project ID in Firebase Console

**Error 4: "App not registered"**
→ Android app not added to Firebase project
→ Add app in Firebase Console → Download new google-services.json

---

## 💡 Pro Tips:

### Tip 1: Use Test Mode for Development
While testing, use open security rules:
```javascript
allow read, write: if true;
```

### Tip 2: Clear App Data
Sometimes old cached data causes issues:
- Go to Settings → Apps → Your App → Clear Data
- Or uninstall and reinstall

### Tip 3: Check Firebase Console Logs
Firebase Console → Analytics → DebugView
- See real-time app activity
- Check if requests are reaching Firebase

### Tip 4: Verify SHA-1 (If Using OAuth)
If you plan to use Google Sign-In later:
- Get SHA-1: `cd android && ./gradlew signingReport`
- Add to Firebase Console → Project Settings → SHA-1

---

## 🎯 Summary:

**Most likely cause:** Authentication not enabled in Firebase Console

**Quick fix:**
1. Firebase Console → Authentication → Enable Email/Password ✅
2. Download fresh `google-services.json` ✅
3. Place in `android/app/google-services.json` ✅
4. `flutter clean && flutter pub get && flutter run` ✅

**Test:**
- Try **Sign Up** first (not login)
- If signup works → Firebase connected! ✅

---

## 📞 Need More Help?

Check these files in your project:
- `RUN_APP_NOW.md` - Complete Firebase setup guide
- `ENABLE_FIREBASE_SERVICES.md` - How to enable services
- `FIREBASE_SETUP.md` - Detailed configuration

---

**After fixing, you should see:**
- ✅ No network errors
- ✅ Sign up works
- ✅ Login works
- ✅ Can view therapists
- ✅ Can book appointments

**Let me know which step fixes it for you!** 🚀
