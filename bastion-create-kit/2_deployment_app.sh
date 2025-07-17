#!/bin/bash
set -e

echo "========================================================"
echo "🚚 2. 웹 애플리케이션 파일을 배포합니다..."
echo "========================================================"

APP_SOURCE="./app.py"
TEMPLATE_SOURCE="./index.html"

APP_DEST="/var/www/html/bastion/app.py"
TEMPLATE_DEST="/var/www/html/bastion/templates/index.html"

# 1. 소스 파일 존재 여부 확인
if [ ! -f "$APP_SOURCE" ]; then
    echo "❌ 오류: 현재 디렉토리에 'app.py' 파일이 없습니다."
    exit 1
fi

if [ ! -f "$TEMPLATE_SOURCE" ]; then
    echo "❌ 오류: './templates' 디렉토리에 'index.html' 파일이 없습니다."
    exit 1
fi

# 2. 파일 복사
echo " 'app.py' -> '${APP_DEST}'"
sudo cp "$APP_SOURCE" "$APP_DEST"

echo " 'templates/index.html' -> '${TEMPLATE_DEST}'"
sudo cp "$TEMPLATE_SOURCE" "$TEMPLATE_DEST"

echo "✅ 파일 배포가 완료되었습니다. 다음으로 '3_register_service.sh'를 실행하세요."
