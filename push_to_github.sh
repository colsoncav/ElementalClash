#!/bin/bash
# Push Elemental Clash source & app to your GitHub repository
cd "$(dirname "$0")"

echo "=== Push Elemental Clash to GitHub ==="
echo "If you haven't created a GitHub repository yet, create one at: https://github.com/new"
read -p "Enter your GitHub repository URL (e.g., https://github.com/YourUsername/ElementalClash.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "No URL entered. Aborting."
    exit 1
fi

git remote remove origin 2>/dev/null
git remote add origin "$REPO_URL"
git branch -M main
git add .
git commit -m "Elemental Clash: Standalone App-to-App Online Multiplayer"
git push -u origin main

echo ""
echo "Successfully linked and pushed to GitHub!"
echo "Anyone can now clone or download your app and play online together app-to-app!"
