# A beautiful Just collection to make lives easier!

version := "0.0.0"

# Unit tests
[group('test')]
unit-test package="all" testfile="all":
    @echo "Listing unit tests for package: {{ package }} with testfile: {{ testfile }}"

# System tests
[group('test')]
system-test package="*" test-pattern="":
    @echo "Running system tests for package: {{ package }} with test pattern: {{ test-pattern }}"
