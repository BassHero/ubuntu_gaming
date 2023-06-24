#!/bin/bash

# 1. Download necessary files.
	
	cd /home/$USER/Downloads/
	git clone https://github.com/BassHero/ubuntu_gaming.git
	cd ubuntu_gaming
	git clone https://github.com/Ta180m/zenpower3.git
	git clone https://github.com/ivalnic2016/rtl8821CU.git
	wget -i files.txt
	mkdir bsnes Gamemode
	mv v115.tar.gz libgtk* bsnes 
	mv gamemode* libgamemode* Gamemode	
	file-roller -h *.tar.*
	cd applications
	cp *.desktop /home/$USER/.local/share/applications
	cd /home/$USER/Downloads/ubuntu_gaming/scripts/
	cp *.sh /home/$USER/
	cd /home/$USER/Downloads/ubuntu_gaming/
	
# 2. Add repositories.
	
	sudo add-apt-repository ppa:lutris-team/lutris -y
	sudo add-apt-repository ppa:obsproject/obs-studio -y
	sudo add-apt-repository ppa:openrazer/stable -y
	sudo add-apt-repository ppa:polychromatic/stable -y
	sudo apt update

# 3. Installing programs.
	
	sudo apt install synaptic antimicro audacity build-essential cmake cpu-x ffmpeg gimp gparted gscan2pdf handbrake jstest-gtk kdenlive hexchat libao-dev libayatana-appindicator3-1 libasound2-dev libcanberra-gtk-module libcairo2-dev libflac-dev libgtk2.0-dev libhidapi-hidraw0 libopenal-dev libpulse-dev libsdl2-dev libsfml-network2.5 libsndfile1-dev libudev-dev libxv-dev lutris mesa-common-dev mkvtoolnix-gui obs-studio openrazer-meta pdfarranger pkg-config polychromatic python2 python3-pip python-is-python3 steam stressapptest ttf-mscorefonts-installer vlc webp-pixbuf-loader zip zlib1g-dev -y	
	steam	
	
# 4. Installing the *.deb files.

	sudo dpkg -i google-chrome-stable_current_amd64.deb
	cd /home/$USER/Downloads/ubuntu_gaming/bsnes
	sudo dpkg -i *.deb
	sudo apt remove gamemode -y
	cd /home/$USER/Downloads/ubuntu_gaming/Gamemode
	sudo dpkg -i *.deb
	cd /home/$USER/Downloads/ubuntu_gaming/
	
# 5. Installing Wine Staging https://wiki.winehq.org/Ubuntu	
	
	sudo dpkg --add-architecture i386
	sudo mkdir -pm755 /etc/apt/keyrings
	sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
	sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources 
	sudo apt update	
	sudo apt install --install-recommends winehq-staging -y
	sudo apt install winetricks protontricks -y
	winecfg	
	lutris
	sudo dpkg -i lutris_0.5.13_all.deb
	
# 6. Installing GE-Proton and lutris-GE	
	
	mv GE-Proton8-4 /home/$USER/.steam/debian-installation/compatibilitytools.d/
	mv lutris-GE-Proton8-8-x86_64 /home/$USER/.local/share/lutris/runners/wine/

# 7. Installing Emulators DuckStation, Redream, Mednafen and BSNES

	cd /home/$USER/Games/
	mkdir bsnes redream
	
	# DuckStation
	
	cd /home/$USER/Downloads/ubuntu_gaming/
	chmod 777 duckstation-qt-x64.AppImage
	cp duckstation-qt-x64.AppImage ~
	cd ~
	./duckstation-qt-x64.AppImage
	cd /home/$USER/Downloads/ubuntu_gaming/bios/
	cp *.BIN /home/renato/.local/share/duckstation/bios/
	
	# Redream
	
	cd ..
	cp redream /home/$USER/Games/redream/
	
	# Mednafen
	
	cd mednafen	
	echo "Configurando e compilando o Mednafen."
	./configure	
	make -j8
	echo "Instalando o Mednafen."
	sudo make install
	
		# Detalhe para as bios do sega saturn e PS1 no diretóroi/ /home/$USER/.mednafen/firmware
		# cp .mednafen /home/$USER
		
	cd /home/$USER/Downloads/ubuntu_gaming/games/
	mednafen -sound.driver sdl -sms.shader goat -sms.stretch aspect -sms.fm 1 -sms.territory domestic 'Phantasy Star (pt-BR) [!].sms'
	cd /home/$USER/Downloads/ubuntu_gaming/firmware/	
	cp *.* /home/$USER/.mednafen/firmware/
	
		# Primeira vez que abrir o emulador pode ser necessário mudar o driver de som pra sdl com o comando abaixo sem o #
		# mednafen -sound.driver sdl nomedarom.zip	
		# Para cada sistema é bom adicionar um filtro de shader, que dá a experiência retro, eu gosto do filtro goat.
		# Exemplo de configuração de shader para o sistema Master System (usar sem o #):
		# mednafen -sound.driver sdl -sms.shader goat -sms.stretch aspect -sms.fm 1 -sms.territory domestic nomedarom.zip	
		# Feito uma vez, a configuração fica salva, não precisando ser repetida.
	
	# BSNES
	
	cd /home/$USER/Downloads/ubuntu_gaming/bsnes/
	file-roller -h v115.tar.gz
	cd bsnes-115
	make -C bsnes local=false
	mkdir bsnes-nightly
	mkdir bsnes-nightly/Database
	mkdir bsnes-nightly/Firmware
	cp -a bsnes/out/bsnes bsnes-nightly/bsnes
	cp -a bsnes/Database/* bsnes-nightly/Database
	cp -a shaders bsnes-nightly/Shaders
	cp -a GPLv3.txt bsnes-nightly
	zip -r bsnes-nightly.zip bsnes-nightly
	cp -r bsnes-nightly /home/$USER/Games
	
# 8. Installing yt-dlp.

	sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
	sudo chmod a+rx /usr/local/bin/yt-dlp
	
# 9. Extras.
# 9.1 Control nvidia graphics card fans.

	# sudo gedit /etc/X11/Xwrapper.config
	# Add this line before allowed_users=console:
	# needs_root_rights=yes
	
# 9.2 Commands to limitate GPU's clock save energy.
	
	# ver se precisa digita sempre esse aqui: sudo nvidia-smi -pm 1
	# sudo nvidia-smi -lgc 210,1290
	# sudo nvidia-smi -rgc
	# sudo nvidia-smi -pl 125.00
	# valores disponíveis: power limit min: 125 W
