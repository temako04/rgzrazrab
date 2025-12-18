#!/bin/bash

# Простой скрипт для changelog

echo "Начинаю создание changelog..."

# Получаем версию из аргумента или используем дату
if [ -z "$1" ]; then
    VERSION="v1.0.$(date +%Y%m%d)"
    echo "Версия не указана, использую: $VERSION"
else
    VERSION=$1
fi

DATE=$(date +"%Y-%m-%d")

echo "Версия: $VERSION"
echo "Дата: $DATE"

# Создаем заголовок для новой версии
echo "## [$VERSION] - $DATE" > temp_changelog.txt
echo "" >> temp_changelog.txt

# Получаем коммиты
echo "Получаю коммиты..."
git log --oneline | head -10 > commits.txt

# Добавляем коммиты в changelog
while read line; do
    HASH=$(echo $line | awk '{print $1}')
    MESSAGE=$(echo $line | cut -d' ' -f2-)
    SHORT_HASH=${HASH:0:7}
    echo "  - $MESSAGE [$SHORT_HASH]" >> temp_changelog.txt
done < commits.txt

echo "" >> temp_changelog.txt

# Если changelog уже есть, добавляем новую версию в начало
if [ -f "CHANGELOG.md" ]; then
    echo "Обновляю существующий CHANGELOG.md..."
    cat temp_changelog.txt CHANGELOG.md > CHANGELOG_new.md
    mv CHANGELOG_new.md CHANGELOG.md
else
    echo "Создаю новый CHANGELOG.md..."
    echo "# Changelog" > CHANGELOG.md
    echo "" >> CHANGELOG.md
    cat temp_changelog.txt >> CHANGELOG.md
fi

# Создаем git тег
echo "Создаю тег $VERSION..."
git tag $VERSION

# Удаляем временные файлы
rm temp_changelog.txt commits.txt

echo "Готово! Changelog создан."
echo "Создан тег: $VERSION"