#!/bin/bash

# Some commented lines are commands only make sense for my PC.

# 1. Download necessary files.	
	
	# 1.1 yt-dlp.
	
	# sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
	# sudo chmod a+rx /usr/local/bin/yt-dlp
	
	# 1.2 Cloning repository.
	
	cd ~/Downloads/	
	git clone https://github.com/BassHero/ubuntu_gaming.git
	
	cd ubuntu_gaming
	# git clone https://github.com/Ta180m/zenpower3.git
	# git clone https://github.com/ivalnic2016/rtl8821CU.git
	
	# 1.3 Downloading files.
	
	wget -i files.txt
	mkdir bsnes Gamemode
	mv v115.tar.gz libgtk* bsnes 
	mv gamemode* libgamemode* Gamemode	
	file-roller -h *.tar.*
	
	cd applications
	cp *.desktop ~/.local/share/applications
	cd ~/Downloads/ubuntu_gaming/icons
	sudo cp *.png /usr/share/icons/
	cd ~/Downloads/ubuntu_gaming/scripts/
	cp *.sh ~
	cd ~/Downloads/ubuntu_gaming/
	
	# 1.4 Installing Google Chrome.
	
	# sudo dpkg -i google-chrome-stable_current_amd64.deb
	
# 2. Installing Wine Staging. https://wiki.winehq.org/Ubuntu	 
	
	sudo dpkg --add-architecture i386
	sudo mkdir -pm755 /etc/apt/keyrings
	sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
	sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources 
	sudo apt update	
	sudo apt install --install-recommends winehq-staging -y
	sudo apt install winetricks protontricks -y
	
	# 2.1 Opening Wine only to create a prefix .wine at home directory, just click on OK button after wine configuration window open.
	
	winecfg

# 3. Add repositories.
	
	sudo add-apt-repository ppa:lutris-team/lutris -y
	sudo add-apt-repository ppa:obsproject/obs-studio -y
	# sudo add-apt-repository ppa:openrazer/stable -y
	sudo add-apt-repository ppa:pcsx2-team/pcsx2-daily -y
	# sudo add-apt-repository ppa:polychromatic/stable -y
	sudo add-apt-repository ppa:mborgerson/xemu -y
	sudo apt update

# 4. Installing libs and programs.

	# 4.1 Libs.
	
	sudo apt install libao-dev libasound2-dev libcanberra-gtk-module libcairo2-dev libflac-dev libgtk2.0-dev libhidapi-hidraw0 libopenal-dev libpulse-dev libsdl2-dev libsfml-network2.5 libsndfile1-dev libudev-dev libxv-dev -y
	
	# 4.2 Programs.
	
	sudo apt install synaptic antimicro jstest-gtk lutris pcsx2-unstable steam stella ttf-mscorefonts-installer xemu -y	
	
	# sudo apt install audacity cmake cpu-x ffmpeg gimp gparted gscan2pdf handbrake kdenlive hexchat mesa-common-dev mkvtoolnix-gui obs-studio openrazer-meta pdfarranger polychromatic python2 python3-pip python-is-python3 stressapptest vlc webp-pixbuf-loader 
	
	# 4.3 Opening Steam (Do login, enable steamplay for all titles, install a windows game, (sugestion: Pool 2D - Poolians (only 50 MB), then close steam.
	
	steam	
	
# 5. Installing the *.deb files of BSNES, Gamemode and Lutris.

	# 5.1 BSNES dependêncies
	
	cd ~/Downloads/ubuntu_gaming/bsnes
	sudo dpkg -i *.deb
	
	# 5.1 Gamemode
	
	sudo apt remove gamemode -y
	cd ~/Downloads/ubuntu_gaming/Gamemode
	sudo dpkg -i *.deb	
	
	# 5.3 Opening Lutris, wait for verifications, downlod dxvk versions, etc., after completly open, close then.
	
	lutris
	cd ~/Downloads/ubuntu_gaming/	
	sudo dpkg -i lutris_0.5.13_all.deb
	
# 6. Installing GE-Proton and lutris-GE	(Open Steam to folders be created, already done in # 4.3)
	
	mv GE-Proton8-4 ~/.steam/debian-installation/compatibilitytools.d/
	mv lutris-GE-Proton8-8-x86_64 ~/.local/share/lutris/runners/wine/

# 7. Installing Emulators DuckStation, Redream, Mednafen and BSNES

	cd ~/Games/
	mkdir bsnes redream	
	
	# 7.1 Stella (Atari)	
	
	ln -s /mnt/4_TB/Atari/Roms stella
	cd ~/Downloads/ubuntu_gaming/
	sudo dpkg -i stella_*.deb	
	
	# 7.2 BSNES (Super Nintendo)
	
	cd ~/Downloads/ubuntu_gaming/bsnes/
	file-roller -h v115.tar.gz
	cd bsnes-*
	make -C bsnes local=false
	mkdir bsnes-nightly
	mkdir bsnes-nightly/Database
	mkdir bsnes-nightly/Firmware
	cp -a bsnes/out/bsnes bsnes-nightly/bsnes
	cp -a bsnes/Database/* bsnes-nightly/Database
	cp -a shaders bsnes-nightly/Shaders
	cp -a GPLv3.txt bsnes-nightly
	zip -r bsnes-nightly.zip bsnes-nightly
	cp -r bsnes-nightly ~/Games
	
	# 7.3 DuckStation (PlayStation)
	
	cd ~/Downloads/ubuntu_gaming/
	chmod 777 duckstation-qt-x64.AppImage
	cp duckstation-qt-x64.AppImage ~
	cd ~
	./duckstation-qt-x64.AppImage
	cd ~/Downloads/ubuntu_gaming/bios/
	cp *.BIN ~/.local/share/duckstation/bios/
	
	# 7.4 Redream (Dreamcast)
	
	cd ..
	cp redream ~/Games/redream/
	
	# 7.5 PCSX2 (PlayStation 2)
	
	cd ~/.config/PCSX2/
	rm -r bios
	ln -s '/mnt/4_TB/PlayStation 2/bios' bios
	ln -s '/mnt/4_TB/PlayStation 2/roms' roms
	
	# 7.6 Mednafen (multi-system)
	
	cd mednafen	
	echo "Configuring and compiling Mednafen."
	./configure	
	make -j4
	echo "Installing Mednafen."
	sudo make install
	
		# Sega Saturn's and PlayStation's bios should be placed in ~/.mednafen/firmware (167 command line do it automatic).
		
	cd ~/Downloads/ubuntu_gaming/games/
	
		# The game bellow will be open only to mednafen emulator create a folder e save configs.
		# It should be made for any system. More details in https://mednafen.github.io/documentation/ .
	
	mednafen -sound.driver sdl -cd.image_memcache 1 -sms.shader goat -sms.stretch aspect -sms.fm 1 -sms.territory domestic 'Natal do Mymo (Psycho Fox Hack).zip'
	# mednafen -nes.correct_aspect 1 -nes.ntsc.preset rgb -nes.shader goat 'Tiny Toon Adventures (USA).zip'
	cd ~/Downloads/ubuntu_gaming/firmware/	
	cp *.* ~/.mednafen/firmware/
	
	echo "Installation finished. Please reboot the system."		
	
# 8. Extras (only for nvidia's graphic card users).

# 8.1 Control nvidia graphics card fans rotation on nvidia X Server Settings.

	# sudo gedit /etc/X11/Xwrapper.config
	# Add this line before allowed_users=console:
	# needs_root_rights=yes
	
# 8.2 Commands to limitate GPU's clock and save energy on nvidia-smi.
	
	# sudo nvidia-smi -pm 1 (enable persistence mode)
	# sudo nvidia-smi -lgc 210,1290 (set mininum and maximum clock)
	# sudo nvidia-smi -rgc (reset clock)
	# sudo nvidia-smi -pl 125.00 (set power limit, each graphic card has your own max and min settings)
	# Ex: RTX 2060 super: power limit min: 125 W, power limit max: 184 W.
	
