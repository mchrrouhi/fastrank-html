@echo off
cd /d C:\Users\Mouhsine\Documents\GitHub\fastrank-html
echo Force reset to commit 2f7b906 (full 1357-line homepage)...
git reset --hard 2f7b906 > hard_restore.txt 2>&1
echo. >> hard_restore.txt
echo Verifying index.html...
find /c /v "" < index.html >> hard_restore.txt 2>&1
echo. >> hard_restore.txt
echo Adding and committing...
git add -A >> hard_restore.txt 2>&1
git commit -m "Permanently restore full homepage (1357 lines) from commit 2f7b906" >> hard_restore.txt 2>&1
echo. >> hard_restore.txt
echo Force pushing to GitHub...
git push -f origin main >> hard_restore.txt 2>&1
echo Restore complete >> hard_restore.txt
