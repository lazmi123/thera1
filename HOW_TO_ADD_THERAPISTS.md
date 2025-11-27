# How to Add Therapists to Firebase

## 🎯 Now Therapists Load from Firebase Database!

Your app is now updated to fetch therapists **dynamically from Firestore** instead of hardcoded data.

---

## 📊 How It Works Now:

### Before (Old):
- 4 hardcoded therapists (Dr. Sarah Johnson, etc.)
- Same therapists for everyone
- Can't add new therapists
- Can't update therapist info

### After (New - Current):
✅ Therapists loaded from Firestore `users` collection
✅ New therapists automatically appear in app
✅ Can update therapist info in real-time
✅ Each therapist is a real user account

---

## 🔥 How to Add New Therapists:

### Method 1: Through Signup (Recommended)

1. **Open your app**
2. **Click "Sign Up"**
3. **Fill in details:**
   - Name: Dr. Sarah Johnson
   - Email: sarah.johnson@therapy.com
   - Password: securepassword123
   - **Role: Select "Therapist"** ⭐ (Important!)
4. **Click "Sign Up"**
5. ✅ Done! Therapist appears in "View Therapists" immediately!

### Method 2: Firebase Console (Manual)

If you want to add therapists directly in Firebase Console:

1. **Go to Firebase Console:** https://console.firebase.google.com/
2. **Select your project:** thera1-app
3. **Click "Firestore Database"**
4. **Click on "users" collection**
5. **Click "Add document"**
6. **Fill in these fields:**

```javascript
{
  "uid": "AUTO_GENERATED_ID",  // Leave this as auto ID
  "name": "Dr. Sarah Johnson",
  "email": "sarah.johnson@therapy.com",
  "role": "therapist",  // ← Must be exactly "therapist"
  "specialization": "Child Psychology",
  "yearsOfExperience": 12,
  "rating": 4.8,
  "location": "New York, NY",
  "availability": ["Mon", "Wed", "Fri"],
  "isActive": true,  // ← Must be true to show in app!
  "phoneNumber": "+1234567890",
  "createdAt": Timestamp (now),
  "updatedAt": Timestamp (now)
}
```

7. **Click "Save"**
8. ✅ Therapist appears in app immediately!

---

## 📋 Required Fields for Therapists:

| Field | Type | Required | Example |
|-------|------|----------|---------|
| **name** | string | ✅ Yes | "Dr. Sarah Johnson" |
| **email** | string | ✅ Yes | "sarah@therapy.com" |
| **role** | string | ✅ Yes | "therapist" (lowercase!) |
| **isActive** | boolean | ✅ Yes | true |
| **specialization** | string | ⚠️ Recommended | "Child Psychology" |
| **yearsOfExperience** | number | ⚠️ Recommended | 12 |
| **rating** | number | ⚠️ Recommended | 4.8 |
| **location** | string | ⚠️ Recommended | "New York, NY" |
| **availability** | array | ⚠️ Recommended | ["Mon", "Wed", "Fri"] |
| **phoneNumber** | string | Optional | "+1234567890" |
| **uid** | string | ✅ Yes | Auto-generated or Auth UID |
| **createdAt** | timestamp | ✅ Yes | Firestore Timestamp |

---

## 🔍 How App Queries Therapists:

The app uses this Firestore query:

```dart
FirebaseFirestore.instance
  .collection('users')
  .where('role', isEqualTo: 'therapist')
  .where('isActive', isEqualTo: true)
  .snapshots()
```

**This means:**
- Only users with `role = "therapist"` show up
- Only users with `isActive = true` show up
- Updates in real-time (no need to refresh app!)

---

## ✅ Steps to Add 5 Sample Therapists:

### 1. Dr. Sarah Johnson - Child Psychology
```javascript
{
  "name": "Dr. Sarah Johnson",
  "email": "sarah.johnson@therapy.com",
  "role": "therapist",
  "specialization": "Child Psychology",
  "yearsOfExperience": 12,
  "rating": 4.8,
  "location": "New York, NY",
  "availability": ["Mon", "Wed", "Fri"],
  "isActive": true,
  "createdAt": [Use Firestore Timestamp - now()],
  "updatedAt": [Use Firestore Timestamp - now()]
}
```

### 2. Dr. Michael Chen - Behavioral Therapy
```javascript
{
  "name": "Dr. Michael Chen",
  "email": "michael.chen@therapy.com",
  "role": "therapist",
  "specialization": "Behavioral Therapy",
  "yearsOfExperience": 15,
  "rating": 4.9,
  "location": "Los Angeles, CA",
  "availability": ["Tue", "Thu", "Sat"],
  "isActive": true,
  "createdAt": [Timestamp],
  "updatedAt": [Timestamp]
}
```

### 3. Dr. Emily Rodriguez - Family Counseling
```javascript
{
  "name": "Dr. Emily Rodriguez",
  "email": "emily.rodriguez@therapy.com",
  "role": "therapist",
  "specialization": "Family Counseling",
  "yearsOfExperience": 10,
  "rating": 4.7,
  "location": "Chicago, IL",
  "availability": ["Mon", "Tue", "Thu"],
  "isActive": true,
  "createdAt": [Timestamp],
  "updatedAt": [Timestamp]
}
```

### 4. Dr. James Wilson - Autism Spectrum
```javascript
{
  "name": "Dr. James Wilson",
  "email": "james.wilson@therapy.com",
  "role": "therapist",
  "specialization": "Autism Spectrum",
  "yearsOfExperience": 18,
  "rating": 4.9,
  "location": "Houston, TX",
  "availability": ["Wed", "Fri", "Sat"],
  "isActive": true,
  "createdAt": [Timestamp],
  "updatedAt": [Timestamp]
}
```

### 5. Dr. Lisa Anderson - Speech Therapy
```javascript
{
  "name": "Dr. Lisa Anderson",
  "email": "lisa.anderson@therapy.com",
  "role": "therapist",
  "specialization": "Speech Therapy",
  "yearsOfExperience": 8,
  "rating": 4.6,
  "location": "Miami, FL",
  "availability": ["Mon", "Wed", "Fri"],
  "isActive": true,
  "createdAt": [Timestamp],
  "updatedAt": [Timestamp]
}
```

---

## 🎭 To Hide/Show Therapists:

### Hide a Therapist:
1. Go to Firestore → users collection
2. Find the therapist document
3. Change `isActive` from `true` to `false`
4. ✅ Therapist disappears from app immediately!

### Show a Therapist Again:
1. Change `isActive` back to `true`
2. ✅ Therapist appears in app immediately!

---

## 🔄 Real-Time Updates:

The app uses **StreamBuilder** which means:
- ✅ Add therapist in Firebase → Appears in app instantly!
- ✅ Update therapist info → Changes show immediately!
- ✅ Hide therapist → Disappears immediately!
- ✅ **No app restart needed!**

---

## 📱 What Parents See:

When parents click "View Therapists", they see:
- Therapist name
- Specialization
- Rating (stars)
- Years of experience
- Availability days
- Location
- "Book Appointment" button

---

## ⚠️ Important Notes:

### 1. Role Must Be Exact:
- ✅ Correct: `"role": "therapist"` (lowercase)
- ❌ Wrong: `"role": "Therapist"` (uppercase)
- ❌ Wrong: `"role": "THERAPIST"`

### 2. isActive Must Be Boolean:
- ✅ Correct: `"isActive": true` (boolean)
- ❌ Wrong: `"isActive": "true"` (string)

### 3. Availability is an Array:
- ✅ Correct: `"availability": ["Mon", "Wed", "Fri"]`
- ❌ Wrong: `"availability": "Mon, Wed, Fri"` (string)

---

## 🚀 Quick Test:

1. **Add a therapist** using Method 1 or 2 above
2. **Open app** (or if already open, pull to refresh)
3. **Go to "View Therapists"**
4. **You should see** the new therapist!
5. **Click "Book Appointment"**
6. **Booking should save** to Firebase!

---

## 🔍 Troubleshooting:

### Problem: No therapists showing

**Check:**
- Is `role` exactly `"therapist"` (lowercase)?
- Is `isActive` set to `true`?
- Is Firestore Database created and accessible?
- Are security rules allowing reads?

**Test Query in Firebase Console:**
```
Collection: users
Where: role == therapist
Where: isActive == true
```

### Problem: App shows "Loading therapists..."

**Reason:** Firebase is fetching data or connection is slow

**Fix:** Wait a few seconds or check internet connection

### Problem: App shows "No therapists available"

**Reason:** No therapists in database with correct filters

**Fix:** Add at least one therapist with `role="therapist"` and `isActive=true`

---

## 📊 Database Structure:

```
Firestore
└── users (collection)
    ├── user1_uid (document)
    │   ├── name: "Dr. Sarah Johnson"
    │   ├── role: "therapist"
    │   ├── isActive: true
    │   └── ... other fields
    ├── user2_uid (document)
    │   ├── name: "John Doe"
    │   ├── role: "parent"
    │   └── ...
    └── user3_uid (document)
        ├── name: "Dr. Michael Chen"
        ├── role: "therapist"
        ├── isActive: true
        └── ...
```

---

## ✨ Summary:

✅ **Therapists now load from Firestore dynamically**

✅ **Add therapists through:**
  - App signup (Role: Therapist)
  - Firebase Console manual entry

✅ **Required fields:**
  - name, email, role="therapist", isActive=true

✅ **Real-time updates** - no app restart needed!

✅ **Book appointments** now saves to Firebase!

✅ **Bottom navigation** added with Home & Appointments tabs!

---

**Now when you add therapists to Firebase, they automatically appear in the app!** 🎉
