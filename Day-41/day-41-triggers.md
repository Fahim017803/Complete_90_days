Learn different GitHub Actions triggers and run jobs across multiple environments using matrix builds.

Task 1: Trigger on Pull Request
File: .github/workflows/pr-check.yml
name: PR Check

on:
  pull_request:
    branches:
      - main

jobs:
  pr-check:
    runs-on: ubuntu-latest

    steps:
      - name: Print PR branch
        run: echo "PR check running for branch: ${{ github.head_ref }}"
Result
Created new branch
Pushed commit
Opened Pull Request to main
Workflow ran automatically
Showed on PR page
Task 2: Scheduled Trigger
File: .github/workflows/schedule.yml
name: Scheduled Job

on:
  workflow_dispatch:
  schedule:
    - cron: '0 0 * * *'

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Print Message
        run: echo "Running daily at midnight UTC"
Cron Meaning

0 0 * * * = Runs every day at midnight UTC

Every Monday at 9 AM

0 9 * * 1

Task 3: Manual Trigger
File: .github/workflows/manual.yml
name: Manual Run

on:
  workflow_dispatch:
    inputs:
      environment:
        description: "staging or production"
        required: true
        default: staging

jobs:
  manual-job:
    runs-on: ubuntu-latest

    steps:
      - name: Print Input
        run: echo "Environment ${{ github.event.inputs.environment }}"
Result
Opened Actions tab
Clicked Run workflow
Entered staging

Output:

Environment staging
Task 4: Matrix Builds
File: .github/workflows/matrix.yml
name: Matrix Build

on:
  push:

jobs:
  test:
    name: ${{ matrix.os }} | Python ${{ matrix.python-version }}
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os:
          - ubuntu-latest
          - windows-latest

        python-version:
          - "3.10"
          - "3.11"
          - "3.12"

    steps:
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Show Python Version
        run: python --version
Result

2 Operating Systems × 3 Python Versions = 6 Jobs

Jobs ran in parallel.

Task 5: Exclude & Fail-Fast
Updated Matrix Example
name: Matrix Build

on:
  push:

jobs:
  test:
    name: ${{ matrix.os }} | Python ${{ matrix.python-version }}
    runs-on: ${{ matrix.os }}

    strategy:
      fail-fast: false

      matrix:
        os:
          - ubuntu-latest
          - windows-latest

        python-version:
          - "3.10"
          - "3.11"
          - "3.12"

        exclude:
          - os: windows-latest
            python-version: "3.10"

    steps:
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Show Python Version
        run: python --version
Excluded Combination

windows-latest + Python 3.10

Fail-Fast Meaning

fail-fast: true
If one matrix job fails, GitHub may cancel remaining jobs.

fail-fast: false
If one job fails, all remaining jobs continue.

Key Learnings
pull_request runs on PR events
schedule runs automatically by time
workflow_dispatch runs manually
Matrix runs many jobs together
Exclude removes unwanted combinations
Fail-fast controls cancellation behavior
Final Thoughts

Today I learned how CI/CD pipelines run on:

Pull Requests
Scheduled times
Manual triggers
Multiple operating systems
Multiple Python versions

This is real automation.