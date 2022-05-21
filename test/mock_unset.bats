#!/usr/bin/env bats

set -euo pipefail

load ../src/bats-mock

setup(){
  mock="TestMock"
  mock_create "${mock}"
}

@test 'mock_unset makes mock no longer callable' {
  run mock_unset
  [[ "${status}" -eq 0 ]]
  run type -P TestMock
  [[ "${status}" -eq 1 ]]
}

@test 'mock_unset detetes mock directory' {
  run mock_unset
  [[ "${status}" -eq 0 ]]
  [[ ! -d ${BATS_TEST_TMPDIR}/bats-mocks/ ]]
}

@test 'mock_unset removes mock directory from PATH' {
  mock_unset
  [[ "${PATH%%:*}" != "${BATS_TEST_TMPDIR}/bats-mocks" ]]
  if echo "$PATH" | grep -q "${BATS_TEST_TMPDIR}/bats-mocks"; then
     return 1
  else
     return 0
  fi
}

