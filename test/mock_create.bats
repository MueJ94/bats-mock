#!/usr/bin/env bats

set -euo pipefail

load ../src/bats-mock

@test 'mock_create creates a program' {
  run mock_create TestMock
  [[ "${status}" -eq 0 ]]
  [[ -f ${BATS_TEST_TMPDIR}/bats-mocks/TestMock ]]
  mock_unset
}

@test 'mock_create extends PATH variable to contain mock' {
  mock_create TestMock
  type -P TestMock
}

