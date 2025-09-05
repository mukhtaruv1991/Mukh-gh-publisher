#!/data/data/com.termux/files/usr/bin/bash

# --- Intelligent Installer for gh-publish ---

echo "🚀 Installing gh-publish tool..."

# --- 1. Define GitHub source and local target ---
# استبدل 'mukhtaruv1991' باسم المستخدم الخاص بك إذا تغير
GITHUB_USER="mukhtaruv1991"
GITHUB_REPO="gh-publisher"
BASE_URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/main"
TARGET_DIR="$HOME/bin"

# --- 2. Create Target Directory ---
mkdir -p "$TARGET_DIR"

# --- 3. Download and Install the Tool ---
echo "  -> Downloading the latest version of gh-publish..."
if curl -sL "$BASE_URL/gh-publish" -o "$TARGET_DIR/gh-publish"; then
  chmod +x "$TARGET_DIR/gh-publish"
  echo "     ✅ 'gh-publish' installed successfully."
else
  echo "     ❌ Failed to download 'gh-publish'. Please check your internet connection and the repository URL."
  exit 1
fi

# --- 4. NEW: Intelligent Dependency Check ---
echo "  -> Checking for required dependencies..."

# قائمة المتطلبات الأساسية للأداة
DEPS=("git" "curl" "jq")
# قائمة الحزم التي يجب تثبيتها
PACKAGES_TO_INSTALL=()

for dep in "${DEPS[@]}"; do
  # استخدم `command -v` للتحقق من وجود الأمر
  if ! command -v "$dep" &> /dev/null; then
    echo "     - Dependency '$dep' is missing. Adding to install list."
    PACKAGES_TO_INSTALL+=("$dep")
  else
    echo "     - Dependency '$dep' is already installed. ✅"
  fi
done

# تثبيت الحزم الناقصة فقط إذا كانت القائمة غير فارغة
if [ ${#PACKAGES_TO_INSTALL[@]} -gt 0 ]; then
  echo "  -> Installing missing packages: ${PACKAGES_TO_INSTALL[*]}..."
  pkg install -y "${PACKAGES_TO_INSTALL[@]}"
else
  echo "  -> All dependencies are already satisfied."
fi

# --- 5. Final Message ---
echo ""
echo "🎉 Installation complete!"
echo "To get started, run 'gh-publish --setup' to configure your GitHub token."
echo "After setup, you can publish any project by running 'gh-publish' from its directory."

