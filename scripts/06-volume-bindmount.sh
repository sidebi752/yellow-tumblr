#!/usr/bin/env bash
# [평가 #8, #17] Docker 볼륨 영속성 + 바인드 마운트 반영 + 볼륨 백업 예시
source "$(dirname "$0")/lib.sh"
start_log 06-volume-bindmount

cd "$REPO_ROOT" || exit 1

run "docker rm -f vol-test vol-test2 bind-test 2>/dev/null"
run "docker volume rm mydata 2>/dev/null"

echo
echo "################ A. Docker 볼륨 영속성 ################"
echo "### 1. 볼륨 생성 → 컨테이너에 연결 → 데이터 쓰기"
run "docker volume create mydata"
run "docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity"
run "docker exec vol-test bash -c 'echo hi-volume > /data/hello.txt && cat /data/hello.txt'"

echo
echo "### 2. 컨테이너 삭제 (삭제 전/후 비교)"
run "docker ps -a --filter name=vol-test"
run "docker rm -f vol-test"
run "docker ps -a --filter name=vol-test"

echo
echo "### 3. 새 컨테이너에 같은 볼륨 연결 → 데이터가 남아있는지 확인"
run "docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity"
run "docker exec vol-test2 cat /data/hello.txt"
run "docker volume ls"
run "docker volume inspect mydata"

echo
echo "### 4. (참고) 볼륨 백업: 볼륨 내용을 tar 파일로 꺼내기"
run "mkdir -p backup-demo"
run "docker run --rm -v mydata:/data -v \"$REPO_ROOT/backup-demo\":/backup ubuntu tar czf /backup/mydata.tgz -C /data ."
run "ls -l backup-demo"

echo
echo "################ B. 바인드 마운트 반영 ################"
BIND="$REPO_ROOT/bind-demo"
run "mkdir -p \"$BIND\""
run "echo '<h1>BEFORE (host file)</h1>' > \"$BIND/index.html\""
run "docker run -d --name bind-test -p 8082:80 -v \"$BIND\":/usr/share/nginx/html:ro nginx:alpine"
run "sleep 2"

echo
echo "### 변경 전"
run "cat \"$BIND/index.html\""
run "curl -s http://localhost:8082"

echo
echo "### 호스트에서 파일만 수정 (컨테이너 재시작/재빌드 없음)"
run "echo '<h1>AFTER (host file changed)</h1>' > \"$BIND/index.html\""

echo
echo "### 변경 후"
run "cat \"$BIND/index.html\""
run "curl -s http://localhost:8082"

end_log
