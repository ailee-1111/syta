#!/bin/bash
set -e

echo "🚀 RHEL 9 호스트 서버 초기 설정을 시작합니다..."

# 1. 필수 패키지 설치
echo "📦 필수 패키지를 설치합니다: KVM, Web Server, Python, Ansible..."
sudo dnf install -y qemu-kvm libvirt libvirt-client virt-install \
                    httpd httpd-tools \
                    python3 python3-pip \
                    ansible-core git wget

# 2. Python Django 설치
echo "🐍 Django 웹 프레임워크를 설치합니다..."
sudo pip3 install Django

# 3. 서비스 활성화 (libvirt, httpd)
echo "⚙️ libvirt 및 httpd 서비스를 활성화하고 시작합니다..."
sudo systemctl enable --now libvirtd
sudo systemctl enable --now httpd

# 4. 방화벽 설정
echo "🔥 방화벽에 http(80), ssh(22), webapp(5000) 포트를 영구적으로 추가합니다..."
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=5000/tcp # Django App Port
sudo firewall-cmd --reload

# 5. 웹 서버 및 Kickstart 디렉토리 생성
echo "📁 웹 서버 및 Kickstart 관련 디렉토리를 생성합니다..."
sudo mkdir -p /var/www/html/rhel9.6
sudo mkdir -p /var/www/html/kickstart

# 웹 서버가 Kickstart 파일을 읽을 수 있도록 권한 설정
sudo chown -R apache:apache /var/www/html/kickstart

# SELinux 컨텍스트 설정 (중요)
echo "🛡️ SELinux 컨텍스트를 설정합니다..."
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html/rhel9.6(/.*)?"
sudo restorecon -Rv /var/www/html/rhel9.6
sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/kickstart(/.*)?"
sudo restorecon -Rv /var/www/html/kickstart


echo "✅ 모든 설정이 완료되었습니다. '2_run_webapp.sh' 스크립트를 실행하여 웹 UI를 시작하세요."
