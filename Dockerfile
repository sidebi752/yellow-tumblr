# 기존 베이스: nginx:alpine (공식 NGINX 웹 서버 이미지, alpine = 아주 가벼운 리눅스)
# 방식 (A): 웹 서버 베이스 이미지 + 정적 콘텐츠/설정만 교체
FROM nginx:alpine

# 커스텀 포인트 1) 메타데이터 라벨: 이미지가 무엇인지 표시 (관리/검색용)
LABEL org.opencontainers.image.title="my-custom-nginx"
LABEL org.opencontainers.image.description="Codyssey 입학연수 1 - custom nginx web server"

# 커스텀 포인트 2) 환경변수: 화면에 표시할 실행 모드 (설정과 코드의 분리)
ENV APP_ENV=dev

# 커스텀 포인트 3) 정적 콘텐츠 교체: 기본 nginx 페이지 → 내가 만든 app/index.html
COPY app/ /usr/share/nginx/html/

# 커스텀 포인트 4) 헬스체크: 컨테이너 안에서 웹 서버가 정상 응답하는지 주기적으로 확인
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
  CMD wget -q -O /dev/null http://localhost/ || exit 1

# 이 컨테이너가 80번 포트를 쓴다는 문서화 (실제 연결은 docker run -p 로 함)
EXPOSE 80
