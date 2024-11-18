@echo off
setlocal

:: Obtém o nome do usuário atual do Windows
set "user=%username%"
set "anydesk_path=C:\Users\%user%\AppData\Roaming\AnyDesk"

:: Verifica se o processo AnyDesk está em execução e tenta finalizá-lo
echo Verificando se o processo AnyDesk está em execução...
tasklist /FI "IMAGENAME eq AnyDesk.exe" | find /I "AnyDesk.exe" >nul
if %errorlevel% equ 0 (
    echo AnyDesk está em execução. Tentando finalizar o processo...
    taskkill /F /IM AnyDesk.exe >nul
    echo Processo AnyDesk finalizado.
) else (
    echo AnyDesk não está em execução.
)

:: Verifica se a pasta AnyDesk existe
if exist "%anydesk_path%" (
    echo A pasta AnyDesk foi encontrada em %anydesk_path%.
    echo Apagando arquivos...

    :: Apaga todos os arquivos da pasta
    del /Q "%anydesk_path%\*"
    
    :: Verifica novamente se ainda há arquivos na pasta
    if exist "%anydesk_path%\*" (
        echo Alguns arquivos não puderam ser apagados.
    ) else (
        echo Todos os arquivos foram apagados com sucesso.
    )
) else (
    echo A pasta AnyDesk não foi encontrada. Parece que o aplicativo não está instalado.
)

endlocal
pause
