{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # General
    fastfetch
    neovim
    gitFull 
    wget
    qbittorrent
    backintime
    firefox
    vscode-fhs
    haruna
    ffmpeg
    yt-dlp
    # Go
    go
    gopls
  ];
}