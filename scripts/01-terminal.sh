#!/usr/bin/env bash
# [평가 #1, #14] 터미널 기본 조작 + 절대/상대 경로 실습
# 현재 위치 확인, 목록(숨김 포함), 이동, 생성, 복사, 이동/이름변경, 삭제, 내용 확인, 빈 파일 생성
source "$(dirname "$0")/lib.sh"
start_log 01-terminal

WORK="$HOME/codyssey-practice"

echo "### 0. 실습 폴더 초기화 (매번 같은 결과가 나오도록)"
run "rm -rf \"$WORK\""

echo
echo "### 1. 현재 위치 확인 / 목록 확인(숨김 파일 포함)"
run "pwd"
run "ls -la"

echo
echo "### 2. 디렉토리 생성 + 이동"
run "mkdir -p \"$WORK/dir-a\" \"$WORK/dir-b\""
run "cd \"$WORK\""
run "pwd"

echo
echo "### 3. 빈 파일 생성 / 내용이 있는 파일 생성 / 내용 확인"
run "touch empty.txt"
run "echo 'hello codyssey' > hello.txt"
run "cat hello.txt"
run "ls -la"

echo
echo "### 4. 복사 / 이동 / 이름 변경"
run "cp hello.txt dir-a/hello-copy.txt"
run "mv hello.txt renamed.txt"
run "mv renamed.txt dir-b/"
run "ls -R"

echo
echo "### 5. 절대 경로 vs 상대 경로 (같은 파일을 두 방식으로 읽기)"
run "cat \"$WORK/dir-b/renamed.txt\""
run "cd dir-b && pwd"
run "cat ./renamed.txt"
run "cat ../dir-a/hello-copy.txt"
run "cd \"$WORK\""

echo
echo "### 6. 삭제"
run "rm dir-a/hello-copy.txt"
run "rmdir dir-a"
run "rm -r dir-b"
run "ls -la"

end_log
