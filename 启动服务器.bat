@echo off
chcp 65001 >nul
title 速取快递 - 本地服务器

echo.
echo ================================================
echo          速取快递 · 本地服务器启动中...
echo ================================================
echo.

cd /d "%~dp0"

:: 检查端口是否被占用
netstat -ano | findstr ":8080" >nul
if %errorlevel% equ 0 (
    echo [警告] 端口 8080 已被占用，尝试使用端口 8088...
    set PORT=8088
) else (
    set PORT=8080
)

echo.
echo [用户端] http://localhost:!PORT!/user.html
echo [管理端] http://localhost:!PORT!/index.html
echo.

:: 获取本机IP
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    set IP=%%a
    set IP=!IP: =!
    echo [手机访问] http://!IP!:!PORT!/user.html
    echo [手机访问] http://!IP!:!PORT!/index.html
)

echo.
echo ================================================
echo  服务器运行中... 按 Ctrl+C 停止
echo ================================================
echo.

python -m http.server !PORT!
pause
