#!/bin/sh -l

# create a function that recieves a file as input
test_selenium () {
    echo "################### Running Selenium Tests ###################"
    echo "Running tests for '$1' using '$2'"
    echo "##############################################################"
    echo "\n"

    FILE_NAME=$(basename $1)

    # run tests for each browser
    echo "Running tests for Chrome"
    JEST_JUNIT_OUTPUT_DIR=$GITHUB_WORKSPACE/reports JEST_JUNIT_OUTPUT_NAME=selenium-chrome-tests-report-$FILE_NAME.xml selenium-side-runner -c "browserName=chrome goog:chromeOptions.args=[headless, no-sandbox, remote-debugging-port=9222, disable-web-security, disable-features=IsolateOrigins,site-per-process]" -z $GITHUB_WORKSPACE/screenshots --retries 1 --output-directory $GITHUB_WORKSPACE/reports -j " --reporters=jest-junit  --reporters=default " --timeout 5000 --base-url $2 $1

    echo "Running tests for Firefox"
    MOZ_HEADLESS=1 JEST_JUNIT_OUTPUT_DIR=$GITHUB_WORKSPACE/reports JEST_JUNIT_OUTPUT_NAME=selenium-firefox-tests-report-$FILE_NAME.xml selenium-side-runner -c "browserName=firefox moz:firefoxOptions.args=[-headless, -safe-mode]" -z $GITHUB_WORKSPACE/screenshots --retries 1 --output-directory $GITHUB_WORKSPACE/reports -j " --reporters=jest-junit  --reporters=default " --timeout 5000 --debug --base-url $2 $1

    echo "######## Tests complete for '$1' ########\n"
}

for file in $(find $GITHUB_WORKSPACE -name '*.side'); do
    # extract base url from the file and use that if $BASE_URL is empty
    DEFAULT_URL=$(cat $file | jq -r '.url')
    NEW_BASE_URL=${BASE_URL:-$DEFAULT_URL}
    test_selenium $file $NEW_BASE_URL
done