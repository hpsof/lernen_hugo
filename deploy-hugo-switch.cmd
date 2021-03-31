rem -- 04.09.2020 hpsof
rem -- idee   : hugo-web deployen auf kijumed dev. vorher wird build gemacht mit korrektem url
rem --          vorher ausfuehren : hugo.cmd --baseURL=http://dev.kijumed.ch/

setlocal
set user=ssh-597176-hpsof
set pwd=lK9xWkJ8
set host=134.119.225.243
set rpfad=/www/426281_8001/web/3438463/A3438463/kijumed.ch/SUBDOM
set deployfolder=public
PATH=g:\tools\putty;%PATH%

call hugo.cmd --baseURL=http://dev.kijumed.ch/

rem -- 1 : altes deploy-verz loeschen auf server (falls existent)
plink.exe -l %user% -pw %pwd%  -ssh %host% rm -rf %rpfad%/%deployfolder%

rem -- 2 : deployfolder mit aktuellem build kopieren von lokal nach remote kopieren
pscp -p -pw %pwd% -r %deployfolder% %user%@%host%:%rpfad%/

rem -- 3 : altes dev loeschen
plink.exe -l %user% -pw %pwd%  -ssh %host% rm -rf %rpfad%/dev

rem -- 4 : deployfolder umbenennen nach dev auf remote
plink.exe -l %user% -pw %pwd%  -ssh %host% mv %rpfad%/%deployfolder% %rpfad%/dev
