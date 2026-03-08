#!/bin/bash

# Test with usage of setup/teardown functions
# Uses parameter FIXTURE_PARAMETER for setup function

BTEST_TEST_NAME="Test with fixture"

FIXTURE_PARAMETER="Fixture parameter"

# Add setup and teardown external functions
source ./simple_fixture.sh

test() {
  echo "Test after SetUp"
  return 0
}
