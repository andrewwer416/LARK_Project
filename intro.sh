#!/usr/bin/bash
# EDIT WORDS!!!!!!
# Intro Phase: select an orb
export head="$PWD"
export my_stats="$PWD"/Data/my_stats.txt
export enemy_stats="$PWD"/Data/enemy_stats.txt
echo "You awake. 3 Orbs green red blue."
while true
do
	read -p "Please make a choice" orb
	case $orb in
		Green|green|Blue|blue|Red|red)
			echo "You earth"
			mv .Orb Orb
			echo "Use cd Orb to grab the orb"
			return
			;;
		*)
			echo "Please enter valid orb"
	esac
done
return
