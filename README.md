# Introduction

This repository contains example test suites for demonstration purposes. The project uses Robot Framework together with custom libraries written in Python.
Suites utilize Gherkin notation (https://cucumber.io/docs/gherkin/reference/). Gherkin makes the business logic apparent in the test case level and forces to write understandable tests. Anyone, even with no technical understanding of robot framework or testing, should be able to understand what is being tested and what are the logical steps to be able to assert if something works as intended or not.

## yahoo.robot suite

Demonstrates web application testing  utilizing SeleniumLibrary.
Expects chromedriver.exe in the project root.

## api.robot suite

Demonstrates API testing using Restful-Booker test API as the target (https://restful-booker.herokuapp.com).

## How to run

For all the commands listed below, powershell is assumed.

Required python packages are in listed in requirements.txt.
Install them by running
```sh
pip install -r requirements.txt
```
Or, use python virtual environment (https://docs.python.org/3/tutorial/venv.html):
```sh
virtualenv venv; .\venv\Scripts\activate; pip install -r requirements.txt
```
To run the suites, run:
```sh
robot .\yahoo.robot
# or
robot .\api.robot
```
To get out of the python virtual environment, run:
```sh
deactivate
```

## Running in Docker
There are two compose files, one for each suite. They use the same image that has all the required tools for running the tests.
Run api tests with docker compose:
```sh
docker compose -f .\Docker\docker-compose-api.yml up --build
```
Run front-end tests with docker compose:
```sh
docker compose -f .\Docker\docker-compose-selenium.yml up --build
```