#!/usr/bin/bash
# EDIT WORDS!!!!!!
# Intro Phase: select an orb

echo "You awake. 3 Orbs green red blue."
read -p "Please make a choice" opt
case $opt in
  Green|green)
    echo "You earth"
    mv .Green Green
    echo "Use cd Green to go into the Realm of earth"
  ;;
  Blue|blue)
    echo "You heaven"
    mv .Blue Blue
    echo "Use cd Blue to go into the Realm of heaven"
  ;;
  Red|red)
    echo "You hell"
    mv .Red Red
    echo "Use cd Red to go into the Realm of hell"
  ;;
esac
exit
