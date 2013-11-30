#!/bin/sh

echo "Enter alias name: "
read name
echo "alias $name='cd `pwd`'" >> ~/.aliases
source ~/.aliases
