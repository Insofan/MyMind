#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午8:27
# @Author  : Insomnia
# @Desc    : TODO
# @File    : DouPoCangQiong.py
# @Software: PyCharm

import utils.Header
import time
import requests
import re

headers = utils.Header.headers

f = open("/home/inso/Desktop/Python/Doupo/doupo.txt",'a+')

def get_info(url):
    res = requests.get(url, headers=headers)
    if res.status_code == 200:
        contents = re.findall('<p>(.*?)</p>', res.content.decode('utf-8'), re.S)
        for content in contents:
            f.write(content+'\n')
    else:
        pass
    print(url)
if __name__ == '__main__':
    urls = ['http://www.doupoxs.com/doupocangqiong/{}.html'.format(str(i)) for i in range(2, 1665)]

    for url in urls:
        get_info(url)
        time.sleep(1)
