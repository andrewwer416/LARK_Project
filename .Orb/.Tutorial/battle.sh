#!/usr/bin/bash
enemy_name="$team_name"
sed -i 's/\r$//' $moves
sed -i 's/\r$//' $my_stats
sed -i 's/\r$//' $enemy_stats
read -r _ usr_hp usr_m1 usr_m2 usr_m3 < $my_stats
read -r _ enem_hp enem_m1 enem_m2 enem_m3 < $enemy_stats
((usr_hp+=5))
echo -e "${BLUE}$enemy_name${NC}: Before we get to the real deal, I'm going to show you how to make your moves. \
first, you will be prompted with options consisting of your moves. You will type a number corresponding to \
the option you would like to select, then press enter. Try doing it now"
usr_move=0
while true
do
	echo
	echo -e "Your health: ${RED}$usr_hp${NC}\nEnemy health: ${RED}$enem_hp${NC}\
\n\n1) $usr_m1\
\n2) $usr_m2\
\n3) $usr_m3\
\n4) Block\
\n5) Display Move Stats"
	read -p "$(echo -e ${RED}"Select your move: "${NC})" opt
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
		usr_moves=($(grep -e $usr_m1 -e $usr_m2 -e $usr_m3 $moves))
		printf "%-16s %-5s %-8s %-100s\n" "Move" "Power" "Accuracy" "Description"
		printf "%-16s %-5s %-8s %-100s\n" "${usr_moves[0]}" "${usr_moves[1]}" "${usr_moves[2]}" "${usr_moves[3]}"
		printf "%-16s %-5s %-8s %-100s\n" "${usr_moves[4]}" "${usr_moves[5]}" "${usr_moves[6]}" "${usr_moves[7]}"
		printf "%-16s %-5s %-8s %-100s\n" "${usr_moves[8]}" "${usr_moves[9]}" "${usr_moves[10]}" "${usr_moves[11]}"
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
	echo -e "You dealt ${RED}$move_dmg${NC} damage with $usr_move!"
else
	echo -e "${BLUE}$enemy_name${NC} has dodged your attack!"
fi
echo
echo -e "Your health: ${RED}$usr_hp${NC}\nEnemy health: ${RED}$enem_hp${NC}"
echo
echo -e "${BLUE}$enemy_name${NC}: Perfect form! Let's start over and give it all we got!"
read -r _ enem_hp enem_m1 enem_m2 enem_m3 < $enemy_stats
team_block=0
enem_block=0
while [ $usr_hp -gt 0 -a $enem_hp -gt 0 ]
do
	echo
	echo -e "Your health: ${RED}$usr_hp${NC}\nEnemy health: ${RED}$enem_hp${NC}"
	echo
	while true
	do
		echo -e "1) $usr_m1\
\n2) $usr_m2\
\n3) $usr_m3\
\n4) Block\
\n5) Display Move Stats"
		read -p "$(echo -e ${RED}"Select your move: "${NC})" opt
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
			team_block=1
			break
			;;
			5)
			echo
			echo "Your available moves are:"
			usr_moves=($(grep -e $usr_m1 -e $usr_m2 -e $usr_m3 $moves))
			printf "%-16s %-5s %-8s %-100s\n" "Move" "Power" "Accuracy" "Description"
			printf "%-16s %-5s %-8s %-100s\n" "${usr_moves[0]}" "${usr_moves[1]}" "${usr_moves[2]}" "${usr_moves[3]}"
			printf "%-16s %-5s %-8s %-100s\n" "${usr_moves[4]}" "${usr_moves[5]}" "${usr_moves[6]}" "${usr_moves[7]}"
			printf "%-16s %-5s %-8s %-100s\n" "${usr_moves[8]}" "${usr_moves[9]}" "${usr_moves[10]}" "${usr_moves[11]}"
			;;
			*)
			echo "Please enter a valid option"
			;;
		esac
	done
	while true
	do
		opt=$(($RANDOM % 4 + 1))
		case $opt in
			1)
			enem_move=$enem_m1
			enem_block=0
			break
			;;
			2)
			enem_move=$enem_m2
			enem_block=0
			break
			;;
			3)
			enem_move=$enem_m3
			enem_block=0
			break
			;;
			4)
			enem_move="Block"
			enem_block=1
			break
			;;
		esac
	done
	echo
	if [ $enem_block -eq 1 -a $team_block -eq 0 ]; then
		echo -e "${BLUE}$enemy_name${NC} blocked your attack!"
		enem_block=0
	elif [ $team_block -eq 1 -a $enem_block -eq 0 ]; then
		echo -e "You blocked ${BLUE}$enemy_name's${NC} attack!"
		team_block=0
	elif [ $team_block -eq 1 -a $enem_block -eq 1 ]; then
		echo "You both tried to block!"
	else
		usr_atk=($(grep $usr_move $moves))
		usr_dmg="${usr_atk[1]}"
		usr_acc="${usr_atk[2]}"
		if [ $(( $RANDOM % 100)) -lt $usr_acc ]; then
			((enem_hp -= $usr_dmg))
			echo -e "You dealt ${RED}$move_dmg${NC} damage with $usr_move!"
		else
			echo -e "${BLUE}$enemy_name${NC} has dodged your attack!"
		fi
		enem_atk=($(grep $enem_move $moves))
		enem_dmg="${enem_atk[1]}"
		enem_acc="${enem_atk[2]}"
		if [ $(( $RANDOM % 100)) -lt $enem_acc ]; then
			((usr_hp -= $enem_dmg))
			echo -e "${BLUE}$enemy_name${NC} dealt $enem_dmg damage with $enem_move!"
		else
			echo -e "You dodged ${BLUE}$enemy_name's${NC} attack!"
		fi
	fi
done
if [ $usr_hp -le 0 ]; then
echo -e "${BLUE}$enemy_name${NC}: Get your head in the game! You won't have a second chance on the battlefield."
else
echo -e "${BLUE}$enemy_name${NC}: Good work! Seems like your injuries weren't too bad."
fi
echo -e "${BLUE}$enemy_name${NC}: If you want another chance to spar, type 'source battle.sh' once again. If not, lets start go back to camp by typing 'cd ..' then 'source intro.sh' to check in with me."
tut_done=1
