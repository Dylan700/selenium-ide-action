#!/bin/sh -l

# create a function that recieves a file as input
test_selenium () {
    echo "################### Running Selenium Tests ###################"
    echo "Running tests for '$1'"
    echo "##############################################################"
    echo "\n"

    # run tests for each browser
    echo "Running tests for Chrome"
    JEST_JUNIT_OUTPUT_DIR=$GITHUB_WORKSPACE/reports JEST_JUNIT_OUTPUT_NAME=selenium-chrome-tests-report.xml selenium-side-runner -c "browserName=chrome goog:chromeOptions.args=[headless, no-sandbox, remote-debugging-port=9222, disable-web-security, disable-features=IsolateOrigins,site-per-process]" -z $GITHUB_WORKSPACE/screenshots --retries 1 --output-directory $GITHUB_WORKSPACE/reports -j " --reporters=jest-junit  --reporters=default " --timeout 5000 $1

    echo "######## Tests complete for '$1' ########\n"
}

for file in $(find $GITHUB_WORKSPACE -name '*.side'); do
    test_selenium $file
done