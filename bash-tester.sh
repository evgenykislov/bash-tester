#!/bin/bash

# Основной скрипт запуска тестов

set +e

# Маска для поиска скриптов с тестами
TEST_MASK="test_*.sh"
# Директория, в которой находится сам скрипт
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Скрипт-раннер для запуска отдельного теста
RUNNER="${SCRIPT_DIR}/scripts/runner.sh"
# Уникальный файл для обмена данными
DATA_FILE=$(mktemp)



# Вывести справку / помощь. Без аргументов
function PrintHelp() {
  echo "bash-tester is test framework, based on bash scripts. Evgeny Kislov, 2026"
  echo "Usage:"
  echo "  bash-tester.sh test-folder"
  echo "    test-folder - directory with test scripts"
  echo "Test scripts should be in test-folder or subfolders. Test script should has name like test_*.sh"
  echo ""
}


# Запустить тестирование в указанной папке
# Аргументы:
# $1 папка со скриптами для тестирования
function DoTests() {
  if [[ -d "$1" ]]; then
    pushd "$1" > /dev/null
    # Перешли в папку с тестами
    find . -type f -name "${TEST_MASK}" | while IFS= read -r line; do
      # Запускаем все скрипты по-очереди, в отдельном процессе
      ${RUNNER} ${line} ${DATA_FILE}
      RES=$?
    done
    popd > /dev/null
  else
    echo "Directory '$1' doesn't exist ... skip it"
  fi
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
