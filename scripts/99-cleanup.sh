#!/usr/bin/env bash
# 실습 후 정리: 컨테이너와 볼륨을 지웁니다. (캡처/로그를 다 남긴 뒤에 실행하세요)
source "$(dirname "$0")/lib.sh"

run "docker rm -f my-web-8080 my-web-8081 my-web-conflict vol-test vol-test2 bind-test ubuntu-keep 2>/dev/null"
run "docker volume rm mydata 2>/dev/null"
run "docker ps -a"
run "docker volume ls"
