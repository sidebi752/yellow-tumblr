# 코디세이 입학연수 1 — 개발 워크스테이션 구축

> 📝 **작성 안내 (제출 전에 이 박스는 지우세요)**
> - `<!-- TODO -->` 와 `⬜` 표시를 전부 채우면 완성입니다.
> - 명령 + 출력은 `logs/` 폴더의 로그에서 **필요한 부분을 복사해 코드블록(```)에 붙여 넣으세요.**
> - 스크린샷은 `docs/images/` 에 저장하고 `![설명](docs/images/파일명.png)` 로 넣습니다.
> - 설명 파트(8번)는 힌트를 참고하되 **반드시 내 말로** 다시 쓰세요. 평가자는 "스스로 설명할 수 있는지"를 봅니다.
> - 토큰, 비밀번호, 인증 코드, 개인키는 로그/캡처 어디에도 남기지 마세요 (마스킹).

---

## 0. 프로젝트 개요

<!-- TODO: 미션 목표를 2~3문장으로 요약 -->
이 저장소는 코디세이 입학연수 1 미션의 결과물이다. 터미널(리눅스 CLI), Docker, Git/GitHub로
"재현 가능한 개발 환경"을 직접 구성하고, 모든 수행 결과를 명령어·출력 로그로 검증했다.

## 1. 실행 환경

> 근거 로그: [`logs/00-env.log`](logs/00-env.log)

| 항목 | 값 |
|---|---|
| OS | ⬜ |
| Shell / 터미널 | ⬜ |
| Docker 버전 | ⬜ |
| Git 버전 | ⬜ |
| 에디터 | VSCode ⬜ 버전 |

```text
(logs/00-env.log 내용을 붙여 넣기)
```

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

```text
(logs/01-terminal.log 핵심 부분 붙여 넣기)
```

</details>

> 💡 긴 로그는 이렇게 `<details>`로 접어 두면 문서가 짧고 깔끔해집니다. 다른 항목에도 같은 방식을 써도 됩니다.

### 3-2. 권한 실습

> 스크립트: [`scripts/02-permissions.sh`](scripts/02-permissions.sh) / 로그: [`logs/02-permissions.log`](logs/02-permissions.log)
> 파일 `hello.sh`: 644 → 755 → (go-rx) 변경, 디렉토리 `secret-dir`: 755 → 700 → 755 변경

```text
(변경 전 ls -l / 변경 후 ls -l 비교 부분 붙여 넣기)
```

**관찰한 점:** <!-- TODO: 644일 때 ./hello.sh 가 "Permission denied" 였고 755 후 실행된 것 등 -->

## 4. Docker 점검 / 운영

### 4-1. Docker 설치/데몬 점검

> 스크립트: [`scripts/03-docker-check.sh`](scripts/03-docker-check.sh) / 로그: [`logs/03-docker-check.log`](logs/03-docker-check.log)

```text
$ docker --version
(붙여 넣기)

$ docker info   ← 'Server:' 섹션이 보이게
(붙여 넣기)
```

### 4-2. hello-world

```text
$ docker run --rm hello-world
(붙여 넣기)
```

### 4-3. 이미지/컨테이너 운영

> 로그: `logs/03-docker-check.log`, [`logs/04-container-ops.log`](logs/04-container-ops.log)

```text
$ docker images
$ docker ps -a
$ docker logs ubuntu-keep
$ docker stats --no-stream
(붙여 넣기)
```

### 4-4. ubuntu 컨테이너 실습

> 스크립트: [`scripts/04-container-ops.sh`](scripts/04-container-ops.sh)

**(수동 실습)** 아래를 터미널에서 직접 해보고 화면을 캡처하세요.

```bash
docker run -it --name ubuntu-manual ubuntu bash
# 컨테이너 안에서:  ls  /  echo hi  /  exit
docker ps -a        # exit 후 컨테이너 상태 확인
```

![ubuntu 컨테이너 진입](docs/images/04-ubuntu-interactive.png)

**exec vs attach 관찰 정리:** <!-- TODO: 직접 해보고 내 말로. 힌트는 아래 -->
<!--
 - exec  : 이미 실행 중인 컨테이너 안에서 "새 프로세스"를 하나 더 띄움. 거기서 exit 해도 컨테이너는 계속 살아있음.
 - attach: 컨테이너의 "메인 프로세스" 입출력에 직접 연결. 메인 프로세스가 끝나면(예: bash exit) 컨테이너도 같이 종료될 수 있음.
 - 직접 해보기: docker run -d --name t ubuntu sleep infinity → docker exec -it t bash → exit → docker ps (살아있음)
-->

## 5. Dockerfile 기반 웹 서버 커스텀 이미지

> 파일: [`Dockerfile`](Dockerfile), [`app/index.html`](app/index.html) / 로그: [`logs/05-web-build-run.log`](logs/05-web-build-run.log)

**선택한 방식:** (A) 웹 서버 베이스 이미지(`nginx:alpine`) + 정적 콘텐츠/설정 교체

| 커스텀 포인트 | 목적 |
|---|---|
| `LABEL` | 이미지 이름/설명을 메타데이터로 남겨 관리·검색을 쉽게 함 |
| `ENV APP_ENV=dev` | 실행 모드를 환경변수로 분리(설정과 코드의 분리) |
| `COPY app/ ...` | 기본 nginx 화면을 내가 만든 페이지로 교체 |
| `HEALTHCHECK` | 컨테이너 안에서 웹 서버가 정상 응답하는지 주기적으로 점검 |

<!-- TODO: 위 목적을 내 말로 고쳐 쓰기 -->

**빌드/실행 로그:**

```text
$ docker build -t my-web:1.0 .
(붙여 넣기)

$ docker run -d -p 8080:80 --name my-web-8080 my-web:1.0
(붙여 넣기)
```

## 6. 포트 매핑 접속 증거

`-p <호스트포트>:<컨테이너포트>` 로 2회 실행했다. (8080→80, 8081→80)

```text
$ curl -s http://localhost:8080
(붙여 넣기)
$ curl -s http://localhost:8081
(붙여 넣기)
```

**브라우저 접속 화면 (주소창에 포트가 보이게):**

![localhost:8080](docs/images/06-browser-8080.png)
![localhost:8081](docs/images/06-browser-8081.png)

### 6-1. 포트 충돌 진단 순서

> 재현 로그: `logs/05-web-build-run.log` 의 5~7번 항목

1. 증상: `docker run -p 8080:80 ...` → `port is already allocated` / `address already in use`
2. 누가 쓰나 확인: `docker ps --filter publish=8080` (컨테이너가 쓰는 경우), `lsof -i :8080` (그 외 프로세스)
3. 해소: 컨테이너면 `docker rm -f <이름>`, 프로세스면 종료하거나, **다른 호스트 포트로 매핑**(`-p 8082:80`)
4. 실패한 컨테이너가 `Created` 상태로 남아있으면 `docker rm` 으로 정리

```text
(충돌 에러 메시지와 진단 명령 출력 붙여 넣기)
```

## 7. 바인드 마운트 / 볼륨

> 스크립트: [`scripts/06-volume-bindmount.sh`](scripts/06-volume-bindmount.sh) / 로그: [`logs/06-volume-bindmount.log`](logs/06-volume-bindmount.log)

### 7-1. 바인드 마운트

호스트 폴더를 컨테이너에 직접 연결(`-v <호스트절대경로>:<컨테이너경로>`). 호스트 파일을 고치면 컨테이너에 바로 반영된다.

```text
(변경 전: cat, curl 결과)
(호스트에서 파일 수정)
(변경 후: cat, curl 결과)
```

### 7-2. Docker 볼륨 영속성

```text
$ docker volume create mydata
$ docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
$ docker exec vol-test bash -c 'echo hi-volume > /data/hello.txt && cat /data/hello.txt'
$ docker rm -f vol-test                        ← 컨테이너 삭제
$ docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
$ docker exec vol-test2 cat /data/hello.txt    ← 데이터 유지 확인
(실제 출력 붙여 넣기)
```

## 8. Git 설정 및 GitHub 연동

> 스크립트: [`scripts/07-git-check.sh`](scripts/07-git-check.sh) / 로그: [`logs/07-git-check.log`](logs/07-git-check.log), `logs/07-first-push.log`

```text
$ git config --list
(user.name, user.email, init.defaultBranch 등. 토큰류는 절대 포함 금지)

$ git remote -v
(붙여 넣기)
```

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
