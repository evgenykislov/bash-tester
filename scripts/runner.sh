#!/bin/bash

# Скрипт для запуска одного теста
# Аргументы
# $1 файл с тевстовым скриптом
# $2 файл для выдачи данных в базовый скрипт
#

set +e

TEST_NAME=$(basename $1)
TEST_RES=0
TEST_START_TIME=$(date +%s%3N)

# Подключаем сам тестовый скрипт
source $1

echo "[ RUN      ] ${TEST_NAME}"

if [[ $(type -t setup) == "function" ]]; then
  setup
  TEST_RES=$?
  if [[ ${TEST_RES} != 0 ]]; then
    echo "  SetUp failed"
  fi
fi

if [[ ${TEST_RES} == 0 ]]; then
  test
  TEST_RES=$?
  if [[ ${TEST_RES} != 0 ]]; then
    echo "  Test failed"
  fi
fi

if [[ $(type -t teardown) == "function" ]]; then
  teardown
  TEST_RES=$?
  if [[ ${TEST_RES} != 0 ]]; then
    echo "  TearDwon failed"
  fi
fi


TEST_FINISH_TIME=$(date +%s%3N)
TEST_DURATION=$((TEST_FINISH_TIME - TEST_START_TIME))
if [[ ${TEST_RES} == 0 ]]; then
  echo "[       OK ] ${TEST_NAME} (${TEST_DURATION} ms)"
fi

exit ${TEST_RES}
