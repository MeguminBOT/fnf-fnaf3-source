@echo off
color 0a
cd ..
echo BUILDING GAME
haxelib run lime build windows -debug -D HXCPP_M64 -D HXCPP_CLANG
echo.
echo done.
pause
pwd
explorer.exe export\debug\windows\bin