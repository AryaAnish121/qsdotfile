(
    IMG_PATH="/tmp/lens_screenshot.png"
    
    grim -g "$(slurp)" "$IMG_PATH" || exit 1

    URL=$(curl -s -F "reqtype=fileupload" -F "time=1h" -F "fileToUpload=@$IMG_PATH" https://litterbox.catbox.moe/resources/internals/api.php)


    if [[ "$URL" == http* ]]; then
        xdg-open "https://lens.google.com/uploadbyurl?url=${URL}"
    else
        notify-send "Screenshot Search Failed" "Could not upload image."
    fi

    rm -f "$IMG_PATH"

) > /dev/null 2>&1 < /dev/null