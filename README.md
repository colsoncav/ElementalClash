# Elemental Clash

An action-packed elemental battle arena game built for macOS with SwiftUI and WebKit, featuring real-time peer-to-peer online multiplayer.

## Features
- **Local Play**: Tournament mode vs CPU or 2–6 player local battles.
- **🌐 In-App Online Multiplayer**: Play online with friends directly using 4-letter room codes powered by WebRTC / PeerJS.
- **6 Playable Elements**: Fire, Water, Earth, Air, Lightning, and Void each with unique projectiles and charged super attacks.
- **Crossplay**: Play in the macOS native app or in any modern web browser.

## How to Play
1. Launch **Elemental Clash** (or open `index.html` in your browser).
2. Click **🌐 ONLINE BATTLE** on the title screen.
3. One player clicks **HOST A GAME** to get a 4-letter room code (e.g. `7K2P`).
4. Other players enter the room code in **JOIN A GAME** and click **JOIN ROOM**.
5. Once ready, the host clicks **START GAME**!

## Opening on Another Mac
If macOS shows *"Elemental Clash is damaged and can't be opened"* or *"Apple cannot check it for malicious software"*, this is Apple's standard Gatekeeper quarantine for apps downloaded from the internet. Run this one-line command in Terminal on the other Mac:
```bash
xattr -cr /path/to/"Elemental Clash.app"
```
Or right-click the app -> **Open** -> click **Open**.
