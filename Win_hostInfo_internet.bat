@ECHO OFF
setlocal

:: Run with **administrator privileges** on a host with **internet access** to collect Windows host information (system, network) into an output txt file.
TITLE Host Information (internet)
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
set "FileName=%COMPUTERNAME%_internet_%year%%month%%day%-%hour%%minute%%second%.txt"

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

:: Get public ip (requires internet access)
ECHO ============================= PUBLIC IP (nslookup myip.opendns.com resolver1.opendns.com) ============================== >> "%FileName%"
ECHO GETTING PUBLIC IP (nslookup myip.opendns.com resolver1.opendns.com)...
ECHO Local Time: %date% %time% >> "%FileName%"
nslookup myip.opendns.com resolver1.opendns.com >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

:: Get trace route (requires internet access)
ECHO ====================================== TRACE ROUTE (tracert -h 15 -w 500 8.8.8.8) ====================================== >> "%FileName%"
ECHO GETTING TRACE ROUTE (tracert -h 15 -w 500 8.8.8.8)...
ECHO Local Time: %date% %time% >> "%FileName%"
tracert -h 15 -w 500 8.8.8.8 >> "%FileName%"
ECHO: >> "%FileName%"
ECHO: >> "%FileName%"

endlocal
@pause