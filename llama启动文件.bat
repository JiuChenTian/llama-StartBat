@echo off
chcp 65001 >nul

cd /d 你的llama.cpp启动文件目录（例如：D:\llama-b10588-bin-win-cuda-13.3-x64）

set "INI_FILE=01-models.ini"

echo # Auto Generated Router Config > "%INI_FILE%"
echo. >> "%INI_FILE%"

set "DIR_1=模型绝对路径1"
set "DIR_2=模型绝对路径2"
set "DIR_3=模型绝对路径3"

setlocal enabledelayedexpansion

for /f "tokens=2 delims==" %%i in ('set DIR_') do (
    set "current_dir=%%~i"
    
    if exist "!current_dir!" (
        for %%f in ("!current_dir!\*.gguf") do (
            echo %%~nxf | findstr /i "mmproj" >nul
            if !errorlevel! neq 0 (
                set "m_path=%%~ff"
                set "m_name=%%~nxf"
                set "m_title=%%~nf"
                
                echo [自动上线别名] !m_title!
                
                echo [!m_title!] >> "%INI_FILE%"
                echo model = !m_path! >> "%INI_FILE%"
                
                set "found_mmproj="
                for %%m in ("!current_dir!\*mmproj*.gguf") do (
                    set "found_mmproj=%%~fm"
                )
                
                if defined found_mmproj (
                    echo   --^> [成功绑定同目录多模态组件]
                    echo mmproj = !found_mmproj! >> "%INI_FILE%"
                    echo ctx-size = 4096 >> "%INI_FILE%"
                    echo parallel = 2 >> "%INI_FILE%"
                ) else (
                    echo   --^> [成功绑定纯文本模型]
                    echo ctx-size = 8192 >> "%INI_FILE%"
                    echo parallel = 2 >> "%INI_FILE%"
                )
                
                echo n-gpu-layers = 999 >> "%INI_FILE%"
                echo. >> "%INI_FILE%"
            )
        )
    )
)

llama-server.exe --models-preset 01-models.ini --models-max 1 --host 127.0.0.1 --port 8080

endlocal
pause
