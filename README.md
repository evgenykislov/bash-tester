# bash-tester
A simple test framework based on bash scripts

## Example of usage
Go to the example folder and run the command
../bash-tester.sh .

## Framework description
This section describes the rules for naming files and variables in scripts. A test template is described below.

### File naming
Bash scripts are used for testing. The file name must begin with the prefix **test_** and have the extension **.sh**.
Using this name template, the framework searches for test scripts and executes them. The search is performed in a user-defined folder and in subfolders.
Each test script is run from its own directory (as the current directory).  
Only one test can be defined in single file. Do not combine multiple tests in one file.  
The test script can use other auxiliary scripts. Do not use the **test_** prefix to name auxiliary scripts.  

### Variables in scripts
The framework uses its own internal variables, they start with the prefix **BTEST_**. Please do not create custom variables with this prefix.

### Test script scheme
For the test, you can set a human-readable name in the BTEST_TEST_NAME variable, like this:
BTEST_TEST_NAME="Single-function test"

Main testing function: **test**
No arguments are passed to the function. However, you can set custom variables in the script and use them in functions.
