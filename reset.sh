#!/usr/bin/bash
cp .Characters/.Names .Characters/Names.txt
cp .Characters/.Cerberus .Characters/Cerberus
echo -n "" > .Data/my_stats.txt
echo -n "" > .Data/enemy_stats.txt
if [ -e Orb ]; then
	mv Orb .Orb
fi
if [ -e .Orb/Tutorial ]; then
	mv .Orb/Tutorial .Orb/.Tutorial
fi
if [ -e .Orb/Field ]; then
	mv .Orb/Field .Orb/.Field
fi
if [ -e .Inventory/Locket ]; then
	mv .Inventory/Locket .Orb/.Field/.Locket
fi
if [ -e .Orb/.Field/Locket ]; then
	mv .Orb/.Field/Locket .Orb/.Field/.Locket
fi
if [ -e .Orb/.Field/Sky ]; then
	mv .Orb/.Field/Sky .Orb/.Field/.Sky
fi
if [ -e .Orb/.Field/.Sky/Unknown ]; then
	mv .Orb/.Field/.Sky/Unknown .Orb/.Field/.Sky/.Unknown
fi
unset team_name
unset character_name
unset usr_m1
unset usr_m2
unset usr_m3
unset enem_m1
unset enem_m2
unset enem_m3
unset team_block
unset enem_block
unset charopt
unset enem1_name
unset enem2_name
unset battle1
unset battle2
unset battle3
unset opt
unset usr_atk
unset usr_dmg
unset usr_acc
unset usr_move
unset enem_atk
unset enem_dmg
unset enem_acc
unset enem_move
unset tut_done
unset inp
unset opt2
unset real_name
unset RED
unset BLUE
unset NC
unset partial
return
