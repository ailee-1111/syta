#!/bin/bash
set -e

SERVICE_FILE="/etc/systemd/system/bastion_creator.service"

echo "========================================================"
echo "⚙️ 3. Systemd 서비스를 등록하고 실행합니다..."
echo "========================================================"

# 1. Systemd 서비스 파일 생성
echo "📝 서비스 파일을 생성합니다: ${SERVICE_FILE}"
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Flask Bastion Creator Web UI
After=network.target

[Service]
User=root
# app.py가 있는 실제 경로로 지정해야 합니다.
WorkingDirectory=/var/www/html/bastion
# python3와 app.py의 절대 경로를 사용합니다.
ExecStart=/usr/bin/python3 /var/www/html/bastion/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "✅ 서비스 파일 생성 완료."

# 2. 서비스 활성화 및 시작
echo "🔄 Systemd 데몬을 리로드합니다."
sudo systemctl daemon-reload

echo "🚀 서비스를 활성화하고 시작합니다..."
sudo systemctl enable bastion_creator.service
sudo systemctl start bastion_creator.service

echo ""
echo "🎉 모든 설정이 완료되었습니다! 서비스 상태를 확인합니다:"
echo "--------------------------------------------------------"
sudo systemctl status bastion_creator.service --no-pager
echo "--------------------------------------------------------"
echo "웹 브라우저에서 http://<RHEL9_호스트_IP>:5011 으로 접속하세요."
