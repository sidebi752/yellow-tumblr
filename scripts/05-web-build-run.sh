#!/usr/bin/env bash
# [평가 #6, #7, #11, #16] Dockerfile 빌드 → 포트 매핑 2회 실행 → curl 접속 → 포트 충돌 재현/진단
# 끝난 뒤에도 컨테이너(8080, 8081)는 켜 둡니다. 브라우저 캡처(주소창 포함)를 찍은 다음 99-cleanup.sh 로 정리하세요.
source "$(dirname "$0")/lib.sh"
start_log 05-web-build-run

cd "$REPO_ROOT" || exit 1

run "docker rm -f my-web-8080 my-web-8081 my-web-conflict 2>/dev/null"

echo
echo "### 1. Dockerfile 내용 + 빌드"
run "cat Dockerfile"
run "docker build -t my-web:1.0 ."
run "docker images my-web"

echo
echo "### 2. 포트 매핑으로 2번 실행 (호스트 8080→컨테이너 80, 호스트 8081→컨테이너 80)"
run "docker run -d -p 8080:80 --name my-web-8080 my-web:1.0"
run "docker run -d -p 8081:80 --name my-web-8081 my-web:1.0"
run "sleep 2"
run "docker ps"

echo
echo "### 3. 접속 확인 (curl)"
run "curl -s http://localhost:8080"
run "curl -s http://localhost:8081"
run "curl -sI http://localhost:8080 | head -n 5"

echo
echo "### 4. 로그 / 헬스체크 확인"
run "docker logs my-web-8080 | tail -n 5"
run "sleep 8"
run "docker inspect --format='health={{.State.Health.Status}}' my-web-8080"

echo
echo "### 5. 포트 충돌 재현 (8080은 이미 사용 중이므로 에러가 나는 게 정상)"
run "docker run -d -p 8080:80 --name my-web-conflict my-web:1.0"
run "docker ps -a --filter name=my-web"

echo
echo "### 6. 충돌 진단: 누가 8080을 쓰고 있나?"
run "docker ps --filter publish=8080"
run "lsof -i :8080 || echo '(lsof 없음/없는 경우: 위 docker ps 결과로 확인)'"

echo
echo "### 7. 충돌 해소: 실패한 컨테이너 정리"
run "docker rm -f my-web-conflict"
run "docker ps -a --filter name=my-web"

echo
echo ">>> 이제 브라우저에서 http://localhost:8080 , http://localhost:8081 을 열고"
echo ">>> 주소창이 보이게 캡처하세요 → docs/images/ 에 저장"

end_log
