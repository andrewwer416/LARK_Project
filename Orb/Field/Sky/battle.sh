if [ $battle2 -eq 0 ]; then
	echo "Please type 'source intro.sh' before coming into this battle."
	return
fi
sed -i 's/\r$//' $my_stats
sed -i 's/\r$//' $enemy_stats
read -r _ usr_hp usr_m1 usr_m2 usr_m3 < $my_stats
read -r _ enem_hp enem_m1 enem_m2 enem_m3 < $enemy_stats
team_block=0
enem_block=0
while [ $usr_hp -gt 0 -a $enem_hp -gt 0 ]
do
	echo
	echo -e "Your health: $usr_hp\nEnemy health: $enem_hp"
	echo
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
			team_block=1
			break
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
		echo "$enemy_name blocked your attack!"
		enem_block=0
	elif [ $team_block -eq 1 -a $enem_block -eq 0 ]; then
		echo "You blocked $enemy_name's attack!"
		team_block=0
	elif [ $team_block -eq 1 -a $enem_block -eq 1 ]; then
		echo "You both tried to block!"
	else
		usr_atk=($(grep $usr_move $moves))
		usr_dmg="${usr_atk[1]}"
		usr_acc="${usr_atk[2]}"
		if [ $(( $RANDOM % 100)) -lt $usr_acc ]; then
			((enem_hp -= $usr_dmg))
			echo "You dealt $usr_dmg damage with $usr_move!"
			if [ -e $inventory/Locket ]; then
				if [ $enem_hp -le 0 ]; then
					break
				fi
			fi
		else
			echo "$enemy_name has dodged your attack!"
		fi
		enem_atk=($(grep $enem_move $moves))
		enem_dmg="${enem_atk[1]}"
		enem_acc="${enem_atk[2]}"
		if [ $(( $RANDOM % 100)) -lt $enem_acc ]; then
			((usr_hp -= $enem_dmg))
			echo "$enemy_name dealt $enem_dmg damage with $enem_move!"
		else
			echo "You dodged $enemy_name's attack!"
		fi
	fi
done
if [ $usr_hp -le 0 ]; then
echo "You were defeated. Type 'source battle.sh' to give it another shot."
else
	echo -e "*A shiny object dangles out of $enemy_name's pocket*\n$team_name: Some guards these are. Giving up the precious key so easily. \
Let's take a look inside the island shall we?"
	if [ -e .Unknown ]; then
		mv .Unknown Unknown
	fi
	
	echo "*As you wander the clouds, you approach what seems to be an extremely worn down temple.*"
	while true; do
	read -p "$team_name: That place seems quite ominous, should we go inside? [Y/n]" opt
	case $opt in
		Y|y)
			echo "*You and $team_name enter the temple. In front of you lies an orb that is pitch black*"
			echo "$team_name: What is that thing? Do you think the scientists back at base could do \
something with this? Whatever the case, we definitely need to take this back with us."
			echo "*As $team_name goes to grab the orb he is thrown back. You hear a voice whispering, \
but can't make out what it is saying*"
			read -p "Would you like to touch the orb? [Y/n]" opt2
			case $opt2 in
				Y|y)
					echo "Type 'cd Unknown' to grab the orb"
					return
				;;
				N|n)
					echo "*The voices get stronger and your vision begins to fade.*"
					echo "$team_name: $character_name! IT WAS A TRICK!"
					cd Unknown
					return
				;;
				*)
					echo "Please enter a valid selection."
			esac
			;;
		N|n)
			echo "*You begin to hear a loud shrieking and your vision fades.*"
			echo "$team_name: $character_name! Shit! Not again!"
			cd Unknown
			return
		;;
		*)
			echo "Please enter a valid selection."
		;;
	esac
	done
fi


