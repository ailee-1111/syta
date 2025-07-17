#!/bin/bash
set -e

echo "========================================================"
echo "🚀 1. RHEL 9 호스트 서버 초기 설정을 시작합니다..."
echo "========================================================"

# 1. 필수 패키지 설치
echo "📦 필수 패키지를 설치합니다: KVM, Web Server, Python, Flask..."
sudo dnf install -y qemu-kvm libvirt libvirt-client virt-install \
                    httpd httpd-tools \
                    python3 python3-pip \
                    ansible-core git wget policycoreutils-python-utils

# 2. Python Flask 설치
echo "🐍 Flask 웹 프레임워크를 설치합니다..."
sudo pip3 install Flask

# 3. 서비스 활성화 (libvirt, httpd)
echo "⚙️ libvirt 및 httpd 서비스를 활성화하고 시작합니다..."
sudo systemctl enable --now libvirtd
sudo systemctl enable --now httpd

# 4. 방화벽 설정
echo "🔥 방화벽에 http(80), ssh(22), webapp(5000) 포트를 영구적으로 추가합니다..."
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=5000/tcp # Flask App Port
sudo firewall-cmd --reload

# 5. Bastion 앱 및 Kickstart 관련 디렉토리 생성
echo "📁 웹 서버 및 애플리케이션 관련 디렉토리를 생성합니다..."
sudo mkdir -p /var/www/html/bastion/templates
sudo mkdir -p /var/www/html/kickstart
sudo mkdir -p /var/www/html/rhel9.6

# 6. SELinux 컨텍스트 설정 (매우 중요)
echo "🛡️ SELinux 컨텍스트를 설정하여 파일 접근을 허용합니다..."
# ISO 마운트 경로
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html/rhel9.6(/.*)?" || true
sudo restorecon -Rv /var/www/html/rhel9.6
# Kickstart 파일 생성/읽기 경로
sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/kickstart(/.*)?" || true
sudo restorecon -Rv /var/www/html/kickstart

echo "✅ 호스트 설정이 완료되었습니다. 다음으로 '2_deploy_app.sh'를 실행하세요."
