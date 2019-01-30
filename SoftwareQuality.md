# Software Quality

## Definition of Done

- Should be kept lean and simple
  - Determine whether a test requires common sense; if not, strife to automate the test
  - The result of multiple automated tests should be compacted into binary indicators if possible
  - Include the condition to assure for each indicator that there is no detected issue in the DoD

## Test Automation

### Unit Tests

- Agree on criteria for the the derivation of unit test cases
- Agree on a common style for authoring unit tests
- Agree to check the criteria and the style during code review
- Agree on a moderate threshold for the code coverage of unti tests
- Agree on the tool that will provide the authoritative code coverage measurement
- Establish an alert
- Keep in mind that code coverage is only an indicator that there might be a qulity issue; it does not replace the use of common sense during review

Resources:
- [Unit Test Fetish](http://250bpm.com/blog:40)
- [Lean Testing or Why Unit Tests are Worse than You Think](https://blog.usejournal.com/lean-testing-or-why-unit-tests-are-worse-than-you-think-b6500139a009)

### Integration Tests

- Consider creating integration tests for accessing the infrastructure
- Consider creating integration tests for the most important workflows

### End-To-End Test