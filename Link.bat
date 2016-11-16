%~d0
cd %~dp0AddOns

for /d %%i in (*) do (
    rd "..\..\%%i"
    mklink /d "..\..\%%i" "%cd%\%%i"
)
