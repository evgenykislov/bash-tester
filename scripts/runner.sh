#!/bin/bash

# Скрипт для запуска одного теста
# Аргументы:
# $1 файл с тестовым скриптом
# Параметры:
# BTEST_DATA_FILE имя файла для возврата имени теста

set +e

BTEST_TEST_NAME=$(basename $1)
BTEST_TEST_RES=0
BTEST_TEST_START_TIME=$(date +%s%3N)

if [[ ${BTEST_DATA_FILE} == "" ]]; then
  echo "BASH TESTER ERROR: Empty data file"
  exit 1
fi

# Подключаем сам тестовый скрипт
source $1

echo "NAME=${BTEST_TEST_NAME}" > ${BTEST_DATA_FILE}

echo "[ RUN      ] ${BTEST_TEST_NAME}"

if [[ $(type -t setup) == "function" ]]; then
  setup
  BTEST_TEST_RES=$?
  if [[ ${BTEST_TEST_RES} != 0 ]]; then
    echo "  SetUp failed"
  fi
fi

if [[ ${BTEST_TEST_RES} == 0 ]]; then
  test
  BTEST_TEST_RES=$?
  if [[ ${BTEST_TEST_RES} != 0 ]]; then
    echo "  Test failed"
  fi
fi

if [[ $(type -t teardown) == "function" ]]; then
  teardown
  BTEST_TEAR_RES=$?
  if [[ ${BTEST_TEAR_RES} != 0 ]]; then
    echo "  TearDown failed"
    if [[ ${BTEST_TEST_RES} == 0 ]]; then
      BTEST_TEST_RES=${BTEST_TEAR_RES}
    fi
  fi
fi


BTEST_TEST_FINISH_TIME=$(date +%s%3N)
BTEST_TEST_DURATION=$((BTEST_TEST_FINISH_TIME - BTEST_TEST_START_TIME))
if [[ ${BTEST_TEST_RES} == 0 ]]; then
  echo "[       OK ] ${BTEST_TEST_NAME} (${BTEST_TEST_DURATION} ms)"
else
  echo "[   FAILED ] ${BTEST_TEST_NAME} (${BTEST_TEST_DURATION} ms)"
fi

exit ${BTEST_TEST_RES}
