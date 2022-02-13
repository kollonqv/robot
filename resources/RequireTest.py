"""
This class is a cool way to require a previous test to pass before running a test: https://stackoverflow.com/a/25079032
More on listeners: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#library-acting-as-listener
"""

from robot.libraries.BuiltIn import BuiltIn

class RequireTest(object):
    
    ROBOT_LISTENER_API_VERSION = 2
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self._test_status = {}

    def require_test_case(self, name):
        if (name not in self._test_status):
            BuiltIn().fail("required test case can't be found: '%s'" % name)

        if (self._test_status[name] != "PASS"):
            BuiltIn().skip("required test case failed: '%s'" % name)

        return True

    def _end_test(self, name, attrs):
        self._test_status[name] = attrs["status"]