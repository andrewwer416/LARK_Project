#!/usr/bin/bash
if [ $battle1 -eq 1 ]; then
	echo "Start the fight already!"
	return
fi
echo "$team_name: Shit! looks like we're not gonna get out of enemy territory so easily. You take the one on the left, I'll take the one on the right."
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
cat $characters | grep $character_name > $my_stats
cat $characters | grep $enemy_name > $enemy_stats

battle1=1
