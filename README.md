# 코디세이 입학연수 1 — 개발 워크스테이션 구축

> 📝 **작성 안내 (제출 전에 이 박스는 지우세요)**
> - `<!-- TODO -->` 와 `⬜` 표시를 전부 채우면 완성입니다.
> - 명령 + 출력은 `logs/` 폴더의 로그에서 **필요한 부분을 복사해 코드블록(```)에 붙여 넣으세요.**
> - 스크린샷은 `docs/images/` 에 저장하고 `![설명](docs/images/파일명.png)` 로 넣습니다.
> - 설명 파트(8번)는 힌트를 참고하되 **반드시 내 말로** 다시 쓰세요. 평가자는 "스스로 설명할 수 있는지"를 봅니다.
> - 토큰, 비밀번호, 인증 코드, 개인키는 로그/캡처 어디에도 남기지 마세요 (마스킹).

---

## 0. 프로젝트 개요

이 저장소는 코디세이 입학연수 1 미션의 결과물이다. 터미널(리눅스 CLI), Docker, Git/GitHub로
"재현 가능한 개발 환경"을 직접 구성하고, 모든 수행 결과를 명령어·출력 로그로 검증했다.

## 1. 실행 환경

| 항목 | 값 |
|---|---|
| OS | MINGW64_NT-10.0-19045 DESKTOP-1T273GH 3.6.10-5a1665c8.x86_64 2026-09-28 10:40 UTC x86_64 Msys |
| Shell / 터미널 | /usr/bin/bash | GNU bash, version 5.3.15(2)-release (x86_64-pc-cygwin) |
| Docker 버전 | Docker version 29.7.2, build a7dcaa6 |
| Git 버전 | git version 2.56.0.windows.4 |
| 에디터 | VSCode 1.134.0 버전 |

## 2. 수행 체크리스트

- [ ] 터미널 기본 조작 (이동/생성/복사/이름변경/삭제) → [3-1](#3-1-터미널-조작-로그)
- [ ] 권한 변경 실습 (파일 1 + 디렉토리 1) → [3-2](#3-2-권한-실습)
- [ ] Docker 설치/데몬 점검 → [4-1](#4-1-docker-설치데몬-점검)
- [ ] hello-world 실행 → [4-2](#4-2-hello-world)
- [ ] 이미지/컨테이너 운영 명령 (images, ps, logs, stats) → [4-3](#4-3-이미지컨테이너-운영)
- [ ] ubuntu 컨테이너 진입 + exec/attach 관찰 → [4-4](#4-4-ubuntu-컨테이너-실습)
- [ ] Dockerfile 커스텀 이미지 빌드/실행 → [5](#5-dockerfile-기반-웹-서버-커스텀-이미지)
- [ ] 포트 매핑 접속 증거 (2회) → [6](#6-포트-매핑-접속-증거)
- [ ] 바인드 마운트 반영 → [7-1](#7-1-바인드-마운트)
- [ ] Docker 볼륨 영속성 → [7-2](#7-2-docker-볼륨-영속성)
- [ ] Git 설정 + GitHub/VSCode 연동 → [8](#8-git-설정-및-github-연동)
- [ ] 개념 설명 6개 → [9](#9-개념-설명)
- [ ] 트러블슈팅 2건 이상 → [10](#10-트러블슈팅)

### 2-1. 증거 한눈에 보기 (Evidence Index)

> 링크를 누르면 해당 로그/스크린샷/스크립트로 바로 이동합니다. (저장소 안의 상대 경로 링크)

| 수행 항목 | 실행 스크립트 | 로그(명령+출력) | 스크린샷 |
|---|---|---|---|
| 실행 환경 | [00-env.sh](scripts/00-env.sh) | [00-env.log](logs/00-env.log) | - |
| 터미널 조작 | [01-terminal.sh](scripts/01-terminal.sh) | [01-terminal.log](logs/01-terminal.log) | - |
| 권한 실습 | [02-permissions.sh](scripts/02-permissions.sh) | [02-permissions.log](logs/02-permissions.log) | - |
| Docker 점검/hello-world | [03-docker-check.sh](scripts/03-docker-check.sh) | [03-docker-check.log](logs/03-docker-check.log) | - |
| 컨테이너 운영 | [04-container-ops.sh](scripts/04-container-ops.sh) | [04-container-ops.log](logs/04-container-ops.log) | [ubuntu 진입](docs/images/04-ubuntu-interactive.png) |
| 빌드 + 포트 매핑 | [05-web-build-run.sh](scripts/05-web-build-run.sh) | [05-web-build-run.log](logs/05-web-build-run.log) | [8080](docs/images/06-browser-8080.png) · [8081](docs/images/06-browser-8081.png) |
| 볼륨 / 바인드 마운트 | [06-volume-bindmount.sh](scripts/06-volume-bindmount.sh) | [06-volume-bindmount.log](logs/06-volume-bindmount.log) | - |
| Git / GitHub 연동 | [07-git-check.sh](scripts/07-git-check.sh) | [07-git-check.log](logs/07-git-check.log) · [첫 push](logs/07-first-push.log) | [VSCode](docs/images/08-vscode-github.png) · [커밋 목록](docs/images/08-github-commits.png) |

저장소 주소: <https://github.com/sidebi752/yellow-tumblr>

## 3. 터미널 / 권한

### 3-1. 터미널 조작 로그

> 스크립트: [`scripts/01-terminal.sh`](scripts/01-terminal.sh) / 로그: [`logs/01-terminal.log`](logs/01-terminal.log)
> 확인한 것: pwd, ls -la(숨김 포함), mkdir, cd, touch, cat, cp, mv(이동/이름변경), rm/rmdir

<details>
<summary>📄 터미널 조작 로그 펼쳐 보기 (클릭)</summary>

01-terminal  (2026-11-03 22:26:04)
#### 0. 실습 폴더 초기화 (매번 같은 결과가 나오도록)

$ rm -rf "/c/Users/MKJ/codyssey-practice"

#### 1. 현재 위치 확인 / 목록 확인(숨김 파일 포함)

$ pwd
/c/Users/MKJ/Desktop/codyssey-entry-1/scripts

$ ls -la
total 39
drwxr-xr-x 1 MKJ 197121    0 Nov  1 22:34 ./
drwxr-xr-x 1 MKJ 197121    0 Nov  3 22:12 ../
-rwxr-xr-x 1 MKJ 197121  295 Nov  1 22:34 00-env.sh*
-rwxr-xr-x 1 MKJ 197121 1331 Nov  1 22:34 01-terminal.sh*
-rwxr-xr-x 1 MKJ 197121 1012 Nov  1 22:34 02-permissions.sh*
-rwxr-xr-x 1 MKJ 197121  564 Nov  1 22:34 03-docker-check.sh*
-rwxr-xr-x 1 MKJ 197121 1233 Nov  1 22:34 04-container-ops.sh*
-rwxr-xr-x 1 MKJ 197121 1931 Nov  1 22:34 05-web-build-run.sh*
-rwxr-xr-x 1 MKJ 197121 2042 Nov  1 22:34 06-volume-bindmount.sh*
-rwxr-xr-x 1 MKJ 197121  671 Nov  1 22:34 07-git-check.sh*
-rwxr-xr-x 1 MKJ 197121  363 Nov  1 22:34 99-cleanup.sh*
-rwxr-xr-x 1 MKJ 197121 1022 Nov  1 22:34 lib.sh*

#### 2. 디렉토리 생성 + 이동

$ mkdir -p "/c/Users/MKJ/codyssey-practice/dir-a" "/c/Users/MKJ/codyssey-practice/dir-b"

$ cd "/c/Users/MKJ/codyssey-practice"

$ pwd
/c/Users/MKJ/codyssey-practice

#### 3. 빈 파일 생성 / 내용이 있는 파일 생성 / 내용 확인

$ touch empty.txt

$ echo 'hello codyssey' > hello.txt

$ cat hello.txt
hello codyssey

$ ls -la
total 25
drwxr-xr-x 1 MKJ 197121  0 Nov  3 22:26 ./
drwxr-xr-x 1 MKJ 197121  0 Nov  3 22:26 ../
drwxr-xr-x 1 MKJ 197121  0 Nov  3 22:26 dir-a/
drwxr-xr-x 1 MKJ 197121  0 Nov  3 22:26 dir-b/
-rw-r--r-- 1 MKJ 197121  0 Nov  3 22:26 empty.txt
-rw-r--r-- 1 MKJ 197121 15 Nov  3 22:26 hello.txt

#### 4. 복사 / 이동 / 이름 변경

$ cp hello.txt dir-a/hello-copy.txt

$ mv hello.txt renamed.txt

$ mv renamed.txt dir-b/

$ ls -R
.:
dir-a/
dir-b/
empty.txt

./dir-a:
hello-copy.txt

./dir-b:
renamed.txt

#### 5. 절대 경로 vs 상대 경로 (같은 파일을 두 방식으로 읽기)

$ cat "/c/Users/MKJ/codyssey-practice/dir-b/renamed.txt"
hello codyssey

$ cd dir-b && pwd
/c/Users/MKJ/codyssey-practice/dir-b

$ cat ./renamed.txt
hello codyssey

$ cat ../dir-a/hello-copy.txt
hello codyssey

$ cd "/c/Users/MKJ/codyssey-practice"

#### 6. 삭제

$ rm dir-a/hello-copy.txt

$ rmdir dir-a

$ rm -r dir-b

$ ls -la
total 24
drwxr-xr-x 1 MKJ 197121 0 Nov  3 22:26 ./
drwxr-xr-x 1 MKJ 197121 0 Nov  3 22:26 ../
-rw-r--r-- 1 MKJ 197121 0 Nov  3 22:26 empty.txt

</details>

> 💡 긴 로그는 이렇게 `<details>`로 접어 두면 문서가 짧고 깔끔해집니다. 다른 항목에도 같은 방식을 써도 됩니다.

### 3-2. 권한 실습

#### 0. 작업 폴더 준비

$ mkdir -p /tmp/perm/secret-dir

$ cd /tmp/perm

$ printf '#!/usr/bin/env bash
echo script is running
' > hello.sh

#### 1. 파일 권한: 변경 전, 기본 644 = rw-r--r--

$ ls -l hello.sh
-rw-r--r-- 1 root root 43 Nov  3 14:18 hello.sh

#### 2. 실행 권한(x)이 없으면 실행이 막힌다

$ ./hello.sh
bash: line 1: ./hello.sh: Permission denied

#### 3. chmod 755 로 변경 → 실행 가능

$ chmod 755 hello.sh

$ ls -l hello.sh
-rwxr-xr-x 1 root root 43 Nov  3 14:18 hello.sh

$ ./hello.sh
script is running

#### 4. 기호 방식으로도 변경해 보기 (u=소유자, g=그룹, o=그 외)

$ chmod go-rx hello.sh

$ ls -l hello.sh
-rwx------ 1 root root 43 Nov  3 14:18 hello.sh

$ chmod 644 hello.sh

$ ls -l hello.sh
-rw-r--r-- 1 root root 43 Nov  3 14:18 hello.sh

#### 5. 디렉토리 권한: 변경 전 / 후

$ ls -ld secret-dir
drwxr-xr-x 2 root root 4096 Nov  3 14:18 secret-dir

$ chmod 700 secret-dir

$ ls -ld secret-dir
drwx------ 2 root root 4096 Nov  3 14:18 secret-dir

$ chmod 755 secret-dir

$ ls -ld secret-dir
drwxr-xr-x 2 root root 4096 Nov  3 14:18 secret-dir


관찰한 점: 644일 때 ./hello.sh 가 "Permission denied" 였고 755 후 실행된 것 "script is running" 

## 4. Docker 점검 / 운영

### 4-1. Docker 설치/데몬 점검

> 스크립트: [`scripts/03-docker-check.sh`](scripts/03-docker-check.sh) / 로그: [`logs/03-docker-check.log`](logs/03-docker-check.log)

$ docker --version
 Version:           29.7.2
 API version:       1.55
 Go version:        go1.26.5
 Git commit:        a7dcaa6
 Built:             Wed Aug  5 18:31:33 2026
 OS/Arch:           windows/amd64
 Context:           desktop-linux

 Server: Docker Desktop 4.88.0 (237115)
 Engine:
  Version:          29.7.2
  API version:      1.55 (minimum version 1.40)
  Go version:       go1.26.5
  Git commit:       6a43e3d
  Built:            Wed Aug  5 18:28:36 2026
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          v2.3.3
  GitCommit:        aad11006b869517fcd3009450b6f82da282e1a9b
 runc:
  Version:          1.4.3
  GitCommit:        v1.4.3-0-gbb14dabe
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

$ docker info   
Client:
 Version:    29.7.2
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.124.0
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-agent.exe
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.30.0
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-ai.exe
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.36.1-desktop.1
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-buildx.exe
  compose: Docker Compose (Docker Inc.)
    Version:  v5.4.0
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-compose.exe
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.0.47
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-debug.exe
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  v0.4.3
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-desktop.exe
  dhi: CLI for managing Docker Hardened Images (Docker Inc.)
    Version:  v0.0.7
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-dhi.exe
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.31
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-extension.exe
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.0
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-init.exe
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.43.3
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-mcp.exe
  model: Docker Model Runner (Docker Inc.)
    Version:  v1.2.6
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-model.exe
  offload: Docker Offload (Docker Inc.)
    Version:  v0.6.13
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-offload.exe
  pass: Docker Pass Secrets Manager Plugin (beta) (Docker Inc.)
    Version:  v0.2.1
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-pass.exe
  sandbox: "docker sandbox" is deprecated, use Docker Sandboxes instead (Docker Inc.)
    Version:  v0.13.0
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-sandbox.exe
  scout: Docker Scout (Docker Inc.)
    Version:  v1.24.0
    Path:     C:\Users\MKJ\.docker\cli-plugins\docker-scout.exe

Server:
 Containers: 4
  Running: 0
  Paused: 0
  Stopped: 4
 Images: 3
 Server Version: 29.7.2
 Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Discovered Devices:
  cdi: docker.com/gpu=webgpu
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: aad11006b869517fcd3009450b6f82da282e1a9b
 runc version: v1.4.3-0-gbb14dabe
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.18.54.1-microsoft-standard-WSL2
 Operating System: Docker Desktop (containerized)
 OSType: linux
 Architecture: x86_64
 CPUs: 8
 Total Memory: 3.734GiB
 Name: docker-desktop
 ID: ef3ccb55-da57-42fd-acb6-86db21536352
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 HTTP Proxy: http.docker.internal:3128
 HTTPS Proxy: http.docker.internal:3128
 No Proxy: hubproxy.docker.internal
 Labels:
  com.docker.desktop.address=npipe://\\.\pipe\docker_cli
 Experimental: false
 Insecure Registries:
  hubproxy.docker.internal:5555
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Firewall Backend: iptables

### 4-2. hello-world

$ docker run --rm hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pulling fs layer
4f55086f7dd0: Download complete
4f55086f7dd0: Pull complete
d5e71e642bf5: Download complete
Digest: sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

### 4-3. 이미지/컨테이너 운영

> 로그: `logs/03-docker-check.log`, [`logs/04-container-ops.log`](logs/04-container-ops.log)

$ docker images
IMAGE                             ID             DISK USAGE   CONTENT SIZE   EXTRA
andalog-api:latest                ba63f9e60377        292MB         69.1MB   U    
docker/welcome-to-docker:latest   c4d56c24da4f       22.2MB         6.03MB   U    
hello-world:latest                c567b231f656       25.9kB         9.49kB        
nginx:1.27-alpine                 65645c7bb6a0       74.5MB         21.9MB   U  

$ docker ps -a
CONTAINER ID   IMAGE                             COMMAND                   CREATED        STATUS                      PORTS     NAMES
38545a83f7c1   nginx:1.27-alpine                 "/docker-entrypoint.…"   2 months ago   Exited (0) 2 months ago               andalog-nginx-1
29ae5ef9f64b   andalog-api                       "uvicorn app.main:ap…"   2 months ago   Exited (0) 2 months ago               andalog-api-1
34f38a14bce0   99703de8339a                      "uvicorn app.main:ap…"   2 months ago   Exited (0) 2 months ago               adoring_perlman
a410547e7dd6   docker/welcome-to-docker:latest   "/docker-entrypoint.…"   2 months ago   Exited (137) 2 months ago             welcome-to-docker

$ docker logs ubuntu-keep
container-started

$ docker stats --no-stream
CONTAINER ID   NAME          CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O
   PIDS
327dc075654a   ubuntu-keep   0.00%     2.926MiB / 3.734GiB   0.08%     872B / 126B       0B / 0B
   1
36064efb0646   bind-test     0.00%     7.414MiB / 3.734GiB   0.19%     2.35kB / 1.42kB   0B / 12.3kB
   9
f93fc6447596   vol-test2     0.00%     1.598MiB / 3.734GiB   0.04%     1.38kB / 126B     0B / 0B
   1
3ee817534ab4   my-web-8081   0.00%     8.375MiB / 3.734GiB   0.22%     5.05kB / 3.66kB   0B / 12.3kB
   9
268144b1f874   my-web-8080   0.00%     8.785MiB / 3.734GiB   0.23%     5.87kB / 4.17kB   0B / 12.3kB
   9

### 4-4. ubuntu 컨테이너 실습

$ docker run -it --name ubuntu-manual ubuntu bash
root@fe9c1adcea12:/# ls
bin   dev  home  lib64  mnt  proc  run   srv  tmp  var
boot  etc  lib   media  opt  root  sbin  sys  usr
root@fe9c1adcea12:/# echo hi
hi
root@fe9c1adcea12:/# exit
exit

$ docker ps -a 
CONTAINER ID   IMAGE                             COMMAND                   CREATED             STATU
S                       PORTS                                     NAMES
fe9c1adcea12   ubuntu                            "bash"                    24 seconds ago      Exite
d (0) 7 seconds ago                                               ubuntu-manual
36064efb0646   nginx:alpine                      "/docker-entrypoint.…"   About an hour ago   Up Abo
ut an hour             0.0.0.0:8082->80/tcp, [::]:8082->80/tcp   bind-test
f93fc6447596   ubuntu                            "sleep infinity"          About an hour ago   Up Ab
out an hour                                                       vol-test2
3ee817534ab4   my-web:1.0                        "/docker-entrypoint.…"   About an hour ago   Up Abo
ut an hour (healthy)   0.0.0.0:8081->80/tcp, [::]:8081->80/tcp   my-web-8081
268144b1f874   my-web:1.0                        "/docker-entrypoint.…"   About an hour ago   Up Abo
ut an hour (healthy)   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-web-8080
38545a83f7c1   nginx:1.27-alpine                 "/docker-entrypoint.…"   2 months ago        Exited
 (0) 2 months ago                                                andalog-nginx-1
29ae5ef9f64b   andalog-api                       "uvicorn app.main:ap…"   2 months ago        Exited
 (0) 2 months ago                                                andalog-api-1
34f38a14bce0   99703de8339a                      "uvicorn app.main:ap…"   2 months ago        Exited
 (0) 2 months ago                                                adoring_perlman
a410547e7dd6   docker/welcome-to-docker:latest   "/docker-entrypoint.…"   2 months ago        Exited
 (137) 2 months ago                                              welcome-to-docker


![ubuntu 컨테이너 진입](docs/images/04-ubuntu-interactive.png)

exec vs attach 관찰 정리: 

exec: 내가 띄운 프로세스만 끝남. 컨테이너 유지
attach: ctrl p, ctrl q 안하고 나오면 컨테이너 꺼짐


## 5. Dockerfile 기반 웹 서버 커스텀 이미지

> 파일: [`Dockerfile`](Dockerfile), [`app/index.html`](app/index.html) / 로그: [`logs/05-web-build-run.log`](logs/05-web-build-run.log)

선택한 방식: (A) 웹 서버 베이스 이미지(`nginx:alpine`) + 정적 콘텐츠/설정 교체

| 커스텀 포인트 | 목적 |
|---|---|
| `LABEL` | 이미지 이름, 설명을 메타데이터로 남겨 관리, 검색을 쉽게 함 |
| `ENV APP_ENV=dev` | 실행 모드를 환경변수로 분리(설정과 코드의 분리) 각주 붙이기 비슷함 |
| `COPY app/ ...` | 기본 nginx 화면을 내가 만든 페이지로 교체. 이제 서비스 준비 시작해야지 |
| `HEALTHCHECK` | 컨테이너 안에서 웹 서버가 정상 응답하는지 주기적으로 점검. 살아있니 |

빌드/실행 로그:

$ docker build -t my-web:1.0 .
#0 building with "desktop-linux" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 1.10kB 0.0s done
#1 DONE 0.1s

#2 [internal] load metadata for docker.io/library/nginx:alpine
#2 DONE 2.5s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.1s

#4 [1/2] FROM docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#4 resolve docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606 0.1s done
#4 ...

#5 [internal] load build context
#5 transferring context: 403B 0.2s done
#5 DONE 0.3s

#4 [1/2] FROM docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#4 DONE 0.5s

#4 [1/2] FROM docker.io/library/nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 0B / 20.53MB 0.2s
#4 sha256:9b0f7dfe35b2711a17f60dadd6d4035dc0cdee152538cc5c0987029e94679548 0B / 1.40kB 0.2s
#4 sha256:2ec5fb117ffa9a78b15fb6a78745ffc569c8da0aee9f36ace4cd67a44b1fef79 0B / 1.21kB 0.2s
#4 sha256:26185d08a3ec318dd85a6c9f2172e714ec13cececd7f33c533b40b1689f9fedb 0B / 404B 0.2s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 1.05MB / 20.53MB 0.5s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 2.10MB / 20.53MB 0.6s
#4 sha256:9b0f7dfe35b2711a17f60dadd6d4035dc0cdee152538cc5c0987029e94679548 1.40kB / 1.40kB 0.5s done
#4 sha256:2ec5fb117ffa9a78b15fb6a78745ffc569c8da0aee9f36ace4cd67a44b1fef79 1.21kB / 1.21kB 0.6s done
#4 sha256:26185d08a3ec318dd85a6c9f2172e714ec13cececd7f33c533b40b1689f9fedb 404B / 404B 0.7s done
#4 sha256:7cc330898115ce55acccb0cc1e7dd091df4410c8c5f3c540710ee0ac689f5fcb 0B / 964B 0.2s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 4.19MB / 20.53MB 0.8s
#4 sha256:7cc330898115ce55acccb0cc1e7dd091df4410c8c5f3c540710ee0ac689f5fcb 964B / 964B 0.3s done
#4 sha256:657023555a2a19dc6036468198bb350d2c7feaac7f2d0a3901b4dd3cb25e40c5 0B / 629B 0.2s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 5.24MB / 20.53MB 0.9s
#4 sha256:657023555a2a19dc6036468198bb350d2c7feaac7f2d0a3901b4dd3cb25e40c5 629B / 629B 0.3s done
#4 sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788 0B / 3.85MB 0.2s
#4 sha256:12b85cff06fd7d383d36a9c96503fe049c9d4bf3dfda5cbb9ffa6ae99b9c07a6 0B / 1.94MB 0.2s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 6.29MB / 20.53MB 1.1s
#4 sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788 1.05MB / 3.85MB 0.5s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 7.34MB / 20.53MB 1.2s
#4 sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788 2.10MB / 3.85MB 0.6s
#4 sha256:12b85cff06fd7d383d36a9c96503fe049c9d4bf3dfda5cbb9ffa6ae99b9c07a6 1.05MB / 1.94MB 0.6s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 8.39MB / 20.53MB 1.5s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 9.44MB / 20.53MB 1.8s
#4 sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788 3.15MB / 3.85MB 1.1s
#4 sha256:12b85cff06fd7d383d36a9c96503fe049c9d4bf3dfda5cbb9ffa6ae99b9c07a6 1.94MB / 1.94MB 1.1s done
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 11.53MB / 20.53MB 2.0s
#4 sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788 3.85MB / 3.85MB 1.2s done
#4 extracting sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 12.58MB / 20.53MB 2.1s
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 13.63MB / 20.53MB 2.3s
#4 extracting sha256:7b229517ed222597277036d94892173207d01a731ab3a88eeb1de2e963a2c788 0.4s done
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 16.78MB / 20.53MB 2.6s
#4 extracting sha256:12b85cff06fd7d383d36a9c96503fe049c9d4bf3dfda5cbb9ffa6ae99b9c07a6
#4 extracting sha256:12b85cff06fd7d383d36a9c96503fe049c9d4bf3dfda5cbb9ffa6ae99b9c07a6 0.3s done
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 17.83MB / 20.53MB 2.7s
#4 extracting sha256:657023555a2a19dc6036468198bb350d2c7feaac7f2d0a3901b4dd3cb25e40c5 0.1s done
#4 extracting sha256:7cc330898115ce55acccb0cc1e7dd091df4410c8c5f3c540710ee0ac689f5fcb 0.1s done
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 18.87MB / 20.53MB 2.9s
#4 extracting sha256:26185d08a3ec318dd85a6c9f2172e714ec13cececd7f33c533b40b1689f9fedb 0.1s done
#4 extracting sha256:2ec5fb117ffa9a78b15fb6a78745ffc569c8da0aee9f36ace4cd67a44b1fef79 0.1s done
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 20.53MB / 20.53MB 3.0s
#4 extracting sha256:9b0f7dfe35b2711a17f60dadd6d4035dc0cdee152538cc5c0987029e94679548
#4 sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 20.53MB / 20.53MB 3.3s done
#4 extracting sha256:9b0f7dfe35b2711a17f60dadd6d4035dc0cdee152538cc5c0987029e94679548 0.4s done
#4 extracting sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919
#4 extracting sha256:b9b388a21ecfde6ac80505f23f527146a2129dfb104e79b029bbd00d4cc1a919 0.6s done
#4 DONE 4.5s

#6 [2/2] COPY app/ /usr/share/nginx/html/
#6 DONE 3.5s

#7 exporting to image
#7 exporting layers
#7 exporting layers 0.4s done
#7 exporting manifest sha256:b7c6239f9a99db928774253dc0bc30d4033e7377af249a6248b9f4014315894b 0.1s done
#7 exporting config sha256:459f6bae761c39010e11681b1a188055c36d2921a284c078b0952803e65dd91d
#7 exporting config sha256:459f6bae761c39010e11681b1a188055c36d2921a284c078b0952803e65dd91d 0.1s done
#7 exporting attestation manifest sha256:63a0cb10699e2c4ae7066add8faa3ca8003ff640a10dced4e1d51b3a7f10cb1a
#7 exporting attestation manifest sha256:63a0cb10699e2c4ae7066add8faa3ca8003ff640a10dced4e1d51b3a7f10cb1a 0.1s done
#7 exporting manifest list sha256:f7d098b7a68c2f7e5f174f071fad641394dbb74d1d4b1d99faaf9ba67a71e3da 0.1s done
#7 naming to docker.io/library/my-web:1.0 0.0s done
#7 unpacking to docker.io/library/my-web:1.0 0.1s done
#7 DONE 0.9s

$ docker run -d -p 8080:80 --name my-web-8080 my-web:1.0
268144b1f874e3bd34ab75a946f62d049eec56585a3cda518fe68f79ad968416

## 6. 포트 매핑 접속 증거

`-p <호스트포트>:<컨테이너포트>` 로 2회 실행했다. (8080→80, 8081→80)

$ curl -s http://localhost:8080
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Codyssey 입학연수 1</title>
</head>
<body>
  <h1>Hello, Codyssey!</h1>
  <p>Dockerfile로 만든 커스텀 nginx 컨테이너에서 서빙 중입니다.</p>
</body>
</html>

$ curl -s http://localhost:8081
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Codyssey 입학연수 1</title>
</head>
<body>
  <h1>Hello, Codyssey!</h1>
  <p>Dockerfile로 만든 커스텀 nginx 컨테이너에서 서빙 중입니다.</p>
</body>
</html>

**브라우저 접속 화면 (주소창에 포트가 보이게):**

![localhost:8080](docs/images/06-browser-8080.png)
![localhost:8081](docs/images/06-browser-8081.png)

### 6-1. 포트 충돌 진단 순서

> 재현 로그: `logs/05-web-build-run.log` 의 5~7번 항목

1. 증상: 
$ docker run -d -p 8080:80 --name my-web-conflict my-web:1.0
bd7d0f80900801952358af314d3cf492baae71498b8ff4a34220171a7f3987a0

What's next:
    Debug this container error with Gordon → docker ai "help me fix this container error"
docker: Error response from daemon: failed to set up container networking: driver failed programming
 external connectivity on endpoint my-web-conflict (7ac184d1a32e8f5224eb259ba5442b189d86a4a4cbc7d612
49b1eb9943dc1285): Bind for 0.0.0.0:8080 failed: port is already allocated

Run 'docker run --help' for more information

2. 누가 쓰나 확인: 
$ docker ps --filter publish=8080
CONTAINER ID   IMAGE        COMMAND                   CREATED       STATUS                 PORTS
                                 NAMES
268144b1f874   my-web:1.0   "/docker-entrypoint.…"   2 hours ago   Up 2 hours (healthy)   0.0.0.0:80
80->80/tcp, [::]:8080->80/tcp   my-web-8080

$ lsof -i :8080 || echo
bash: lsof: command not found

3. 해소: 
$ docker rm my-web-conflict
my-web-conflict

$ netstat -ano | grep 8090
MKJ@DESKTOP-1T273GH UCRT64 ~/Desktop/codyssey-entry-1
$ docker run -d -p 8090:80 --name my-web-8090 my-web:1.0
ac0b68456b0ab83f10a6a082258a03419beaba654fce023d5fc973d672a24064

$ curl -s http://localhost:8090
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Codyssey 입학연수 1</title>
</head>
<body>
  <h1>Hello, Codyssey!</h1>
  <p>Dockerfile로 만든 커스텀 nginx 컨테이너에서 서빙 중입니다.</p>
  <!-- TODO: 내 이름이나 날짜 등 나만의 문구를 넣어 보세요 -->
</body>
</html>

4. 비고:
실패한 컨테이너가 Created 상태로 남아있으면 docker rm 으로 정리


## 7. 바인드 마운트 / 볼륨

> 스크립트: [`scripts/06-volume-bindmount.sh`](scripts/06-volume-bindmount.sh) / 로그: [`logs/06-volume-bindmount.log`](logs/06-volume-bindmount.log)

### 7-1. 바인드 마운트

호스트 폴더를 컨테이너에 직접 연결(`-v <호스트절대경로>:<컨테이너경로>`). 호스트 파일을 고치면 컨테이너에 바로 반영된다.

- 변경 전: 
$ cat "/c/Users/MKJ/Desktop/codyssey-entry-1/bind-demo/index.html"
<h1>BEFORE (host file)</h1>

$ curl -s http://localhost:8082
<h1>BEFORE (host file)</h1>

- 호스트에서 파일 수정:
$ echo '<h1>AFTER (host file changed)</h1>' > "/c/Users/MKJ/Desktop/codyssey-entry-1/bind-demo/index.html"

- 변경 후: 
$ cat "/c/Users/MKJ/Desktop/codyssey-entry-1/bind-demo/index.html"
<h1>AFTER (host file changed)</h1>

$ curl -s http://localhost:8082
<h1>AFTER (host file changed)</h1>


### 7-2. Docker 볼륨 영속성

$ docker volume create mydata
mydata

$ docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
e8b5848c1f45ae9d10830732d6b8c37a49ae9d27690b4e808d6f7c9076d0c112

$ docker exec vol-test bash -c 'echo hi-volume > /data/hello.txt && cat /data/hello.txt'
hi-volume

$ docker rm -f vol-test
vol-test

$ docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
f93fc64475965719dcee891dbaf07c0f633bff7d3c8c2f7633a9e361cf179ded

$ docker exec vol-test2 cat /data/hello.txt
hi-volume

## 8. Git 설정 및 GitHub 연동

> 스크립트: [`scripts/07-git-check.sh`](scripts/07-git-check.sh) / 로그: [`logs/07-git-check.log`](logs/07-git-check.log), `logs/07-first-push.log`

$ git config --list | grep -v -i -E 'token|password|credential|secret'
diff.astextplain.textconv=astextplain
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
http.sslbackend=schannel
core.autocrlf=true
core.fscache=true
core.symlinks=false
pull.rebase=false
init.defaultbranch=master
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
remote.origin.url=https://github.com/sidebi752/yellow-tumblr.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
user.name=sidebi752
user.email=sidebi752@gmail.com

$ git remote -v | sed -E 's#(https://)[^@/]+@#\1***@#'
origin	https://github.com/sidebi752/yellow-tumblr.git (fetch)
origin	https://github.com/sidebi752/yellow-tumblr.git (push)

**최초 push 로그:**

```text
$ git push -u origin main
(붙여 넣기)
```

**연동 증거 (민감정보 가리기):**

![VSCode GitHub 로그인](docs/images/08-vscode-github.png)
![GitHub 저장소 커밋 목록](docs/images/08-github-commits.png)

## 9. 개념 설명

> ⚠️ 아래 힌트를 참고해 **내 말로, 예시를 들어** 다시 쓰세요.

### 9-1. 절대 경로 vs 상대 경로 (평가 #14)
<!-- TODO
 힌트: / 로 시작하면 절대(어디서든 같은 곳), ./ ../ 는 상대(현재 위치 기준).
 예시는 logs/01-terminal.log 의 5번 항목(같은 파일을 두 방식으로 읽기) 사용.
 Docker 연결: -v 의 호스트 경로는 절대 경로가 안전한 이유(실행 위치에 따라 달라지지 않음), 컨테이너 안 경로는 항상 컨테이너 기준 절대 경로.
-->

### 9-2. 파일 권한 r/w/x 와 755, 644 (평가 #15)
<!-- TODO
 힌트: r=4, w=2, x=1 을 소유자/그룹/그 외 순서로 합산. 755 = rwx r-x r-x = (4+2+1)(4+1)(4+1).
 644 = rw- r-- r--. 디렉토리의 x 는 "들어갈 수 있는 권한"이라는 점도 적어보기.
 근거: logs/02-permissions.log
-->

### 9-3. 이미지와 컨테이너 (평가 #12)
<!-- TODO
 힌트: 이미지=읽기 전용 설계도(빌드로 생성), 컨테이너=이미지를 실행한 인스턴스(실행으로 생성).
 사례: my-web:1.0 이미지 하나로 my-web-8080, my-web-8081 컨테이너 2개를 띄웠다.
 컨테이너 안에서 바꾼 내용은 이미지에 반영되지 않는다 → 그래서 볼륨이 필요.
-->

### 9-4. 포트 매핑이 필요한 이유 (평가 #13)
<!-- TODO
 힌트: 컨테이너는 자기만의 네트워크 네임스페이스(격리된 네트워크 공간)를 가져서 호스트에서 바로 접근 불가.
 -p 호스트:컨테이너 = 호스트 포트로 온 요청을 컨테이너 포트로 전달(포트포워딩).
 같은 이미지를 포트만 바꿔 여러 개 띄울 수 있는 이유도 연결.
-->

### 9-5. Docker 볼륨 / 바인드 마운트 비교 (평가 #17)
<!-- TODO
 | 구분 | 바인드 마운트 | 볼륨 |
 | 위치 | 내가 지정한 호스트 폴더 | Docker가 관리 |
 | 용도 | 개발 중 코드 즉시 반영 | 운영 데이터 영속 보관(DB 등) |
 | 장단점 | 호스트 경로에 의존, 권한 문제 가능 | 이식성·백업 편함, 직접 열어보기는 불편 |
 백업: logs/06-volume-bindmount.log 4번(tar로 꺼내기) 참고. 실무 권고도 한 줄.
-->

### 9-6. Git 과 GitHub 의 역할 차이
<!-- TODO
 힌트: Git=내 컴퓨터에서 변경 이력을 관리하는 도구(로컬 버전 관리). GitHub=Git 저장소를 올려두고 협업(PR, 이슈, 리뷰)하는 원격 플랫폼.
 근거: git remote -v, git push 로그.
-->

## 10. 트러블슈팅

> 형식: 문제 → 원인 가설 → 확인(명령+출력) → 해결/대안. **실제 출력 로그나 캡처를 꼭 첨부.**

### 10-1. <!-- TODO: 제목 (예: Docker Desktop 실행 오류 / 포트 충돌 / 권한 오류) -->

- **문제:**
- **원인 가설:**
- **확인:**

  ```text
  (실제 명령 + 출력)
  ```

- **해결/대안:**

### 10-2. <!-- TODO: 제목 -->

- **문제:**
- **원인 가설:**
- **확인:**

  ```text
  (실제 명령 + 출력)
  ```

- **해결/대안:**

## 11. 디렉토리 구조와 구성 기준 (평가 #10)

```text
.
├── README.md          # 기술 문서 (이 파일)
├── Dockerfile         # 커스텀 nginx 이미지 정의
├── app/
│   └── index.html     # 웹 서버가 보여줄 정적 콘텐츠 (COPY 대상)
├── scripts/           # 검증용 스크립트 (명령+출력을 logs/ 에 저장)
├── logs/              # 스크립트 실행 로그 = 수행 증거
└── docs/images/       # 브라우저/GitHub 연동 등 스크린샷
```

<!-- TODO: 구성 기준을 내 말로 한두 문장 (예: 소스/설정/증거를 분리해서 평가자가 위치를 바로 찾도록) -->

## 12. 재현 방법 (평가자용)

```bash
git clone https://github.com/sidebi752/yellow-tumblr.git
cd yellow-tumblr
bash scripts/00-env.sh
bash scripts/01-terminal.sh
bash scripts/02-permissions.sh
bash scripts/03-docker-check.sh
bash scripts/04-container-ops.sh
bash scripts/05-web-build-run.sh      # → 브라우저에서 localhost:8080, 8081 확인
bash scripts/06-volume-bindmount.sh
bash scripts/99-cleanup.sh            # 정리
```

- 사전 조건: Docker(또는 OrbStack/Docker Desktop) 실행 중, 포트 8080/8081/8082 사용 가능
- 주의: 스크립트는 bash 기준이며, 호스트 포트가 이미 사용 중이면 6-1 절차대로 포트를 바꿔 실행

---

## 부록: 평가 항목 자가 점검표 (제출 전 확인 후 삭제해도 됨)

| # | 평가 포인트 | 어디서 충족? | 확인 |
|---|---|---|---|
| 1 | 파일 생성/이동/삭제 명령+출력 | 3-1 | ⬜ |
| 2 | chmod + ls -l 전/후 | 3-2 | ⬜ |
| 3 | docker --version + 데몬(info) | 4-1 | ⬜ |
| 4 | hello-world 실행 | 4-2 | ⬜ |
| 5 | docker ps -a / images | 4-3 | ⬜ |
| 6 | Dockerfile 내용 + build 로그 | 5 | ⬜ |
| 7 | 호스트 포트 curl/브라우저 접속 | 6 | ⬜ |
| 8 | 볼륨 삭제 전/후 데이터 유지 | 7-2 | ⬜ |
| 9 | git remote -v + push 로그 | 8 | ⬜ |
| 10 | 디렉토리 트리 + 구성 기준 | 11 | ⬜ |
| 11 | 포트 매핑 재현 절차(명령·출력) | 6, 12 | ⬜ |
| 12 | 이미지 vs 컨테이너 설명 | 9-3 | ⬜ |
| 13 | 포트 매핑 이유 + 네임스페이스 | 9-4 | ⬜ |
| 14 | 절대/상대 경로 + 선택 기준 | 9-1 | ⬜ |
| 15 | rwx 비트와 755 해석 | 9-2 | ⬜ |
| 16 | 포트 충돌 진단 순서 | 6-1 | ⬜ |
| 17 | 바인드 vs 볼륨 + 백업 | 9-5, 7 | ⬜ |
| 18 | 트러블슈팅에 실제 로그 첨부 | 10 | ⬜ |
