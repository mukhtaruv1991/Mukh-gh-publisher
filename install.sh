#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 Installing gh-publish tool..."
# استبدل 'YOUR_USERNAME' باسم المستخدم الخاص بك على GitHub
GITHUB_USER="mukhtaruv1991"
BASE_URL="https://raw.githubusercontent.com/$GITHUB_USER/gh-publisher/main"
TARGET_DIR="$HOME/bin"

mkdir -p "$TARGET_DIR"
echo "  -> Downloading gh-publish..."
if curl -sL "$BASE_URL/gh-publish" -o "$TARGET_DIR/gh-publish"; then
  chmod +x "$TARGET_DIR/gh-publish"
  echo "     ✅ 'gh-publish' installed successfully."
else
  echo "     ❌ Failed to download 'gh-publish'."
  exit 1
fi

echo "  -> Checking dependencies..."
pkg install -y git jq curl

echo ""
echo "🎉 Installation complete!"
echo "To get started, run 'gh-publish --setup' to configure your GitHub token."
