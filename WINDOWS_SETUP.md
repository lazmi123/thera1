# Firebase Setup for Windows (Dell Computer)

This guide is specifically for setting up Firebase on Windows computers (Dell).

## Prerequisites

Before installing Firebase Tools, you need Node.js installed on your Dell computer.

## Step 1: Install Node.js (If Not Already Installed)

### Check if Node.js is Already Installed

Open **Command Prompt** (CMD) or **PowerShell** and run:

```bash
node --version
npm --version
```

If you see version numbers, Node.js is already installed. **Skip to Step 2**.

### Install Node.js

**📥 For detailed Node.js installation instructions, see: [INSTALL_NODEJS.md](INSTALL_NODEJS.md)**

**Quick steps:**

1. Go to [https://nodejs.org/](https://nodejs.org/)
2. Download the **LTS (Long Term Support)** version for Windows (click the green button)
3. Run the installer (`.msi` file) from your Downloads folder
4. Follow the installation wizard:
   - Click "Next"
   - Accept the license agreement
   - Choose installation location (default is fine: `C:\Program Files\nodejs\`)
   - **Important**: Make sure "Add to PATH" is checked ✓
   - Click "Install"
   - Click "Yes" if Windows asks for permission
5. **Restart your computer** (important for PATH to work)

### Verify Node.js Installation

Open a **NEW** Command Prompt window and run:

```bash
node --version
npm --version
```

You should see version numbers like:
```
v20.x.x
10.x.x
```

## Step 2: Install Firebase CLI

### Option A: Using NPM (Recommended)

Open **Command Prompt** or **PowerShell** as **Administrator**:

1. **Right-click** on Start menu
2. Select **"Windows Terminal (Admin)"** or **"Command Prompt (Admin)"** or **"PowerShell (Admin)"**
3. Run:

```bash
npm install -g firebase-tools
```

**Note**: The `-g` flag installs it globally, making it available everywhere.

### Option B: Using NPM without Admin Rights

If you don't have admin rights, you can install to your user directory:

```bash
npm install -g firebase-tools --force
```

### Option C: Standalone Binary (No Node.js Required)

If you prefer not to use npm:

1. Download from [https://firebase.tools/bin/win/instant/latest](https://firebase.tools/bin/win/instant/latest)
2. This downloads a standalone `firebase.exe` file
3. Place it in a folder (e.g., `C:\Firebase\`)
4. Add that folder to your PATH environment variable

### Verify Firebase CLI Installation

```bash
firebase --version
```

You should see something like:
```
13.x.x
```

## Step 3: Install Flutter (If Not Already Installed)

### Check if Flutter is Installed

```bash
flutter --version
```

### Install Flutter for Windows

1. Go to [https://docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)
2. Download Flutter SDK for Windows
3. Extract the zip file to a location like `C:\src\flutter`
4. Add Flutter to your PATH:
   - Search for "Environment Variables" in Windows
   - Click "Environment Variables"
   - Under "User variables", find "Path"
   - Click "Edit"
   - Click "New"
   - Add: `C:\src\flutter\bin` (or wherever you extracted Flutter)
   - Click "OK" on all windows
5. Restart Command Prompt
6. Run `flutter doctor` to check setup

## Step 4: Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

### Add Dart Global Packages to PATH

If `flutterfire` command is not recognized, add it to PATH:

1. The default location is: `%USERPROFILE%\AppData\Local\Pub\Cache\bin`
2. Add this to your PATH environment variable:
   - Search for "Environment Variables" in Windows
   - Click "Environment Variables"
   - Under "User variables", find "Path"
   - Click "Edit"
   - Click "New"
   - Add: `C:\Users\YourUsername\AppData\Local\Pub\Cache\bin`
   - Replace `YourUsername` with your actual Windows username
   - Click "OK" on all windows

### Verify FlutterFire CLI Installation

Close and reopen Command Prompt, then run:

```bash
flutterfire --version
```

## Step 5: Login to Firebase

```bash
firebase login
```

This will:
1. Open your default web browser
2. Ask you to sign in with your Google account
3. Request permission to access Firebase
4. Show "Success! Logged in as your-email@gmail.com"

## Step 6: Navigate to Your Project

Open Command Prompt and navigate to your project:

```bash
cd C:\path\to\your\workspace
```

For example, if your project is on Desktop:
```bash
cd C:\Users\YourUsername\Desktop\thera1
```

## Step 7: Configure Firebase

```bash
flutterfire configure
```

Follow the prompts:
1. Select your Firebase project (or create a new one)
2. Select platforms to configure:
   - [x] Android
   - [x] iOS
   - [x] Web
3. Wait for configuration to complete

You should see:
```
✔ Firebase project selected: thera1-app
✔ Registered new Firebase Android app
✔ Firebase configuration file lib/firebase_options.dart generated successfully
```

## Step 8: Install Flutter Dependencies

```bash
flutter pub get
```

## Step 9: Run Your App

### For Android (with emulator or connected device):
```bash
flutter run
```

### For Windows Desktop:
```bash
flutter run -d windows
```

### For Web:
```bash
flutter run -d chrome
```

## Troubleshooting

### Issue: "npm is not recognized"

**Solution**: Node.js is not installed or not in PATH
1. Reinstall Node.js
2. Make sure "Add to PATH" is checked during installation
3. Restart computer

### Issue: "firebase is not recognized"

**Solution**: Firebase CLI not in PATH or installation failed
1. Close and reopen Command Prompt
2. Run as Administrator
3. Try reinstalling: `npm install -g firebase-tools --force`

### Issue: "flutterfire is not recognized"

**Solution**: Dart global bin directory not in PATH
1. Add `%USERPROFILE%\AppData\Local\Pub\Cache\bin` to PATH
2. Close and reopen Command Prompt
3. Try: `dart pub global activate flutterfire_cli`

### Issue: Permission Denied

**Solution**: Run Command Prompt as Administrator
1. Right-click Start menu
2. Select "Windows Terminal (Admin)" or "Command Prompt (Admin)"
3. Run the command again

### Issue: Firewall Blocking Installation

**Solution**: 
1. Temporarily disable antivirus/firewall
2. Run installation
3. Re-enable antivirus/firewall

### Issue: "flutter doctor" Shows Errors

**Solution**: Run suggested fixes
```bash
flutter doctor
```
Then follow the suggestions to fix issues.

## Common Windows Commands

| Task | Command |
|------|---------|
| Check Node.js version | `node --version` |
| Check npm version | `npm --version` |
| Check Firebase CLI | `firebase --version` |
| Check Flutter | `flutter --version` |
| Check Dart | `dart --version` |
| List installed npm packages | `npm list -g --depth=0` |
| Update npm | `npm install -g npm@latest` |
| Update Firebase CLI | `npm update -g firebase-tools` |

## PowerShell Alternative Commands

If you prefer PowerShell, the commands are the same:

```powershell
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Configure FlutterFire
flutterfire configure
```

## Windows-Specific Notes

1. **Always use backslashes** `\` for Windows paths (or forward slashes `/` will also work in most cases)
2. **Run as Administrator** when installing global packages
3. **Restart Command Prompt** after installing tools to refresh PATH
4. **Check Windows Defender/Antivirus** if downloads are blocked
5. **Use Windows Terminal** (modern) instead of old Command Prompt for better experience

## Video Path Example

If your project is in:
- Desktop: `cd C:\Users\YourUsername\Desktop\workspace`
- Documents: `cd C:\Users\YourUsername\Documents\workspace`
- Custom location: `cd D:\Projects\workspace`

## Quick Command Summary

Once everything is installed, here's the complete workflow:

```bash
# 1. Navigate to project
cd C:\path\to\your\workspace

# 2. Login to Firebase
firebase login

# 3. Configure Firebase
flutterfire configure

# 4. Install dependencies
flutter pub get

# 5. Run app
flutter run
```

## Next Steps

After completing this setup, follow:
- **[QUICK_START.md](QUICK_START.md)** - Continue with Firebase project setup
- **[FIREBASE_SETUP.md](FIREBASE_SETUP.md)** - Detailed Firebase configuration

---

**Need help?** 
- Node.js help: [https://nodejs.org/en/docs/](https://nodejs.org/en/docs/)
- Firebase CLI help: `firebase --help`
- FlutterFire help: `flutterfire --help`
- Flutter help: `flutter doctor -v`
