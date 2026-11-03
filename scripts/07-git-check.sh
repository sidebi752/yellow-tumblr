#!/usr/bin/env bash
# [평가 #9] Git 설정 + 원격 연결 상태 기록
#  - 토큰/비밀번호/인증 관련 줄은 자동으로 걸러냅니다 (그래도 올리기 전에 눈으로 한 번 더 확인!)
#  - 최초 push 로그는 아래 명령으로 직접 남기세요:
#      git push -u origin main 2>&1 | tee logs/07-first-push.log
source "$(dirname "$0")/lib.sh"
start_log 07-git-check

cd "$REPO_ROOT" || exit 1

run "git --version"
run "git config --list | grep -v -i -E 'token|password|credential|secret'"
run "git branch --show-current"
run "git remote -v | sed -E 's#(https://)[^@/]+@#\\1***@#'"
run "git status -sb"
run "git log --oneline -n 5"

end_log
