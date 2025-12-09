@echo off
cd /d C:\Users\Mouhsine\Documents\GitHub\fastrank-html
echo Pulling latest from GitHub...
git pull origin main > pull_log.txt 2>&1
echo. >> pull_log.txt
echo Current HEAD:
git log -1 --oneline >> pull_log.txt 2>&1
echo. >> pull_log.txt
echo File count:
dir /s /b | find /c /v "" >> pull_log.txt 2>&1
echo. >> pull_log.txt
echo index.html lines:
find /c /v "" < index.html >> pull_log.txt 2>&1
echo Pull complete >> pull_log.txt
