rm -rf ~/.keppler
# Directories
mkdir ~/.keppler
mkdir ~/.keppler/scripts
mkdir ~/.keppler/lib
mkdir ~/.keppler/db_conf
########################
cd installer
cp scripts/bin.sh ~/.keppler/scripts
cp lib/conf.rb ~/.keppler/lib
cp lib/scaffold.rb ~/.keppler/lib
cp db_conf/conf.yml ~/.keppler/db_conf
echo "\nsource ~/.keppler/scripts/bin.sh" >> ~/.bashrc
########################
cd ~/.keppler/
wget https://github.com/SliceDevelopers/keppler_admin/archive/keppler-v2.zip
unzip keppler-v2.zip 
rm -rf keppler-v2.zip 
mv keppler_admin-keppler-v2 core