#!/usr/bin/bash
battle1=0
if [ $tut_done -eq 1 ]; then
	echo "$team_name: Alright, now that you're all warmed up, lets find our way back to base. Let's head into that field over there by typing 'cd Field'."
	mv .Field Field
	return
fi
charopt=$(( $RANDOM % 2))
case $orb in
	Blue|blue)
		echo "As you embrace the blue orb \
you begin to ascend. Rays from \
an unknown origin gleam around \
you. A world oozing with \
happiness and prosperity presents \
itself before you. \
Welcome to Heaven."
		if [ $charopt == 0 ]; then
			export character_name="Wukong"
			export team_name="Ares"
			
		elif [ $charopt == 1 ]; then
			export character_name="Ares"
			export team_name="Wukong"
		fi
		sed -i '/Wukong/d' $head/.Characters/Names.txt
		sed -i '/Ares/d' $head/.Characters/Names.txt
	;;
	Green|green)
		echo "As you embrace the green orb \
the world begins to materialize \
around you. You witness large ships \
on a larger ocean, children running \
and playing, and farmers plowing \
endless fields. A gentle passes \
undisturbed through your body. \
Welcome to Earth."
		if [ $charopt == 0 ]; then
			export character_name="Icarus"
			export team_name="King_Arthur"
		elif [ $charopt == 1 ]; then
			export character_name="King_Arthur"
			export team_name="Icarus"
		fi
		sed -i '/King_Arthur/d' $head/.Characters/Names.txt
		sed -i '/Icarus/d' $head/.Characters/Names.txt
	;;
	Red|red)
		echo "As you embrace the red orb \
you begin to rocket downward at \
an alarming rate. You feel heat \
surge around you, hot enough to \
burn your skin off if you had any. \
Anguished screams sound out around. \
Welcome to the underworld."
		if [ $charopt == 0 ]; then
			export character_name="Thanatos"
			export team_name="Cerberus"
		elif [ $charopt == 1 ]; then
			export character_name="Cerberus"
			export team_name="Thanatos"
		fi
		sed -i '/Thanatos/d' $head/.Characters/Names.txt
		sed -i '/Cerberus/d' $head/.Characters/Names.txt
	;;
esac
cat $characters | grep $character_name > $my_stats
cat $characters | grep $team_name > $enemy_stats
echo "???: Ah $character_name, you finally woke up. You don't remember me?\
 My name is $team_name. I found you lying on the beach passed out. \
Ever since this war started, shit hit the fan fast. It's just battle after battle. \
Well, we have to make our way back to camp."
read -p "Do you still remember how to fight? [Y/n]" inp
while true
	do
	case $inp in
		N|n)
			echo "$team_name: Guess we better hit the training ground. Type 'cd Tutorial' to start the tutorial"
			mv .Tutorial Tutorial
			return
		;;
		Y|y)
			echo "$team_name: Perfect! Now let us make our way back to base, Type 'cd Field' whenever you're ready"
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