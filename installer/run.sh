GEM_VERSION=2.0.3
GEM_DIR=$(gem environment gemdir)

rm -rf ~/.keppler
# Directories
mkdir ~/.keppler
mkdir ~/.keppler/scripts
mkdir ~/.keppler/lib
mkdir ~/.keppler/db_conf
########################
cd $GEM_DIR/gems/keppler-$GEM_VERSION/installer
cp scripts/bin.sh ~/.keppler/scripts
cp lib/conf.rb ~/.keppler/lib
cp lib/scaffold.rb ~/.keppler/lib
cp db_conf/conf.yml ~/.keppler/db_conf
scp -r core ~/.keppler
scp -r plugins ~/.keppler
echo "\nsource ~/.keppler/scripts/bin.sh" >> ~/.bashrc