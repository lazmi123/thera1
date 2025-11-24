# Quick Reference for Dell/Windows Setup

## 🚀 Quick Commands for Your Dell Computer

### Step 1: Install Node.js First

**📥 Need help installing Node.js?** → See **[INSTALL_NODEJS.md](INSTALL_NODEJS.md)** for detailed instructions

**Quick version:**
1. Download from: https://nodejs.org/ (click the LTS button)
2. Install the `.msi` file (make sure "Add to PATH" is checked)
3. Restart your computer
4. Verify: `node --version`

### Step 2: Open Command Prompt as Administrator
- Right-click Start menu → **"Command Prompt (Admin)"** or **"Windows Terminal (Admin)"**

### Step 3: Run These Commands

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI  
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Navigate to your project folder (adjust path to your actual location)
cd C:\Users\YourUsername\Desktop\workspace

# Configure Firebase
flutterfire configure

# Install Flutter dependencies
flutter pub get

# Run your app
flutter run
```

## 📍 Common Windows Paths

Replace these with your actual paths:

- **If project on Desktop**: 
  ```bash
  cd C:\Users\YourUsername\Desktop\workspace
  ```

- **If project in Documents**:
  ```bash
  cd C:\Users\YourUsername\Documents\workspace
  ```

- **If project on D: drive**:
  ```bash
  cd D:\Projects\workspace
  ```

## ⚠️ Common Issues on Windows

### "npm is not recognized"
**Fix**: Install Node.js from https://nodejs.org/ and restart computer

### "firebase is not recognized"  
**Fix**: 
1. Close Command Prompt
2. Reopen as Administrator
3. Run: `npm install -g firebase-tools --force`

### "flutterfire is not recognized"
**Fix**: Add Dart to PATH
1. Search "Environment Variables" in Windows
2. Edit "Path" under User variables
3. Add: `C:\Users\YourUsername\AppData\Local\Pub\Cache\bin`
4. Restart Command Prompt

### Permission Denied
**Fix**: Run Command Prompt as Administrator
- Right-click Start → "Command Prompt (Admin)"

## 📖 Full Documentation

For detailed step-by-step instructions, see:
- **[WINDOWS_SETUP.md](WINDOWS_SETUP.md)** - Complete Windows guide with screenshots explanations

## ✅ Quick Verification

After installation, verify everything works:

```bash
node --version
npm --version
firebase --version
flutter --version
dart --version
flutterfire --version
```

All commands should show version numbers without errors.

## 🎯 What You're Installing

| Tool | Purpose |
|------|---------|
| **Node.js** | JavaScript runtime (needed for npm) |
| **npm** | Package manager (comes with Node.js) |
| **Firebase CLI** | Firebase command-line tools |
| **Flutter** | Mobile app development framework |
| **Dart** | Programming language (comes with Flutter) |
| **FlutterFire CLI** | Firebase + Flutter integration tool |

## 🔥 After Setup Complete

Once all tools are installed, follow:
1. **[QUICK_START.md](QUICK_START.md)** - Continue with Firebase configuration
2. Enable services in Firebase Console
3. Run your app!

---

**Estimated Time**: 20-30 minutes (including downloads)

**Got it working?** Move on to [QUICK_START.md](QUICK_START.md) for the next steps!
