#!/usr/bin/bash
if [ $battle2 -eq 1 ]; then
	echo "Start the fight already!"
	return
fi
echo -e "${BLUE}$team_name${NC}: Woah! We're going through the clouds. \n${RED}A couple minutes pass${NC}\n\
${BLUE}$team_name${NC}: Look! Theres some kind of island! In the sky! No freakin way! \n${RED}As you get closer you see a gate and a couple figures that seem to be pointing their weapons at you${NC}\n\
${BLUE}$team_name${NC}: Oh boy... hope you're ready for some more trouble"
enem1_name=`sed -n '1p' $head/.Characters/Names.txt`
enem2_name=`sed -n '2p' $head/.Characters/Names.txt`
sed -i "/$enem1_name/d" $head/.Characters/Names.txt
sed -i "/$enem2_name/d" $head/.Characters/Names.txt
charopt=$(( $RANDOM % 2))
if [ $charopt -eq 0 ]; then
	enemy_name="$enem1_name"
else
	enemy_name="$enem2_name"
fi
cat $characters | grep $character_name > $my_stats
cat $characters | grep $enemy_name > $enemy_stats
echo -e "${BLUE}$enemy_name${NC}: HALT! Mortals shall not approach this gate and leave alive!"
echo "Type 'source battle.sh' to begin combat."
battle2=1
