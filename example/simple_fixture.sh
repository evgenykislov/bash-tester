#!/bin/bash

# Simple fixture
# Parameters:
# FIXTURE_PARAMETER

setup() {
  echo "SetUp function. Parameter '${FIXTURE_PARAMETER}'"
}

teardown() {
  echo "Finalization by TearDown function"
}
