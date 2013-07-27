#
# CyanogenMod automatic compiler
# by KINGbabasula
#
upp=1
clear
echo
echo Welcome to the KINGbabasula automatic CyanogenMod compiler
echo
echo -e "Please enter the codename of the device: \c "
read codename
echo
echo -e "Please enter the delay for every build in seconds: \c "
read delay
echo
echo -e "Please enter the number of jobs to compile and sync: \c "
read job
echo
echo -e "Please enter how many builds the script has to do: \c"
read TIMES
echo
echo -e "Do you want to upload the builds automatically to a ftp server?[1=yes|2=no] \c"
read up
if [ "$up" == "$upp" ]
then
    echo -e "Enter your ftp host: \c"
    read host
    echo -e "Enter your password: \c"
    read pass
    echo -e "Enter your username: \c"
    read user
    for a in $TIMES
    do
       . build/envsetup.sh
       echo Lunching CyanogenMod for your device..
       lunch cm_$codename-userdebug
       echo Making clean...
       make clean
       echo Compiling...
       make -j$job bacon
       date=`date +%Y%m%d`
       cd out/target/product/$codename
       ftp -inv $HOST
       user $USER $PASS
       cd public_html/i9105P/cm-10.1
       put cm-10.1-$date-UNOFFICIAL-$codename.zip
       bye
       sleep $delay
       repo sync -j$job
    done
else
for a in $TIMES
do
   . build/envsetup.sh
   echo Lunching CyanogenMod for your device...
   lunch cm_$codename-userdebug
   echo Making clean...
   make clean
   echo Compiling...
   make -j$job bacon
   sleep $delay
   repo sync -j$job
done
fi