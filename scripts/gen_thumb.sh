INPUT_DIR="$HOME/wallpapers/wallpapers"
OUTPUT_DIR="$HOME/.krypton/thumbnails"
THUMB_SIZE="x120"

mkdir -p $OUTPUT_DIR

shopt -s nullglob
for img in "$INPUT_DIR"/*.{jpg,png,webp,jpeg}; do
    filename=$(basename "$img")
    target_thumb="$OUTPUT_DIR/$filename"

    if [ ! -f "$target_thumb" ] || [ "$img" -nt "$target_thumb" ]; then
        magick "$img" -thumbnail "$THUMB_SIZE" -quality 80 "$target_thumb"
    fi
done

echo "done"