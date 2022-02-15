# Introduction

This repository contains example test suites for demonstration purposes. The project uses Robot Framework together with custom libraries written in Python.
Suites utilize Gherkin notation (https://cucumber.io/docs/gherkin/reference/).

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
