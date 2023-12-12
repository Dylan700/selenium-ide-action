<div align="center">
<h1>Selenium IDE Website Tester</h1>
</div>

<hr>

This action runs end-to-end tests generated from [Selenium IDE](https://www.selenium.dev/selenium-ide/) and generates a report based on the results. Failed tests will have screenshots uploaded as artifacts.

Currently, tests are run in the Chrome browser only. However, I am planning on eventually adding other browsers in the future. Contributions are also welcome!
</div>

## Table of Contents
1. [How To Use](#How-To-Use)
1. [Inputs](#Inputs)
1. [Examples](#Examples)
1. [Quirks](#Quirks)
1. [Contributions](#Contributions)

## How To Use

1. Download Selenium IDE extension for either [Chrome](https://chrome.google.com/webstore/detail/selenium-ide/mooikfkahbdckldjjndioackbalphokd) or [Firefox](https://addons.mozilla.org/en-GB/firefox/addon/selenium-ide/)

2. Create a new project and add your tests using the extension.

3. Export the file in the `.side` format and save it anywhere in your repository.

4. Add one of the [example snippets](#Examples) as a starting point and you're good to go! 

## Inputs

| Input | Required | Description | 
| -- | -- | -- |
| url | false | The Base URL to use when running the tests. Defaults to the url in the project. |

## Examples

### Typical Setup

```yaml
name: Run Website E2E Tests
on: [push, pull_request]
jobs:
  build:
    permissions:
      statuses: write
      checks: write
      contents: write
      pull-requests: write
      actions: write
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Run Website E2E Tests
      uses: Dylan700/selenium-ide-action@latest 
```

## Testing on Development URL

```yaml
name: Run Website E2E Tests
on: [push, pull_request]
jobs:
  build:
    permissions:
      statuses: write
      checks: write
      contents: write
      pull-requests: write
      actions: write
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Run Website E2E Tests
      uses: Dylan700/selenium-ide-action@latest 
      with: 
        url: http://development.mysite.com
```

## Quirks

The nature of automated browser testing can be flaky. Please be aware that tests may fail due to services such as Cloudflare blocking the requests or issues with loading times etc.

> [!WARNING]
> Make sure your workflow file includes permissions as shown in the [example file](#Examples). Not including these permissions will cause the report generation to fail.

## Contributions
Contributions are welcome! If you have something to add or fix, just make a pull request to be reviewed. I can also point you in the right direction if you need assistance.

If you would like to run the main dockerfile locally for testing, just execute the `run.sh` file. Don't forget to also include a `.side` file to be discovered!
