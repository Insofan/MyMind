#!/usr/bin/env python
#coding=utf-8

import requests
from requests import ConnectionError

headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36'
}
res = requests.get('http://bj.xiaozhu.com/', headers=headers)
try:
    print(res)
except ConnectionError:
    print('拒绝连接')
