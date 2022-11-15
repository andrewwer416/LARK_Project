#!/usr/bin/bash


case $orb in
	Blue|blue)
		echo "As you embrace the blue orb \
		you begin to ascend. Rays from \
		an unknown origin gleam around \
		you. A world 002ing with \
		happiness and prosperity presents \
		itself before you. \
		Welcome to Heaven."
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
	;;
	Red|red)
		echo "As you embrace the red orb \
		you begin to rocket downward at \
		an alarming rate. You feel heat \
		surge around you, hot enough to \
		burn your skin off if you had any. \
		Anguished screams sound out around. \
		Welcome to the underworld."
	;;
esac
read -p "Do you need a tutorial to start your journey?(Y/n)" inp
while true
	do
	case $inp in
		Y|y)
			echo "Use cd Tutorial to start the tutorial"
			mv .Tutorial Tutorial
			exit
		;;
		N|n)
			echo "Use cd Battle1 to start your first battle"
			mv .Battle1 Battle1
			cd Battle1
			exit
		;;
		*)
			echo "Please enter a valid option"
	esac
done
