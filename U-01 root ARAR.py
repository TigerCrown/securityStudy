1. netstat -nltp
2. netstat -nltp | grep ":22" 22번 포트가 열려있는지 확인
3. Service sshd stop
4. netstat -nltp | egrep ":23|:22"

#ssh telnet 사용중
양호 telnet : cat /etc/securetty, /etc/securetty | grep "pts"
             cat /etc/pam.d/login
             cat /pam.d/remote << pam_securetty.so 있는지 확인

취약 ssh : cat /etc/ssh/sshd_config, /etc/ssh/sshd_config | grep "Permit"
          no로 되어 있어야 양호, yes는 취약, PermitRootLogin이 yes로 되어 있는지 확인!!

단!! 프로세스, 포토, 서비스 등과 관련이 있는 항목들은 반드시 현재 실행상태(프로세스, 포토, 서비스를 통해)
여부를 먼저 판단한 후 설정 확인!!