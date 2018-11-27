#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午11:07
# @Author  : Insomnia
# @Desc    : TODO
# @File    : TestXpath1.py
# @Software: PyCharm
import requests
from lxml import etree
import utils.Header

headers = utils.Header.headers

if __name__ == '__main__':
    print("HELLO WORLD")
    url = 'https://www.qiushibaike.com/'
    res = requests.get(url, headers=headers)
    selector = etree.HTML(res.text)
    url_infos = selector.xpath('//div[@class="article block untagged mb15 typs_long"]')
    for url_info in url_infos:
        id = url_info.xpath('div[1]/a[2]/h2/text()')[0]
        print(id)

    # print(id1)