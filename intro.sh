#!/usr/bin/bash
# EDIT WORDS!!!!!!
# Intro Phase: select an orb

echo "You awake. 3 Orbs green red blue."
read -p "Please make a choice" opt
case $opt in
  Green|green)
    echo "You earth"
  ;;
  Blue|blue)
    echo "You heaven"
  ;;
  Red|red)
    echo "You hell"
  ;;
esac
exit
