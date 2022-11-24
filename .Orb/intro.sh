#!/usr/bin/bash
battle1=0
if [ $tut_done -eq 1 ]; then
	echo -e "${BLUE}$team_name${NC}: Alright, now that you're all warmed up, lets start our journey. Let's head the field by typing 'cd Field'."
	mv .Field Field
	return
fi
charopt=$(( $RANDOM % 2))
case $orb in
	Blue|blue)
		echo -e "${RED}As you embrace the blue orb \
you begin to ascend. Rays from \
an unknown origin gleam around \
you. A world oozing with \
happiness and prosperity presents \
itself before you.${NC}"
		if [ $charopt == 0 ]; then
			export character_name="Wukong"
			export team_name="Ares"
			
		elif [ $charopt == 1 ]; then
			export character_name="Ares"
			export team_name="Wukong"
		fi
		sed -i '/Wukong/d' $head/.Characters/Names.txt
		sed -i '/Ares/d' $head/.Characters/Names.txt
		export clan_name="Divine"
	;;
	Green|green)
		echo -e "${RED}As you embrace the green orb \
the world begins to materialize \
around you. You witness large ships \
on a larger ocean, children running \
and playing, and farmers plowing \
endless fields. A gentle wind passes \
undisturbed through your body.${NC}"
		if [ $charopt == 0 ]; then
			export character_name="Icarus"
			export team_name="King_Arthur"
		elif [ $charopt == 1 ]; then
			export character_name="King_Arthur"
			export team_name="Icarus"
		fi
		sed -i '/King_Arthur/d' $head/.Characters/Names.txt
		sed -i '/Icarus/d' $head/.Characters/Names.txt
		export clan_name="Heroic"
	;;
	Red|red)
		echo -e "${RED}As you embrace the red orb \
you begin to rocket downward at \
an alarming rate. You feel heat \
surge around you, hot enough to \
burn your skin off if you had any. \
Anguished screams sound out around.${NC}"
		if [ $charopt == 0 ]; then
			export character_name="Thanatos"
			export team_name="Apollyon"
		elif [ $charopt == 1 ]; then
			export character_name="Apollyon"
			export team_name="Thanatos"
		fi
		sed -i '/Thanatos/d' $head/.Characters/Names.txt
		sed -i '/Apollyon/d' $head/.Characters/Names.txt
		export clan_name="Demonic"
	;;
esac
cat $characters | grep $character_name > $my_stats
cat $characters | grep $team_name > $enemy_stats
echo -e "${BLUE}???${NC}: Ah ${RED}$character_name${NC}, you finally woke up. You don't remember me?\
 My name is ${BLUE}$team_name${NC}. When you passed out after the last fight, I took you back to camp. \
Ever since this war started, shit hit the fan fast. The battles haven't stopped coming our way. \
Whatever the case, we need to get back to our mission."
read -p "Do you still remember how to fight? [Y/n]" inp
while true
	do
	case $inp in
		N|n)
			echo -e "${BLUE}$team_name${NC}: Guess we better hit the training ground first. Type 'cd Tutorial' to start the tutorial"
			mv .Tutorial Tutorial
			return
		;;
		Y|y)
			echo -e "${BLUE}$team_name${NC}: Perfect! Let's head towards that field then. Type 'cd Field' whenever you're ready"
			if [ -e .Field ]; then
				mv .Field Field
			fi
			battle1=0
			return
		;;
		*)
			echo "Please enter a valid option"
	esac
done
