@ECHO OFF
setlocal

:: Run with **administrator privileges** to collect Windows host information (system, network, user, disk, task, process) into an output txt file.
TITLE Host Information
ECHO Please wait... Gathering host information.

:: Get the current date and time in a consistent format using WMIC
for /F "tokens=2 delims==." %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I

:: Extract date and time components
set "year=%datetime:~0,4%"
set "month=%datetime:~4,2%"
set "day=%datetime:~6,2%"
set "hour=%datetime:~8,2%"
set "minute=%datetime:~10,2%"
set "second=%datetime:~12,2%"

:: Construct the filename
set "FileName=%COMPUTERNAME%_%year%%month%%day%-%hour%%minute%%second%.txt"

:: Set Date / Time of Collection (using WMIC values)
for /f "tokens=*" %%i in ('tzutil /g') do (
    ECHO Collection started: %year%-%month%-%day% %hour%:%minute%:%second% %%i (YYYY-MM-DD 24H^) >> "%FileName%"
)
ECHO: >> "%FileName%"

:: Get system information
ECHO =========================================== SYSTEM INFORMATION (systeminfo) ============================================ >> "%FileName%"
ECHO GETTING SYSTEM INFORMATION (systeminfo)...
ECHO Local Time: %date% %time% >> "%FileName%"
systeminfo >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get network configuration
ECHO ======================================== NETWORK CONFIGURATION (ipconfig /all) ========================================= >> "%FileName%"
ECHO GETTING NETWORK CONFIGURATION (ipconfig /all)...
ECHO Local Time: %date% %time% >> "%FileName%"
ipconfig /all >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get DNS configuration
ECHO ======================================= DNS CONFIGURATION (ipconfig /displaydns) ======================================= >> "%FileName%"
ECHO GETTING DNS CONFIGURATION (ipconfig /displaydns)...
ECHO Local Time: %date% %time% >> "%FileName%"
ipconfig /displaydns >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get routing configuration
ECHO ========================================= ROUTING CONFIGURATION (route print) ========================================== >> "%FileName%"
ECHO GETTING ROUTING CONFIGURATION (route print)...
ECHO Local Time: %date% %time% >> "%FileName%"
route print >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get current network connections with process info
ECHO ================================ NETWORK CONNECTIONS WITH PROCESS INFO (netstat -anob) ================================= >> "%FileName%"
ECHO GETTING CURRENT NETWORK CONNECTIONS WITH PROCESS INFO (netstat -anob)...
ECHO Local Time: %date% %time% >> "%FileName%"
netstat -anob >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get current network connections
ECHO ========================================== NETWORK CONNECTIONS (netstat -ano) ========================================== >> "%FileName%"
ECHO GETTING CURRENT NETWORK CONNECTIONS (netstat -ano)...
ECHO Local Time: %date% %time% >> "%FileName%"
netstat -ano >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get ARP table
ECHO ================================================== ARP TABLE (arp -a) ================================================== >> "%FileName%"
ECHO GETTING ARP TABLE (arp -a)...
ECHO Local Time: %date% %time% >> "%FileName%"
arp -a >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get workstation information
ECHO =================================== WORKSTATION INFORMATION (net config workstation) =================================== >> "%FileName%"
ECHO GETTING WORKSTATION INFORMATION (net config workstation)...
ECHO Local Time: %date% %time% >> "%FileName%"
net config workstation >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get a list of local user accounts
ECHO ============================================ LOCAL USER ACCOUNTS (net user) ============================================ >> "%FileName%"
ECHO GETTING LOCAL USER ACCOUNTS (net user)...
ECHO Local Time: %date% %time% >> "%FileName%"
net user >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get information about each local user account
ECHO =============================== INFORMATION ON EACH LOCAL USER ACCOUNT (net user [user]) =============================== >> "%FileName%"
ECHO GETTING INFORMATION ON EACH LOCAL USER ACCOUNT (net user [user])...
ECHO Local Time: %date% %time% >> "%FileName%"
ECHO: >> "%FileName%"
:: net user %username% >> "%FileName%"
for /f "skip=1 tokens=*" %%A in ('wmic useraccount where "LocalAccount=TRUE" get Name') do (
    for /f "delims=" %%B in ("%%A") do (
        net user %%B >> "%FileName%"
        ECHO: >> "%FileName%"
    )
)
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get network shares
ECHO ============================================== NETWORK SHARES (net share) ============================================== >> "%FileName%"
ECHO GETTING NETWORK SHARES (net share)...
ECHO Local Time: %date% %time% >> "%FileName%"
net share >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get a list of all mapped network connections.
ECHO ========================================= MAPPED NETWORK CONNECTIONS (net use) ========================================= >> "%FileName%"
ECHO GETTING MAPPED NETWORK CONNECTIONS (net use)...
ECHO Local Time: %date% %time% >> "%FileName%"
net use >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get mounted volume information
ECHO ====================================== MOUNTED VOLUME INFORMATION (mountvol.exe) ======================================= >> "%FileName%"
ECHO GETTING MOUNTED VOLUME INFORMATION (mountvol.exe)...
ECHO Local Time: %date% %time% >> "%FileName%"
mountvol.exe >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get volume label and serial number information
ECHO ============================ VOLUME LABEL AND SERIAL NUMBER (wmic LogicalDisk get DeviceID) ============================ >> "%FileName%"
ECHO GETTING VOLUME LABEL AND SERIAL NUMBER (wmic LogicalDisk get DeviceID)...
ECHO Local Time: %date% %time% >> "%FileName%"
for /F "skip=1" %%C in ('"wmic LogicalDisk get DeviceID"') do (
    for /F %%D in ("%%C") do (
        echo. >> "%FileName%"
        vol %%D >> "%FileName%"
    )
)
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get logical disk drive information
ECHO ================================ LOGICAL DISK DRIVE INFORMATION (wmic logicaldisk get) ================================= >> "%FileName%"
ECHO GETTING LOGICAL DISK DRIVE INFORMATION (wmic logicaldisk get)...
ECHO Notable fields: DeviceID, FileSystem, FreeSpace, Size, VolumeName, VolumeSerialNumber, Description, DriveType >> "%FileName%"
ECHO Local Time: %date% %time% >> "%FileName%"
wmic logicaldisk get /format:list | find /v "" >> "%FileName%"
:: for /f "delims=" %%A in ('"wmic logicaldisk get /format:list"') do for /f "delims=" %%B in ("%%A") do echo %%B >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get physical disk drive information
ECHO ================================= PHYSICAL DISK DRIVE INFORMATION (wmic diskdrive get) ================================= >> "%FileName%"
ECHO GETTING PHYSICAL DISK DRIVE INFORMATION (wmic diskdrive get)...
ECHO Notable fields: Model, Name, InterfaceType, SerialNumber, Description, DeviceID, Manufacturer, PNPDeviceID, MediaType, Size >> "%FileName%"
ECHO Local Time: %date% %time% >> "%FileName%"
wmic diskdrive get /format:list | find /v "" >> "%FileName%"
:: for /f "delims=" %%A in ('"wmic diskdrive get /format:list"') do for /f "delims=" %%B in ("%%A") do echo %%B >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get environment variables
ECHO ============================================= ENVIRONMENT VARIABLES (set) ============================================== >> "%FileName%"
ECHO GETTING ENVIRONMENT VARIABLES (set)...
ECHO Local Time: %date% %time% >> "%FileName%"
set >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get scheduled tasks
ECHO ========================================== SCHEDULED TASKS (schtasks /query) =========================================== >> "%FileName%"
ECHO GETTING SCHEDULED TASKS (schtasks /query)...
ECHO Local Time: %date% %time% >> "%FileName%"
schtasks /query >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get current running processes
ECHO ========================================= CURRENT RUNNING PROCESSES (tasklist) ========================================= >> "%FileName%"
ECHO GETTING CURRENT RUNNING PROCESSES (tasklist)...
ECHO Local Time: %date% %time% >> "%FileName%"
tasklist >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get processes with loaded modules
ECHO ===================================== PROCESSES WITH LOADED MODULES (tasklist /m) ====================================== >> "%FileName%"
ECHO GETTING PROCESSES WITH LOADED MODULES (tasklist /m)...
ECHO Local Time: %date% %time% >> "%FileName%"
tasklist /m >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get service information on each process
ECHO ================================= SERVICE INFORMATION ON EACH PROCESS (tasklist /svc) ================================== >> "%FileName%"
ECHO GETTING SERVICE INFORMATION ON EACH PROCESS (tasklist /svc)...
ECHO Local Time: %date% %time% >> "%FileName%"
tasklist /svc >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

endlocal
@pause