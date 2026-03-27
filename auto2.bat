@echo off
setlocal EnableDelayedExpansion

REM ====================== 路径配置 ======================
set FESAFE_CL=C:\CAE\win_b64\code\bin\fe-safe_cl.exe
set ODB_DIR=C:\Users\86183\Desktop\spectrum\data\suball\inp
set MACRO_DIR=C:\Users\86183\Desktop\spectrum\singleall2\macro
set PROJECT_DIR=C:\Users\86183\Desktop\spectrum\singleall2
REM =====================================================

echo ======================================
echo   fe-safe batch start
echo ======================================

REM ====== Job 循环 ======
for /L %%J in (1,1,50) do (

    echo.
    echo -------- Processing Job-%%J --------

    set ODB_FILE=%ODB_DIR%\Job_run%%J.odb
    set TEMP_MACRO=%MACRO_DIR%\temp_macro_%%J.macro
    set FER_FILE=%PROJECT_DIR%\jobs\job_0%%J\fe-results\Job_run%%J.fer

    REM ====== 仅当 ODB 存在才继续 ======
    if exist "!ODB_FILE!" (

        REM --- 生成 fe-safe 宏 ---
        (
            echo SwitchToProject %PROJECT_DIR%
            echo pre-scan files "!ODB_FILE!"
            echo pre-scan position elemental
            echo pre-scan deselect all
            echo pre-scan select groups
            echo pre-scan select detect-surface
            echo pre-scan select source "!ODB_FILE!" inc all stress
            echo pre-scan open selected
            echo groups list deselect all
            echo fe-safe b=run
            echo fe-safe o="!FER_FILE!"
        ) > "!TEMP_MACRO!"

        REM --- 执行 fe-safe ---
        "%FESAFE_CL%" macro="!TEMP_MACRO!"

        REM --- 清理临时宏 ---
        del "!TEMP_MACRO!"

    ) else (
        echo [WARN] !ODB_FILE! not found, skip
    )
)

echo.
echo ======================================
echo All finished!
echo ======================================
pause
