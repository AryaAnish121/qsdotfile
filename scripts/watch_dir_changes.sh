WATCH_DIR="$HOME/wallpapers/wallpapers"
OUTPUT_DIR="$HOME/.krypton/thumbnails"
THUMB_SIZE="x120"

inotifywait -m -e close_write,delete,moved_to,moved_from --format '%e %f' "$WATCH_DIR" |
while read -r event filename; do
    if [[ "$filename" == .* ]]; then continue; fi
    lower_file="${filename,,}"
    if [[ ! "$lower_file" =~ \.(png|jpg|jpeg|webp)$ ]]; then
        continue 
    fi

    filepath="$WATCH_DIR/$filename"
    target_thumb="$OUTPUT_DIR/$filename"

    if [[ "$event" == *"CLOSE_WRITE"* ]] || [[ "$event" == *"MOVED_TO"* ]]; then
        magick "$filepath" -thumbnail "$THUMB_SIZE" "$target_thumb"
    fi
    if [[ "$event" == *"DELETE"* ]] || [[ "$event" == *"MOVED_FROM"* ]]; then
        rm $target_thumb
    fi
    echo $event, $filename
done