#!/usr/bin/bash
# EDIT WORDS!!!!!!
# Intro Phase: select an orb
export head="$PWD"
export inventory="$PWD"/.Inventory
export my_stats="$PWD"/.Data/my_stats.txt
export enemy_stats="$PWD"/.Data/enemy_stats.txt
export moves="$PWD"/.Characters/Moves.txt
export characters="$PWD"/.Characters/Character.txt
export Cerberus="$PWD"/.Characters/.Cerberus
echo "You awaken within a void. You can see nothing but three orbs rotating around you. As you reach your non-existent hand out to the orbs you feel struggle and anguish within each. The red orb feels warm but foreboding. \
The green orb is full of hope and promise. The blue orb seems to hold plentiful wealth. Fate calls you to choose one of these orbs."
tut_done=0
if [ -e .Orb ]; then
	mv .Orb Orb
fi
while true
do
	read -p "Which orb holds your destiny? " orb
	case $orb in
		Green|green|Blue|blue|Red|red)
			echo "To finalize your selection of the $orb orb, type 'cd Orb'. Retype 'source intro.sh' to change your decision."
			return
			;;
		*)
			echo "Please select a valid orb"
	esac
done
return
