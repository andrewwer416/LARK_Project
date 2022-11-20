#!/usr/bin/bash
if [ $battle1 -eq 1 ]; then
	echo "Start the fight already!"
	return
fi
echo -e "${BLUE}$team_name${NC}: Shit! Get down! Enemies ahead. You take the one on the left and I'll take the one on the right."
echo -e "${RED}As you approach, a twig snaps beneath you${NC}"
echo -e "${BLUE}$team_name${NC}: So much for a surprise attack..."
charopt=$(( $RANDOM % 2))
if [ $charopt -eq 0 ]; then
	enem1_name=`sed -n '3p' $head/.Characters/Names.txt`
	enem2_name=`sed -n '4p' $head/.Characters/Names.txt`
else
	enem1_name=`sed -n '1p' $head/.Characters/Names.txt`
	enem2_name=`sed -n '2p' $head/.Characters/Names.txt`
fi
sed -i "/$enem1_name/d" $head/.Characters/Names.txt
sed -i "/$enem2_name/d" $head/.Characters/Names.txt
charopt=$(( $RANDOM % 2))
if [ $charopt -eq 0 ]; then
	enemy_name="$enem1_name"
else
	enemy_name="$enem2_name"
fi
echo -e "${BLUE}$enemy_name${NC}: You $clan_name bastards won't make it out of here alive!"
cat $characters | grep $character_name > $my_stats
cat $characters | grep $enemy_name > $enemy_stats
echo "Type 'source battle.sh' to begin combat."
battle1=1
