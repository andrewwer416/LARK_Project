#!/usr/bin/bash
if [ $battle3 -eq 0 ]; then
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
	if [ $team_block -eq 1 -a $enem_block -eq 1 ]; then
		echo "You both tried to block!"
	else
		if [ $team_block -eq 0 ]; then
			usr_atk=($(grep $usr_move $moves))
			usr_dmg="${usr_atk[1]}"
			usr_acc="${usr_atk[2]}"
			if [ $(( $RANDOM % 100)) -lt $usr_acc ]; then
				if [ $enem_block -eq 1 ]; then
				partial=$(($usr_dmg / 5))
				((enem_hp -= $partial))
				echo -e "${BLUE}$enemy_name${NC} blocked your attack! and took $partial damage"
				else
				((enem_hp -= $usr_dmg))
				echo -e "You dealt ${RED}$usr_dmg${NC} damage with $usr_move!"
				fi
			else
				echo -e "${BLUE}$enemy_name${NC} has dodged your attack!"
			fi
		fi
		if [ -e $inventory/Locket -a $enem_hp -le 0 ]; then
			break
		fi
		if [ $enem_block -eq 0 ]; then
			enem_atk=($(grep $enem_move $moves))
			enem_dmg="${enem_atk[1]}"
			enem_acc="${enem_atk[2]}"
			if [ $(( $RANDOM % 100)) -lt $enem_acc ]; then
				if [ $team_block -eq 1 ]; then
				partial=$(($enem_dmg / 5))
				((usr_hp -= $partial))
				echo -e "You blocked ${BLUE}$enemy_name's${NC} attack and took $partial damage!"
				else
				((usr_hp -= $enem_dmg))
				echo -e "${BLUE}$enemy_name${NC} dealt $enem_dmg damage with $enem_move!"
				fi
			else
				echo -e "You dodged ${BLUE}$enemy_name's${NC} attack!"
			fi
		fi
	fi
done
if [ $usr_hp -le 0 ]; then
echo -e "${RED}You were defeated. As expected when faced with a god in the flesh. Don't worry this isn't the end. \
Though you've shown that you aren't physically capable of beating $enemy_name, there is a way to force him \
out of the universe. Type 'rm \$Cerberus' to get rid of him for good. Once you're done, type 'source outro.sh' \
to decide the fate of the Caduceus.${NC}"
else
	rm $Cerberus
	echo -e "Congratulations! You somehow won an impossible battle. You will now replace Cerberus as \
head of the universe. Type 'source outro.sh' to decide what to do with the Caduceus."
fi


