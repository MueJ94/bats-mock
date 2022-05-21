#!/usr/bin/env bats

load ../src/bats-mock

setup(){
  mock="TestMock"
  mock_create "${mock}"
}
teardown(){
  mock_unset
}
@test 'mock_get_call_num requires mock to be specified' {
  run mock_get_call_num
  [[ "${status}" -eq 1 ]]
  [[ "${output}" =~ 'Mock must be specified' ]]
}

@test 'mock_get_call_num outputs the number of calls' {
  run mock_get_call_num "${mock}"
  [[ "${status}" -eq 0 ]]
  [[ "${output}" -eq 0 ]]
  "${mock}"
  run mock_get_call_num "${mock}"
  [[ "${status}" -eq 0 ]]
  [[ "${output}" -eq 1 ]]
  "${mock}"
  run mock_get_call_num "${mock}"
  [[ "${status}" -eq 0 ]]
  [[ "${output}" -eq 2 ]]
}
