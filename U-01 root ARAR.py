1. netstat -nltp
2. netstat -nltp | grep ":22" 22번 포트가 열려있는지 확인
3. Service sshd stop
4. netstat -nltp | egrep ":23|:22"