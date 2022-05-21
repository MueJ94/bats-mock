#!/usr/bin/env bats

set -euo pipefail

load ../src/bats-mock

setup(){
  mock="TestMock"
}

teardown(){
  mock_unset
}

@test 'mock_create creates a program' {
  run mock_create TestMock
  [[ "${status}" -eq 0 ]]
  [[ -f ${BATS_TEST_TMPDIR}/bats-mocks/TestMock ]]
}

@test 'mock_create extends PATH variable to contain mock' {
  mock_create TestMock
  type -P TestMock
  [[ "${PATH%%:*}" == "${BATS_TEST_TMPDIR}/bats-mocks" ]]
}

