#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午10:29
# @Author  : Insomnia
# @Desc    : TODO
# @File    : DoubanTop250.py
# @Software: PyCharm

import utils.Header
import requests
from lxml import etree
headers = utils.Header.headers
if __name__ == '__main__':
    print("HELLO WORLD")
    res = requests.get('https://book.douban.com/top250', headers=headers)
    html = etree.HTML(res.text)
    print(html)
    result = etree.tostring(html)
    print(result)