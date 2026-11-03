#!/usr/bin/env bash
# [평가 #2, #15] 권한 실습: 파일 1개 + 디렉토리 1개, 변경 전/후 비교
#
# ★ Windows(MSYS2/Git Bash)의 C: 디스크(NTFS)는 리눅스 권한(rwx)을 흉내만 내서
#   chmod 결과가 제대로 안 보입니다. 그래서 진짜 리눅스인 ubuntu 컨테이너 안에서 실습합니다.
#   (Docker가 실행 중이어야 합니다.)
source "$(dirname "$0")/lib.sh"
start_log 02-permissions

echo "### 실습 환경: ubuntu 컨테이너 (컨테이너 안은 진짜 리눅스 파일 시스템)"
run "docker run --rm ubuntu bash -c 'uname -a && id'"

# 아래 heredoc 안의 내용이 컨테이너 안에서 실행됩니다. (r = 명령을 보여주고 실행)
docker run --rm -i ubuntu bash -s <<'EOF'
r() { printf '\n$ %s\n' "$*"; eval "$*"; }

echo
echo "### 0. 작업 폴더 준비"
r "mkdir -p /tmp/perm/secret-dir"
r "cd /tmp/perm"
r "printf '#!/usr/bin/env bash\necho script is running\n' > hello.sh"

echo
echo "### 1. 파일 권한: 변경 전 (기본 644 = rw-r--r--)"
r "ls -l hello.sh"

echo
echo "### 2. 실행 권한(x)이 없으면 실행이 막힌다"
r "./hello.sh"

echo
echo "### 3. chmod 755 로 변경 → 실행 가능"
r "chmod 755 hello.sh"
r "ls -l hello.sh"
r "./hello.sh"

echo
echo "### 4. 기호 방식으로도 변경해 보기 (u=소유자, g=그룹, o=그 외)"
r "chmod go-rx hello.sh"
r "ls -l hello.sh"
r "chmod 644 hello.sh"
r "ls -l hello.sh"

echo
echo "### 5. 디렉토리 권한: 변경 전 / 후"
r "ls -ld secret-dir"
r "chmod 700 secret-dir"
r "ls -ld secret-dir"
r "chmod 755 secret-dir"
r "ls -ld secret-dir"
EOF

end_log
