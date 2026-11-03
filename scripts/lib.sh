#!/usr/bin/env bash
# 공통 함수 모음 (직접 실행하지 않고, 다른 스크립트가 source 해서 사용합니다)
#  - start_log : 이 스크립트의 모든 출력(화면에 보이는 것)을 logs/<이름>.log 에도 저장
#  - run       : "$ 명령어" 를 먼저 찍고 → 실행 → 출력. 로그에 '명령 + 결과'가 같이 남음

# Git Bash(Windows)에서 /data 같은 경로가 멋대로 변환되는 것을 방지
export MSYS_NO_PATHCONV=1

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$REPO_ROOT/logs"
mkdir -p "$LOG_DIR"

start_log() {
  LOG_FILE="$LOG_DIR/$1.log"
  : > "$LOG_FILE"
  exec > >(tee -a "$LOG_FILE") 2>&1
  echo "# $1  ($(date '+%Y-%m-%d %H:%M:%S'))"
}

end_log() {
  # tee가 마지막 줄까지 파일에 쓸 시간을 잠깐 준다
  sleep 0.5
  echo
  echo "=> 로그 저장 위치: logs/$(basename "$LOG_FILE")"
}

run() {
  printf '\n$ %s\n' "$*"
  eval "$*"
  local rc=$?
  if [ $rc -ne 0 ]; then
    echo "(종료 코드: $rc)"
  fi
  return 0
}
