#!/bin/bash

# 1. Download do que é necessário.
	
	cd /home/$USER/Downloads/
	# mkdir DL
	# cp baixar.txt /home/$USER/Downloads/DL
	cd DL
	wget -i ../baixar.txt
	# wget -i baixar.txt
	mkdir bsnes Gamemode
	mv v115.tar.gz libgtk* bsnes 
	mv gamemode* libgamemode* Gamemode
	git clone https://github.com/Ta180m/zenpower3.git
