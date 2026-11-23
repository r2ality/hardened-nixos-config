# Hardened NixOS dotfiles

Main dotfiles for my PC, a few differences compared to the [thinkpad config.](https://github.com/r2ality/thinkpad-dotfiles)

## What's included in this config

1. Wayland
2. Niri, see [Niri config](https://github.com/r2ality/niri-config)
3. Lightweight, simple config
4. Systemd boot
5. Ly display manager/greeter
6. Alacritty config
7. Android tools (fastboot, adb)
8. Programming languages and compilers
9. Simple boot/encryption/shutdown through Plymouth.
10. Security through hardened.nix module.
11. And more.

You are free to edit, remove and add anything to your liking.

This is a very simple config for my specific workflow.

**This does not make your computer unexploitable.** You may need to change things manually in the BIOS to make it more secure and others.

## IMPORTANT: ANDROID TOOLS UNSTABLE

The unstable version of **Android tools** has an issue where command

```bash
fastboot --disable-verity --disable-verification flash vbmeta <file>.img
```

Outputs "cannot find AVB magic", despite vbmeta file being valid.

Solution: Downgrade the Android tools version to 35.0.0 or older.

Use the following command to enter a temporary shell with downgraded android tools for disabling secure boot:

```bash
nix shell github:NixOS/nixpkgs/01e9ba9666a3fb1376258c5b6cad75fa1dd561c#android-tools
```

For flashing GSIs and other custom firmware into your android device.

In my testing, all other commands work normally.
