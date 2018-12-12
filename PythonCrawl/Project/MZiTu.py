#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-12-12 下午9:40
# @Author  : Insomnia
# @Desc    : 爬美女图并下载
# @File    : MZiTu.py
# @Software: PyCharm

import requests
from bs4 import BeautifulSoup
from urllib.request import urlretrieve
import utils.Header
import time

# headers = utils.Header.headers
headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36'
}

def mzitu():
    download_links = []
    path = '/home/inso/Desktop/Python/MZiTu/'
    url = 'http://www.mzitu.com/'
    res = requests.get(url, headers=headers)
    soup = BeautifulSoup(res.text, 'lxml')
    imgs = soup.select('li > a > img')
    for img in imgs:
        print(img.get('data-original'))
        download_links.append(img.get('data-original'))
    for item in download_links:
        # 网站 屏蔽了urlretrieve 所以会 403
        urlretrieve(item, path+item[-10:])
    print("Download bingo")

if __name__ == '__main__':
    print("Download begin")
    mzitu()
