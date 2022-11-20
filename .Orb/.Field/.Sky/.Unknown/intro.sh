#!/usr/bin/bash
enemy_name="???"
echo "$enemy_name: I was wondering when you would find your way back here... Oh right, I never did get your
REAL name."
read -p "Could you please tell me?" real_name
enemy_name="Cerberus"
echo "$enemy_name: Thank you. I will formally introduce myself as $enemy_name. \
You know $real_name, I was quite lonely here all by myself. You don't remember our last encounter? \
After cutting down all of my soldiers back there, I was hoping you would at least regain some trace of your memory."
echo "$enemy_name: Enough of all that though. After all, that is not why you're here today. \
I know you and all the other greedy mortals are after my Caduceus. \
Not many have challenged me for it, but the few who have were legends of their own right. \
Let's see if you possess greater power than those who have come before you."
cat $Cerberus > $enemy_stats
battle3=1
