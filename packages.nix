{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal
    alacritty

    # Utilities
    git
    p7zip
    unzip
    unrar
    mullvad-vpn
    nwg-look
    yt-dlp
    ffmpeg
    xarchiver
    keepassxc
    geeqie
    mpv
    mtkclient
    android-tools
    tree
    git
    noctalia
    fuzzel
    wget
    trash-cli

    # Apps
    audacity
    puddletag

    # Virtualization and Compatability
    wine
    winetricks
    qemu
    virt-manager

    # System tools
    btop
    fastfetch

    # File management
    pcmanfm

    # Editors
    vim
    libreoffice
    gimp

    # Networking
    networkmanagerapplet
 
    # Browser
    librewolf
    tor-browser

    # Aesthetic
    cmatrix
    cava
    lxappearance

    # Programming
    go
    opencode-desktop
    gcc
    typescript
    vscode
    rustc
    cargo
    nodejs
    python3

    # Misc
    gtk3
    libsoup_3
    webkitgtk_4_1
    pkg-config
  ];
}

