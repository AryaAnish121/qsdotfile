rm -rf ~/tmp/krypton
mkdir -p  ~/tmp/krypton
cd  ~/tmp/krypton
set -e

confirm_installation () {
    local response
    read -p "You have yay, sf fonts installed right..? Additonally cloudflare warp is recommended (Y/n): " response
    case "$response" in 
        [yY] | [yY][eE][sS] | "")
        echo "oki got it"
        ;;
    *)
        echo "pwease install them 🫠"
        exit 1
        ;;
    esac
}

install_pacman_stuff () {
    sudo pacman --noconfirm --needed -S unzip fastfetch asciiquarium adw-gtk-theme matugen dunst xdg-desktop-portal-hyprland archlinux-xdg-menu zsh git ttf-jetbrains-mono quickshell hyprlock hypridle hyprpaper hyprsunset zathura zathura-pdf-mupdf imagemagick grim slurp wl-clipboard hyprpicker inotify-tools libnotify tesseract tesseract-data-eng tesseract-data-hin
}

install_yay_stuff () {
    yay -S --needed --noconfirm apple_cursor ttf-phosphor-icons
}

install_wallpapers() {
    rm -rf ~/wallpapers/wallpapers
    git clone https://github.com/AryaAnish121/wallpapers.git ~/wallpapers/wallpapers
    ~/krypton/scripts/gen_thumb.sh
}

install_vicinae () {
    curl -fsSL https://vicinae.com/install | bash
}

install_hyprselect () {
    mkdir -p  ~/.local/hyprselect
    git clone https://github.com/jmanc3/hyprselect
    cd hyprselect
    make
    mv hyprselect.so ~/.local/hyprselect/hyprselect.so
    cd ..
    rm -rf hyprselect
}

install_icons () {
    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
    cd WhiteSur-icon-theme
    ./install.sh
    cd ..
    rm -rf WhiteSur-icon-theme
}

install_emojis () {
    yay -S --needed ttf-apple-emoji
    echo "you might need to uninstall and reinsatll the noto emojis thingy for the apple emoji to work"
}

install_matugen () {
    rm -rf ~/.config/matugen
    git clone https://github.com/AryaAnish121/matugen.git ~/.config/matugen
}

install_hypr () {
    cp ~/.config/hypr/hyprland.lua ~/tmp/krypton
    rm -rf ~/.config/hypr
    git clone https://github.com/AryaAnish121/hypr.git ~/.config/hypr
    mv ~/tmp/krypton/hyprland.lua ~/.config/hypr
    echo "loadfile(os.getenv(\"HOME\") .. \"/.config/hypr/krypton.lua\")()" >> ~/.config/hypr/hyprland.lua
}

install_quickshell () {
    rm -rf ~/krypton
    git clone https://github.com/AryaAnish121/krypton.git ~/krypton
}

install_fastfetch () {
    rm -rf ~/.config/fastfetch
    git clone https://github.com/AryaAnish121/fastfetch.git ~/.config/fastfetch
}

post_install() {
    echo -e "recommended to run: \e[1msudo pacman -S intel-media-driver opencl-mesa\e[0m for intel gpus; later may or maynot be as useful (mainly for davinci resolve)"
    echo -e "apps to quickstart: \e[1myay -S visual-studio-code-bin google-chrome vesktop\e[0m; \e[1msudo pacman -S obs-studio spotify-launcher\e[0m; and apps like spicetify"
    echo "you still have to configure teh default file manager and shit in default hyprland config"
    echo "make sure to change the firefox profile in matugen config before running the wallpaper picker"
    echo "you also might want to add fastfetch to your zshrc and select your font and icon pack in gtk settings"
    echo -e "also recommended to install \e[1mpywalfox\e[0m; spicetify theme with \e[1mhttps://github.com/InioX/matugen-themes#spicetify-sleek\e[0m"
}

confirm_installation
install_pacman_stuff
install_yay_stuff
install_icons
install_vicinae
install_matugen
install_quickshell
install_wallpapers
install_hyprselect
install_hypr
install_fastfetch
install_emojis
post_install
