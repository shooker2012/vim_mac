cp .vimrc ~/.vimrc

rm -rf ~/.vim
mkdir ~/.vim
cp -R .vim/ ~/.vim

# setup ctags
cd ./tools/ctags-5.8/
./configure
make
sudo make install
cd ../..
