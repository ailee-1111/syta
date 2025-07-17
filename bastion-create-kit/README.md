Bastion VM 생성 자동화 도구 (Flask 버전)
이 도구는 RHEL 9.x 호스트에서 Bastion VM을 웹 UI를 통해 생성하도록 돕습니다.








🚀 전체 설치 과정
사전 준비:
이 저장소의 파일들을 RHEL 9 호스트의 특정 디렉토리(예: /home/user/bastion-create-kit)에 준비합니다.

# 1. git이 설치되어 있지 않다면 먼저 설치합니다.
sudo dnf install git -y

# 2. git clone 명령어로 저장소의 모든 파일을 다운로드합니다.
git clone https://github.com/ailee-1111/syta/

# 3. 다운로드된 디렉토리로 이동합니다.
cd syta/bastion-create-kit

# 4. README.md 파일의 안내에 따라 스크립트를 실행합니다.
./1_setup_host.sh
./2_deploy_app.sh
./3_register_service.sh




bastion-creator-kit/
├── 1_setup_host.sh
├── 2_deploy_app.sh
├── 3_register_service.sh
├── app.py
└── index.html


1단계: 호스트 서버 초기 설정
필요한 패키지를 설치하고 방화벽, 디렉토리 등 기본 환경을 구성합니다. (최초 1회 실행)

# 스크립트에 실행 권한 부여
chmod +x 1_setup_host.sh

# 스크립트 실행
./1_setup_host.sh

2단계: 웹 애플리케이션 배포
app.py 와 index.html 파일을 서비스 운영 경로로 복사합니다.

# 스크립트에 실행 권한 부여
chmod +x 2_deploy_app.sh

# 스크립트 실행
./2_deploy_app.sh

3단계: Systemd 서비스 등록 및 실행
웹 애플리케이션이 서버 부팅 시 자동으로 실행되도록 systemd 서비스로 등록하고 즉시 시작합니다.

# 스크립트에 실행 권한 부여
chmod +x 3_register_service.sh

# 스크립트 실행
./3_register_service.sh

설치 확인
모든 과정이 끝나면 웹 브라우저를 열고 아래 주소로 접속하여 웹 UI가 정상적으로 나타나는지 확인합니다.

http://<RHEL9_호스트_IP>:5011
