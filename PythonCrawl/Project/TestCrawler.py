#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午11:32
# @Author  : Insomnia
# @Desc    : TODO
# @File    : DoubanTop250.py
# @Software: PyCharm
import requests
from bs4 import BeautifulSoup

headers = utils.Header.headers

if __name__ == '__main__':
    print("Download begin")
    soup = BeautifulSoup(requests.get('http://www.gardensafari.net/english/squirrels.htm', headers=headers))

    for img in soup.find_all("img", src=True):
        print(img["src"])
