import requests
import io
import sys
import zipfile
from bs4 import BeautifulSoup
from mypass import nick_name, password
import shutil


def download_tests(task_id):
    '''
    @param task_id: the task id of the problem
    download the test cases of a specific task
    '''
    LOGIN_URL = "https://cses.fi/login"
    client = requests.session()
    login_page = client.get(LOGIN_URL)
    assert login_page.status_code == 200

    login_soup = BeautifulSoup(login_page.content, "html.parser")
    csrf_token = login_soup.find("input", {"name": "csrf_token"})["value"]
    payload = {"csrf_token": csrf_token, "nick": nick_name, "pass": password}
    login_result = client.post(LOGIN_URL, data=payload)
    assert login_result.status_code == 200

    TEST_URL = f"https://cses.fi/problemset/tests/{task_id}"
    test_page = client.get(TEST_URL)
    test_soup = BeautifulSoup(test_page.content, "html.parser")
    csrf_token = test_soup.find("input", {"name": "csrf_token"})["value"]
    title=test_soup.find('h1').text.replace(" ","_")
    payload = {"csrf_token": csrf_token, "download": "true"}
    res = client.post(TEST_URL, data=payload)
    assert res.status_code == 200

    zip_data = io.BytesIO(res.content)
    extract_dir = f"problems/{task_id}"
    with zipfile.ZipFile(zip_data, "r") as zip_ref:
        zip_ref.extractall(extract_dir)
    shutil.copy("./solutions/src/template.zig",f"./solutions/src/{task_id}_{title}.zig")


if __name__ == "__main__":
    assert len(sys.argv) == 2
    download_tests(sys.argv[1])
