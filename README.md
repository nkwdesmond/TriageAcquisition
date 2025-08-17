# Win_hostInfo_internet.bat
Run with **administrator privileges** on a host with **internet access** to collect Windows host information (system, network) into an output txt file.<br><br>
Collects the following (`commands` in parenthesis):
- SYSTEM INFORMATION (`systeminfo`) 
- NETWORK CONFIGURATION (`ipconfig /all`) 
- DNS CONFIGURATION (`ipconfig /displaydns`) 
- ROUTING CONFIGURATION (`route print`) 
- NETWORK CONNECTIONS WITH PROCESS INFO (`netstat -anob`) (requires administrator privileges)
- NETWORK CONNECTIONS (`netstat -ano`) 
- ARP TABLE (`arp -a`)
- PUBLIC IP (`nslookup myip.opendns.com resolver1.opendns.com`) 
- TRACE ROUTE (`tracert -h 15 -w 500 8.8.8.8`) 

# Win_hostInfo.bat
Run with **administrator privileges** to collect Windows host information (system, network, user, disk, task, process) into an output txt file.<br><br>
Collects the following (`commands` in parenthesis):
- SYSTEM INFORMATION (`systeminfo`) 
- NETWORK CONFIGURATION (`ipconfig /all`) 
- DNS CONFIGURATION (`ipconfig /displaydns`) 
- ROUTING CONFIGURATION (`route print`) 
- NETWORK CONNECTIONS WITH PROCESS INFO (`netstat -anob`) (requires administrator privileges)
- NETWORK CONNECTIONS (`netstat -ano`) 
- ARP TABLE (`arp -a`) 
- WORKSTATION INFORMATION (`net config workstation`) 
- LOCAL USER ACCOUNTS (`net user`) 
- INFORMATION ON EACH LOCAL USER ACCOUNT (`net user [user]`) 
- NETWORK SHARES (`net share`) 
- MAPPED NETWORK CONNECTIONS (`net use`) 
- MOUNTED VOLUME INFORMATION (`mountvol.exe`) 
- VOLUME LABEL AND SERIAL NUMBER (`wmic LogicalDisk get DeviceID`) 
- LOGICAL DISK DRIVE INFORMATION (`wmic logicaldisk get`) 
- PHYSICAL DISK DRIVE INFORMATION (`wmic diskdrive get`) 
- ENVIRONMENT VARIABLES (`set`) 
- SCHEDULED TASKS (`schtasks /query`) 
- CURRENT RUNNING PROCESSES (`tasklist`) 
- PROCESSES WITH LOADED MODULES (`tasklist /m`) 
- SERVICE INFORMATION ON EACH PROCESS (`tasklist /svc`) 
