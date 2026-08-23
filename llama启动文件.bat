@echo off
chcp 65001 >nul

cd /d 你的llama.cpp启动文件目录（例如：D:\llama-b10588-bin-win-cuda-13.3-x64）

set "INI_FILE=01-models.ini"
echo # Auto Generated Router Config > "%INI_FILE%"
echo. >> "%INI_FILE%"

set "DIR_1=模型绝对路径1"
set "DIR_2=模型绝对路径2"
set "DIR_3=模型绝对路径3"

for /f "tokens=2 delims==" %%i in ('set DIR_') do (
    set "current_dir=%%~i"
    if exist "!current_dir!" (
        for %%f in ("!current_dir!\*.gguf") do (
            echo %%~nxf | findstr /i "mmproj" >nul
            if !errorlevel! neq 0 (
                set "m_path=%%~ff"
                set "m_title=%%~nf"
                
                echo [网关上线] !m_title!
                echo [!m_title!] >> "%INI_FILE%"
                echo model = !m_path! >> "%INI_FILE%"
                
                set "found_mmproj="
                for %%m in ("!current_dir!\*mmproj*.gguf") do (set "found_mmproj=%%~fm")
                if defined found_mmproj (
                    echo   --^> [绑定视觉组件] !found_mmproj!
                    echo mmproj = !found_mmproj! >> "%INI_FILE%"
                )
                
                echo n-gpu-layers = 999 >> "%INI_FILE%"
                echo. >> "%INI_FILE%"
            )
        )
    )
)

echo ----------------------------------------------------------
echo 路由预设构建完毕
echo 正在唤醒本地大模型智能路由网关
echo ----------------------------------------------------------
echo.

llama-server.exe --models-preset 01-models.ini --models-max 1 --host 127.0.0.1 --port 8080 -c 131072 --parallel 1 --ui-mcp-proxy

endlocal
pause
