#!/bin/bash
set -e

echo "Updating App Icon to Canada Theme..."

# 1. Download a clean Maple Leaf Icon (from Wikimedia)
# We save it temporarily as 'new_icon.png'
curl -L "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Maple_Leaf_%28Canada_Flag%29.svg/512px-Maple_Leaf_%28Canada_Flag%29.svg.png" -o new_icon.png

# 2. Define the target directories
DIRS=(
  "app/src/main/res/mipmap-mdpi"
  "app/src/main/res/mipmap-hdpi"
  "app/src/main/res/mipmap-xhdpi"
  "app/src/main/res/mipmap-xxhdpi"
  "app/src/main/res/mipmap-xxxhdpi"
)

# 3. Copy the new icon into every folder
# We replace both 'ic_launcher.png' (square) and 'ic_launcher_round.png' (round)
for dir in "${DIRS[@]}"; do
  mkdir -p "$dir" # Ensure folder exists
  cp new_icon.png "$dir/ic_launcher.png"
  cp new_icon.png "$dir/ic_launcher_round.png"
done

# 4. Clean up
rm new_icon.png

echo "DONE! App icon updated successfully."