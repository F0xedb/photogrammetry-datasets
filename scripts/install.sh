#!bin/bash

mkdir photogammatry
cd photogammatry

git clone https://github.com/simonfuhrmann/mve.git
git clone https://github.com/flanggut/smvs.git

echo "installing packages"

sudo apt-get install libjpeg-dev libpng-dev libtiff-dev

echo "building library's"

#mve should give a error about opengl this is fine
make -C mve 
make -C smvs
