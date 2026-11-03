#!/usr/bin/env bash
# [평가 #3, #4, #5] Docker 설치/데몬 점검 + hello-world + 이미지/컨테이너 목록
source "$(dirname "$0")/lib.sh"
start_log 03-docker-check

echo "### 1. 설치 확인"
run "docker --version"
run "docker version"

echo
echo "### 2. 데몬(서버) 동작 확인 — 'Server:' 섹션이 보이면 데몬이 살아있는 것"
run "docker info"

echo
echo "### 3. hello-world 실행"
run "docker run --rm hello-world"

echo
echo "### 4. 이미지 / 컨테이너 목록"
run "docker images"
run "docker ps"
run "docker ps -a"

end_log
