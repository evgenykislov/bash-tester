#!/bin/bash

# Основной скрипт запуска тестов


# Вывести справку / помощь. Без аргументов
function PrintHelp() {
  echo "bash-tester is test framework, based on bash scripts"
  echo "Usage:"
  echo "  bash-tester.sh test-folder"
  echo "    test-folder - directory with test scripts"
  echo "Test scripts should be in test-folder and have mask test_*.sh"
  echo ""
}


# Запустить тестирование в указанной папке
# Аргументы:
# $1 папка со скриптами для тестирования
function DoTests() {
  echo "Testing $1 ..."
}




# ---------------------
# main
# ---------------------

if [[ "$#" -eq 0 ]]; then
  PrintHelp
  exit 0
fi

# При наличии аргументов делаем разбор и выполняем тесты
while [[ "$#" -gt 0 ]]; do
  DoTests "$1"
  shift
done
