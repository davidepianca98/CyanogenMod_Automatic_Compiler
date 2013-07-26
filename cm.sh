#
# CyanogenMod automatic compiler
# by KINGbabasula
#
clear
TIMES=1000
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