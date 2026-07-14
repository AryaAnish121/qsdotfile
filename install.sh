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
    sudo pacman --noconfirm --needed -S unzip fastfetch asciiquarium adw-gtk-theme matugen dunst xdg-desktop-portal-hyprland archlinux-xdg-menu zsh git quickshell hyprlock hypridle hyprpaper hyprsunset zathura zathura-pdf-mupdf imagemagick grim slurp wl-clipboard hyprpicker inotify-tools libnotify tesseract tesseract-data-eng tesseract-data-hin jq ttf-jetbrains-mono-nerd gnome-clocks gnome-calculator baobab base-devel nautilus
}

install_yay_stuff () {
    yay -S --needed --noconfirm apple_cursor ttf-phosphor-icons
}

install_wallpapers() {
    rm -rf ~/wallpapers/wallpapers
    git clone https://github.com/AryaAnish121/wallpapers.git ~/wallpapers
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
    cd ~/.local/share/icons/WhiteSur/apps/scalable
    sudo cp terminal.svg kitty.svg
    cd  ~/tmp/krypton
}

install_emojis () {
    yay -S --needed ttf-apple-emoji
    sudo ln -sf /usr/share/fontconfig/conf.avail/75-apple-color-emoji.conf /etc/fonts/conf.d/
    fc-cache -f -v
}

install_matugen () {
    rm -rf ~/.config/matugen
    git clone https://github.com/AryaAnish121/matugen.git ~/.config/matugen

    mkdir -p ~/.config/gtk-4.0/
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

install_kitty () {
    rm -rf ~/.config/kitty
    git clone https://github.com/AryaAnish121/kitty.git ~/.config/kitty
}

post_install() {
    echo -e "\033[1;31mRun sudo rm -f ~/.config/gtk-4.0/gtk.css after running nwg-look (GTK Settings) and setting adw-gtk as the theme\033[0m"
    echo -e "recommended to run: \e[1msudo pacman -S intel-media-driver opencl-mesa\e[0m for intel gpus; later may or may not be as useful (mainly for davinci resolve)"
    echo -e "apps to quickstart: \e[1myay -S visual-studio-code-bin google-chrome vesktop\e[0m; \e[1msudo pacman -S obs-studio spotify-launcher\e[0m; and apps like spicetify"
    echo "you still have to configure the default file manager and shit in default hyprland config"
    echo "make sure to change the firefox profile in matugen config before running the wallpaper picker"
    echo "you also might want to add fastfetch to your zshrc and select your font, icon pack and cursor in gtk settings; also choose fonts and theme in kitty"
    echo -e "recommended to install all colors themes in matugen config using the guide: https://github.com/InioX/matugen-themes"
}

# confirm_installation
# install_pacman_stuff
# install_yay_stuff
# install_icons
# install_vicinae
# install_matugen
# install_kitty
# install_quickshell
# install_wallpapers
# install_hyprselect
# install_hypr
# install_fastfetch
# install_emojis
post_install
