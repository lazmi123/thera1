# How to Download and Install Node.js on Dell/Windows

## 📥 Step 1: Download Node.js

### Direct Download Link:
👉 **Go to: https://nodejs.org/**

OR

👉 **Direct LTS Download: https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi**

### What to Download:

When you visit https://nodejs.org/, you'll see two big green buttons:

- **LTS (Long Term Support)** ✅ ← **Download this one** (Recommended)
- Current (Latest Features)

**Click the LTS button** to download Node.js.

The file will be named something like: `node-v20.x.x-x64.msi` (about 30MB)

## 🔧 Step 2: Install Node.js

### Installation Steps:

1. **Locate the downloaded file**
   - Usually in your **Downloads** folder: `C:\Users\YourUsername\Downloads\`
   - Look for: `node-v20.x.x-x64.msi`

2. **Double-click the file** to start installation

3. **Follow the Installation Wizard**:

   **Screen 1: Welcome**
   - Click **"Next"**

   **Screen 2: License Agreement**
   - Check **"I accept..."**
   - Click **"Next"**

   **Screen 3: Destination Folder**
   - Default location is fine: `C:\Program Files\nodejs\`
   - Click **"Next"**

   **Screen 4: Custom Setup** ⚠️ **IMPORTANT**
   - Make sure these are checked:
     - ✅ Node.js runtime
     - ✅ npm package manager
     - ✅ **Online documentation shortcuts**
     - ✅ **Add to PATH** ← **VERY IMPORTANT!**
   - Click **"Next"**

   **Screen 5: Tools for Native Modules** (Optional)
   - You can check this box if you want (installs Python and Visual Studio Build Tools)
   - OR skip it for now (you can install later if needed)
   - Click **"Next"**

   **Screen 6: Ready to Install**
   - Click **"Install"**
   - Click **"Yes"** if Windows asks for permission

   **Screen 7: Completed**
   - Click **"Finish"**

4. **Restart Your Computer** (Important!)
   - This ensures the PATH is updated
   - **Start Menu** → **Power** → **Restart**

## ✅ Step 3: Verify Installation

After your computer restarts:

1. **Open Command Prompt**:
   - Press **Windows Key + R**
   - Type: `cmd`
   - Press **Enter**

2. **Check Node.js version**:
   ```bash
   node --version
   ```
   
   You should see something like:
   ```
   v20.11.0
   ```

3. **Check npm version**:
   ```bash
   npm --version
   ```
   
   You should see something like:
   ```
   10.2.4
   ```

## ✅ If You See Version Numbers = Success! 🎉

Now you can install Firebase Tools:

```bash
npm install -g firebase-tools
```

## ❌ Troubleshooting

### Problem: "node is not recognized"

**Reason**: Node.js is not in your PATH

**Fix Option 1** - Reinstall Node.js:
1. Go to **Control Panel** → **Programs** → **Uninstall a program**
2. Find **Node.js** and uninstall it
3. Download and install again from https://nodejs.org/
4. **Make sure "Add to PATH" is checked** during installation
5. Restart your computer

**Fix Option 2** - Manually Add to PATH:
1. Search **"Environment Variables"** in Windows Start Menu
2. Click **"Edit the system environment variables"**
3. Click **"Environment Variables"** button
4. Under **"System variables"**, find **"Path"**
5. Click **"Edit"**
6. Click **"New"**
7. Add: `C:\Program Files\nodejs\`
8. Click **"OK"** on all windows
9. **Restart Command Prompt** (close and reopen)
10. Try again: `node --version`

### Problem: Download is Blocked or Slow

**Fix**:
- Try a different browser (Chrome, Edge, Firefox)
- Temporarily disable antivirus
- Check your internet connection
- Use alternative download: https://nodejs.org/dist/

### Problem: Installation Fails

**Fix**:
1. Run the installer **as Administrator**:
   - Right-click `node-v20.x.x-x64.msi`
   - Select **"Run as administrator"**
2. Try older LTS version: https://nodejs.org/en/download/

### Problem: Permission Denied During Installation

**Fix**:
- Make sure you're logged in as an Administrator on your Dell computer
- Ask your IT department if you're on a company/school computer

## 📸 Visual Guide

### What You'll See on nodejs.org:

```
┌─────────────────────────────────────┐
│         Node.js Website             │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────┐  ┌──────────────┐ │
│  │  20.11.0 LTS │  │  21.6.0      │ │
│  │  Recommended │  │  Current     │ │
│  │     for      │  │  Latest      │ │
│  │  Most Users  │  │  Features    │ │
│  └─────────────┘  └──────────────┘ │
│       ↑                             │
│   Click This One!                   │
└─────────────────────────────────────┘
```

## 🔗 Official Links

- **Node.js Official Website**: https://nodejs.org/
- **Node.js Downloads Page**: https://nodejs.org/en/download/
- **Node.js Documentation**: https://nodejs.org/en/docs/

## 📋 Alternative Download Methods

### Method 1: Direct LTS Download (Windows 64-bit)
https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi

### Method 2: Windows Package Manager (if you have winget)
```bash
winget install OpenJS.NodeJS.LTS
```

### Method 3: Chocolatey (if you have Chocolatey installed)
```bash
choco install nodejs-lts
```

## ⏭️ Next Steps After Installing Node.js

Once Node.js is installed and verified:

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Continue with setup**:
   - Follow **[DELL_WINDOWS_QUICK_REFERENCE.md](DELL_WINDOWS_QUICK_REFERENCE.md)**
   - Or follow **[WINDOWS_SETUP.md](WINDOWS_SETUP.md)**

## 💡 What is Node.js?

Node.js is a JavaScript runtime that allows you to run JavaScript on your computer (not just in browsers). 

**Why you need it**:
- npm (Node Package Manager) comes with Node.js
- Firebase Tools requires npm to install
- Many development tools use Node.js

## 📞 Still Having Issues?

1. Check if you have enough disk space (need ~200MB)
2. Check if antivirus is blocking the download
3. Make sure Windows is up to date
4. Try downloading on a different network

---

**After successful installation, go to**: [DELL_WINDOWS_QUICK_REFERENCE.md](DELL_WINDOWS_QUICK_REFERENCE.md)

**Estimated Time**: 5-10 minutes (plus download time)
