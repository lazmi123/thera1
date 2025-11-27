# ⚡ QUICK FIX: Login Network Error

## 🎯 Your Error:
```
A network error (such as timeout, interrupted connection or unreachable host) has occurred.
```

## ✅ QUICK SOLUTION (5 Minutes):

### Step 1: Enable Firebase Authentication (MOST IMPORTANT!)

1. **Go to:** https://console.firebase.google.com/
2. **Select:** thera1-app project
3. **Click:** "Authentication" in left menu
4. **Click:** "Get Started" button (if you see it)
5. **Go to:** "Sign-in method" tab
6. **Find:** Email/Password
7. **Toggle:** Turn it ON ✅
8. **Click:** Save

**This is 90% of the problem!**

---

### Step 2: Check google-services.json File

1. **Check if file exists:**
   - Location: `android/app/google-services.json`
   - ❌ If missing → Download from Firebase Console

2. **How to download:**
   - Firebase Console → Project Settings (gear icon)
   - Scroll to "Your apps"
   - Click Android app
   - Click "google-services.json" button
   - Save to: `android/app/google-services.json`

---

### Step 3: Create Firestore Database

1. **Firebase Console** → **Firestore Database**
2. **Click:** "Create database"
3. **Select:** "Start in test mode"
4. **Choose:** Location (us-central or closest)
5. **Click:** "Enable"
6. **Wait:** 1-2 minutes

---

### Step 4: Rebuild App

```bash
flutter clean
flutter pub get
flutter run
```

---

### Step 5: Try Sign Up (Not Login!)

Since you don't have users yet:
1. **Open app**
2. **Click:** "Sign Up" (not Login)
3. **Create account:**
   - Name: Test User
   - Email: test@test.com
   - Password: test123
   - Role: Parent
4. **Click:** Sign Up

**If signup works → Firebase is connected!** ✅

Then you can login with those credentials.

---

## 🎯 Still Not Working?

### Try This:
1. **Uninstall app** from phone
2. **Reinstall:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

### Or Check:
- Is internet working? (Open browser, go to google.com)
- Did you wait 1-2 minutes after enabling services?
- Is google-services.json in the right folder?

---

## 📋 Checklist:

- [ ] Authentication enabled in Firebase Console ⭐ (Most important!)
- [ ] Email/Password sign-in method enabled
- [ ] google-services.json file exists in android/app/
- [ ] Firestore Database created
- [ ] App rebuilt with flutter clean
- [ ] Tried Sign Up (not just login)

---

## 🚀 After Fix:

You should see:
- ✅ Sign up works
- ✅ Login works
- ✅ Home screen loads
- ✅ Bottom navigation visible
- ✅ Can view therapists
- ✅ Can book appointments

---

**For detailed troubleshooting, see:** `FIX_NETWORK_ERROR.md`

**The #1 reason this error happens:** Authentication not enabled in Firebase Console!

**Enable it, rebuild app, and try again!** 🎉
