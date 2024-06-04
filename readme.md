Learning Zig by solving algorithm using CSES Problem Set
I know this website from https://matklad.github.io/2023/08/06/fantastic-learning-resources.html
And find it support test as seperate file, So I can just download and test it locally with Zig.
# Prerequisites
You need install python3 in your computer.
Then ensure  `requests` and `beautifulsoup` are installed.
```sh
pip install requests
pip install beautifulsoup4
```

## Creating a mypass.py
The is using for login in https://cese.fi
There should be 2 variables in the file
```python3
nick_name = "xxxx" #your user name 
password = "xxx" #your password
```

# How to use
## Download tests for on problem
run:

`python download_testcasees.py problem_id`
You can get the problem from the url,
For example:
The url: https://cses.fi/problemset/task/1068 is the link for the **Weird Algorithm**
the problem id is 1068
So, you can run:
`python download_testcasees.py 1068` to download the tests to local

## Write Code
Copy `template.zig` to the `problem_id.zig`
For example, `1068.zig`
Then complete the slove() function,
The arg is the input, 
You should write the answer to the standard output, because I need capture it from `stdout` then compare it from expected output.
So you need using `std.io.getStdOut().writer()` to write result,
because the `std.debug.print()` is write to `stderr` out.


## Run the test
`python run_test.py problem_id`
For example,
`python run_test.py 1068` to test the all the testcases in the file.
If all test passed you can see the result in the Terminal:
```sh
> python run_test.py 1083
Task 1/14 passed!
Task 2/14 passed!
Task 3/14 passed!
Task 4/14 passed!
Task 5/14 passed!
Task 6/14 passed!
Task 7/14 passed!
Task 8/14 passed!
Task 9/14 passed!
Task 10/14 passed!
Task 11/14 passed!
Task 12/14 passed!
Task 13/14 passed!
Task 14/14 passed!
```
