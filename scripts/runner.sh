#!/bin/bash

# Скрипт для запуска одного теста
# Аргументы
# $1 файл с тевстовым скриптом
# $2 файл для выдачи данных в базовый скрипт
#

set +e

TEST_NAME=$(basename $1)
TEST_RES=0

# Подключаем сам тестовый скрипт
source $1

echo "Test '${TEST_NAME}' running ..."

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

if [[ ${TEST_RES} == 0 ]]; then
  echo "  Tesk OK"
fi

exit ${TEST_RES}
