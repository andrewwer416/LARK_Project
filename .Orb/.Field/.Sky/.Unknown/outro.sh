#!/usr/bin/bash
if [ -e $Cerberus ]; then
	echo "You have to dispose of Cerberus before you can move to the end!"
	return
fi
echo "*As Cerberus' body begins to vanish, you notice the Caduceus still remains in this world. With it, you will \
have the ultimate power to lead the $clan_name humans to absolute victory in this time of unbalance. If you were to \
leave it in this crumbling world, balance and struggle would vanish, and there is hope of the three clans ending \
their feud.*"
while true
do
	read -p "Will you take the Caduceus and leave this world? [Y/n]" opt
	case $opt in
		Y|y)
			echo "*You feel your body explode with overwhelming power. Suddenly, you feel a sharp \
pain in your chest. You are dead, but at least the world will regain its balance.*"
		;;
		N|n)
			echo "*As you go to approach the exit, you see it moving infinitely far away from you. \
You begin to see the world around you collapsing. You did what had to be done, and unfortunately, it cost you \
your life.*"
		;;
		*)
			echo "Please enter a valid selection."
		;;
done
echo "THE END"
cd $head
echo "Type 'source reset.sh to play again."
return

