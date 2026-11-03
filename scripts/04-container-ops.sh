#!/usr/bin/env bash
# [평가 #4, #5, #12] ubuntu 컨테이너 실습 + 로그/리소스 확인 + exec/attach 차이 관찰
# ※ 'docker run -it ubuntu bash' 같은 대화형 진입은 스크립트로 못 하니
#    README의 "수동 실습" 항목을 따라 직접 한 번 해보고 그 화면을 캡처하세요.
source "$(dirname "$0")/lib.sh"
start_log 04-container-ops

run "docker rm -f ubuntu-keep 2>/dev/null"

echo
echo "### 1. ubuntu 컨테이너에서 명령 실행 (실행 후 바로 종료되는 컨테이너)"
run "docker pull ubuntu"
run "docker run --rm ubuntu bash -c 'ls / && echo hello from ubuntu'"

echo
echo "### 2. 계속 살아있는 컨테이너 만들기 (백그라운드 -d)"
run "docker run -d --name ubuntu-keep ubuntu bash -c 'echo container-started; sleep infinity'"
run "docker ps"

echo
echo "### 3. exec: 살아있는 컨테이너 안에서 새 명령 실행"
run "docker exec ubuntu-keep bash -c 'echo exec-test && ls /'"

echo
echo "### 4. 로그 / 리소스 확인"
run "docker logs ubuntu-keep"
run "docker stats --no-stream"

echo
echo "### 5. 중지 / 목록 / 삭제"
run "docker stop ubuntu-keep"
run "docker ps"
run "docker ps -a"
run "docker rm ubuntu-keep"
run "docker images"

end_log
