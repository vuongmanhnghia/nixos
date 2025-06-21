# 🔒 Secrets Management Setup

## Overview

This NixOS configuration uses a simple secrets management system to keep sensitive data out of version control.

## Setup Instructions

### 1. Create your secrets file

Copy the example file and fill in your actual values:

```bash
cp secrets.nix.example secrets.nix
```

### 2. Edit secrets.nix

Open `secrets.nix` and replace the placeholder values:

```nix
{
  syncthing = {
    # Your Syncthing GUI password
    guiPassword = "your-actual-password";

    # Your actual device IDs
    devices = {
      laptop = "YOUR-ACTUAL-LAPTOP-DEVICE-ID";
      desktop = "YOUR-ACTUAL-DESKTOP-DEVICE-ID";
    };
  };
}
```

### 3. Find your Syncthing Device IDs

-  Open Syncthing web interface: http://localhost:8384
-  Go to Settings → Show ID
-  Copy the device ID for each device

### 4. Security Notes

-  ✅ `secrets.nix` is automatically ignored by git
-  ✅ The system will work with placeholder values if secrets.nix doesn't exist
-  ✅ Always backup your secrets.nix file separately
-  ⚠️ Never commit secrets.nix to version control

### 5. Adding New Secrets

To add new secrets, modify both:

1. `secrets.nix.example` (with placeholder values)
2. `secrets.nix` (with real values)
3. Update `lib/secrets.nix` if needed

## Troubleshooting

### If you see "CHANGE_ME" values

This means `secrets.nix` doesn't exist or has missing values. Follow the setup instructions above.

### If build fails with secrets errors

Check that your `secrets.nix` file has the correct structure matching `secrets.nix.example`.
