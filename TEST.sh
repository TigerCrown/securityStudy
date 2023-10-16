#!/bin/sh
if [ `id -u` -ne 0 ]; then
    echo "Please run as root"
    exit
fi

PASSWD="/etc/passwd"
SHADOW="/etc/shadow"
SSH_CONF="/etc/ssh/sshd_config"
SECURETTY="/etc/securetty"

echo "============"         > Result.txt
echo "META_DATA(passwd)"   >> Result.txt
echo "============"        >> Result.txt
cat $PASSWD                >> Result.txt
echo ""                    >> Result.txt
echo ""                    >> Result.txt
echo "============"        >> Result.txt
echo "META_DATA(shadow)"   >> Result.txt
echo "============"        >> Result.txt
cat $SHADOW                >> Result.txt
echo ""                    >> Result.txt
echo ""                    >> Result.txt
echo "============"        >> Result.txt
echo "META_DATA(ssh_conf)" >> Result.txt
echo "============"        >> Result.txt
cat $SSH_CONF              >> Result.txt
echo ""                    >> Result.txt
echo ""                    >> Result.txt
echo "============"        >> Result.txt
echo "META_DATA(securetty)">> Result.txt
echo "============"        >> Result.txt
cat $SECURETTY             >> Result.txt
echo ""                    >> Result.txt
echo ""                    >> Result.txt
echo "============"        >> Result.txt
echo "META_DATA(process)"  >> Result.txt
echo "============"        >> Result.txt
ps -ef
echo ""                    >> Result.txt
echo ""                    >> Result.txt
echo "============"        >> Result.txt
echo "META_DATA(netstat)"  >> Result.txt
echo "============"        >> Result.txt
netstat -nltp
echo ""                    >> Result.txt
echo ""                    >> Result.txt
#########
#########
if [ ! -f $PASSWD ]
then
    echo "$PASSWD is not exist"
else
    echo "$PASSWD is exist"
fi
#########
#########
echo -e "Input Value: \c"
read val
if [ $val -eq '1' ]
then
    echo "Value is 1"
elif [ $val -eq '2' ]
then
    echo "Value is 2"
else
    echo "ELSE"
fi
#########
#########
for str in test1 test2 test3 test4
do
    echo $str
done
#########
#########
echo "<CentOS Script Start>"
COMMAND_IP=`ifconfig`
echo "$COMMAND_IP"
#########
echo "<CentOS Script Start>"
SSH_PROC=`netstat -nltp | grep ":22[ \t]"`
if [ "$SSH_PROC" != "" ]
then
    echo "SSH Enable"
else
    echo "SSH Disable"
fi
######### SSH
echo "<CentOS Script Start>"
echo ""
echo "[ U-01 ]"
ssh_port=`netstat -nltp | grep ":22[ \t]" | grep "LISTEN"`
telnet_port=`netstat -nltp | grep ":23[ \t]" | grep "LISTEN"`
if [ "$ssh_port" != "" ]
then
    chkssh=`cat $SSH_CONF | egrep -v "^#|^$" | grep "PermitRootLogin" | awk '{print $2}'`
    if [ ! -f $SSH_CONF ]
    then
        echo "sshd_config File is not Exist"
    elif [ "$chkssh" == "no" ]
    then
        ssh_flag=1
    else
        echo "PermitRootLogin $chkssh"
        ssh_flag=0
    fi
else
    ssh_flag=1
fi
#########
######### TELNET
if [ "$telnet_port" != "" ]
then
    chkpts=`cat $SECURETTY | egrep "^pts"`
    chkpam=`cat /etc/pam.d/remote | egrep -v "^#|^$" | grep "pam_securetty.so"`
    if [ "$chkpts" == "" ] && [ "$chkpam" != "" ]
        then
            telnet_flag=1
    else
        telnet_flag=0
    fi
else
    telnet_flag=1
fi
#########
if [ "$ssh_flag" -eq 1 ] && [ "$telnet_flag" -eq 1 ]
then
    echo "U-01: 양호"
else
    echo "U-01: 취약"
fi
echo ""
echo ""
#########
#########
echo "[ U-07 ]"
if [ -f $passwd ]; then
    ls -l $PASSWD
    owner=`stat -c '%U' $PASSWD`
    usr_perm=`stat -c '%a' $PASSWD | awk '{print substr($0,1,1)}'`
    grp_perm=`stat -c '%a' $PASSWD | awk '{print substr($0,2,1)}'`
    oth_perm=`stat -c '%a' $PASSWD | awk '{print substr($0,3,1)}'`
    if [ "$owner" == "root" ] && [ $usr_perm -le 6 ] && [ $grp_perm -le 4 ] && [ $oth_perm -le 4 ]
    then
        echo "U-07: 양호"
    else
        echo "U-07: 취약"
    fi
else
    echo "$PASSWD is not exist"
fi
echo ""
echo ""