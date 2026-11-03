#!/usr/bin/env bash
# [README 1) 실행 환경] 에 붙여 넣을 정보를 기록합니다.
source "$(dirname "$0")/lib.sh"
start_log 00-env

run "uname -a"
run "echo \$SHELL"
run "bash --version | head -n 1"
run "docker --version"
run "git --version"
run "code --version | head -n 1"

end_log
