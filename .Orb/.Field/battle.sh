#!/usr/bin/bash
if [ $battle1 -eq 0 ]; then
	echo "Please type 'source intro.sh' before coming into this battle."
	return
fi
sed -i 's/\r$//' $my_stats
sed -i 's/\r$//' $enemy_stats
read -r _ usr_hp usr_m1 usr_m2 usr_m3 < $my_stats
read -r _ enem_hp enem_m1 enem_m2 enem_m3 < $enemy_stats
((usr_hp+=5))
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
echo "You were defeated. Type 'source battle.sh' to give it another shot"
return
else
	echo
	echo -e "${BLUE}$team_name${NC}: *Panting* Whew. These guys were pretty tough. What is that shiny thing on the ground. You should go grab it."
		if [ -e .Locket ]; then
			mv .Locket Locket
		fi
	echo "To add the item to your inventory, type 'mv Locket \$inventory'"
	echo "To view the item once it is in your inventory type 'cat \$inventory/Locket'"
	echo "If you ever forget what is in your inventory, you can type 'ls \$inventory'"
	
	echo -e "${RED}A staircase appears before you as you touch the locket${NC}"
	echo -e "${BLUE}$team_name${NC}: \"Far outside the realm of our everyday lives.\" \
That could have something to do with this staircase. I say we take a trip up there."
fi
if [ -e .Sky ]; then
	mv .Sky Sky
fi
	echo "Type 'cd Sky' to take the staircase."
battle2=0

