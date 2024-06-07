#!/usr/bin/env python3
import subprocess
import os
from pathlib import Path
import sys


def test_all_and_compare(task_id: str):
    problem_test_dir = Path("problems") / task_id
    test_nums = set(int(num.split(".")[0]) for num in os.listdir(problem_test_dir))
    test_nums = sorted(list(test_nums))
    assert test_nums[-1] == len(test_nums), "input files count error"
    # for num in test_nums:
    # with open()
    for num in test_nums:
        input = None
        output = None
        with open(problem_test_dir / f"{num}.in", "r") as f:
            input = f.read()
        assert input is not None
        input_path = str(problem_test_dir / f"{num}.in")

        with open(problem_test_dir / f"{num}.out", "r") as f:
            output = f.read()
        assert output is not None
        run_test(task_id,input_path, output)

        print(f"Task {num}/{len(test_nums)} passed!")


def run_test(task_id:str,input_path: str, out: str):
    zig_file_name=next(f for f in os.listdir("./solutions/src") if f.startswith(task_id))
    result = subprocess.run(
        ["zig", "run", f"./solutions/src/{zig_file_name}", "--", input_path],
        capture_output=True,
        text=True,
    )
    if result.stdout != out:
        print(f"{result.stdout=}, {out=}")
        raise AssertionError("output not equal!")
def run_task(task_id:str,test_id:str):
    zig_file_name=next(f for f in os.listdir("./solutions/src") if f.startswith(task_id))
    subprocess.run(
        ["zig", "run", f"./solutions/src/{zig_file_name}", "--", f"problems/{task_id}/{test_id}.in"],
    )



if __name__ == "__main__":
    if len(sys.argv) == 2:
        test_all_and_compare(sys.argv[1])
    elif len(sys.argv)==3:
        run_task(sys.argv[1],sys.argv[2])
    else:
        raise AssertionError("Error command argument number")

