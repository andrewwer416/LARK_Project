#!/usr/bin/bash
enemy_name="$team_name"
sed -i 's/\r$//' $my_stats
sed -i 's/\r$//' $enemy_stats
cat $my_stats
read -r _ usr_hp usr_m1 usr_m2 usr_m3 < $my_stats
read -r _ enem_hp enem_m1 enem_m2 enem_m3 < $enemy_stats
echo "$enemy_name: Before we get to the real deal, I'm going to show you how to make your moves. \
first, you will be prompted with options consisting of your moves. You will type a number corresponding to \
the option you would like to select, then press enter. Try doing it now"
usr_move=0
while true
do
	echo
	echo -e "Your health: $usr_hp\nEnemy health: $enem_hp\
\n\n1) $usr_m1\
\n2) $usr_m2\
\n3) $usr_m3\
\n4) Block\
\n5) Display Move Stats"
	read -p "Select your move: " opt
	case $opt in
		1)
		usr_move=$usr_m1
		break
		;;
		2)
		usr_move=$usr_m2
		break
		;;
		3)
		usr_move=$usr_m3
		break
		;;
		4)
		usr_move="Block"
		echo "You can't block on the first move!"
		;;
		5)
		echo
		echo "Your available moves are:"
		cat $moves | grep -e $usr_m1 -e $usr_m2 -e $usr_m3
		;;
		*)
		echo "Please enter a valid option"
		;;
	esac
done
move=($(grep $usr_move $moves))
move_dmg="${move[1]}"
move_acc="${move[2]}"
if [ $(( $RANDOM % 100)) -lt $move_acc ] ; then
	((enem_hp -= $move_dmg))
	echo "You dealt $move_dmg damage with $usr_move!"
else
	echo "$enemy_name has dodged your attack!"
fi
echo
echo -e "Your health: $usr_hp\nEnemy health: $enem_hp"
echo
echo "$enemy_name: Perfect form! Let's start over and give it all we got!"
read -r _ enem_hp enem_m1 enem_m2 enem_m3 < $enemy_stats
turn=$(( $RANDOM % 2))
team_block=0
enem_block=0
while [ $usr_hp -gt 0 -a $enem_hp -gt 0 ]
do
	echo
	echo -e "Your health: $usr_hp\nEnemy health: $enem_hp"
	echo
	if [ $turn -eq 0 ]; then
		while true
		do
			echo -e "1) $usr_m1\
\n2) $usr_m2\
\n3) $usr_m3\
\n4) Block\
\n5) Display Move Stats"
			read -p "Select your move: " opt
			case $opt in
				1)
				usr_move=$usr_m1
				team_block=0
				break
				;;
				2)
				usr_move=$usr_m2
				team_block=0
				break
				;;
				3)
				usr_move=$usr_m3
				team_block=0
				break
				;;
				4)
				usr_move="Block"
				if [ $enem_block -eq 1 ]; then
					echo "You can't block right now"
				else
					team_block=1
					break
				fi
				;;
				5)
				echo
				echo "Your available moves are:"
				cat $moves | grep -e $usr_m1 -e $usr_m2 -e $usr_m3 
				;;
				*)
				echo "Please enter a valid option"
				;;
			esac
		done
		if [ $enem_block -eq 1 ]; then
			echo "$enemy_name blocked your attack!"
			enem_block=0
		elif [ $team_block -eq 1 ]; then
			echo "You are blocking."
		else
			echo "$move"
			move=($(grep $usr_move $moves))
			move_dmg="${move[1]}"
			move_acc="${move[2]}"
			if [ $(( $RANDOM % 100)) -lt $move_acc ]; then
				((enem_hp -= $move_dmg))
				echo "You dealt $move_dmg damage with $usr_move!"
			else
				echo "$enemy_name has dodged your attack!"
			fi
		fi
		turn=1
	else
		while true
		do
			opt=$(($RANDOM % 4 + 1))
			case $opt in
				1)
				enem_move=$enem_m1
				block=0
				break
				;;
				2)
				enem_move=$enem_m2
				block=0
				break
				;;
				3)
				enem_move=$enem_m3
				block=0
				break
				;;
				4)
				enem_move="Block"
				if [ $team_block -eq 1 ]; then
					echo "You can't block right now"
				else
					enem_block=1
					break
				fi
				;;
			esac
		done
		if [ $team_block -eq 1 ]; then
			echo "You blocked $enemy_name's attack!"
			team_block=0
		elif [ $enem_block -eq 1 ]; then
			echo "$enemy_name is blocking."
		else
			move=($(grep $enem_move $moves))
			echo "$move"
			move_dmg="${move[1]}"
			move_acc="${move[2]}"
			if [ $(( $RANDOM % 100)) -lt $move_acc ]; then
				((usr_hp -= $move_dmg))
				echo "$enemy_name dealt $move_dmg damage with $enem_move!"
			else
				echo "You dodged $enemy_name's attack!"
			fi
		fi
		turn=0
	fi
done
if [ $usr_hp -le 0 ]; then
echo "You Lost"
else
echo "You Won"
fi
