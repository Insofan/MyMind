#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午10:41
# @Author  : Insomnia
# @Desc    : TODO
# @File    : TestXpath.py
# @Software: PyCharm

# //*[@id="qiushi_tag_121288064"]/div[1]/a[2]/h2
import requests
from lxml import etree
import utils.Header

headers = utils.Header.headers

if __name__ == '__main__':
    url = 'https://www.qiushibaike.com/'
    res = requests.get(url, headers=headers)
    selector = etree.HTML(res.text)
    id1 = selector.xpath('//*[@id="qiushi_tag_121276941"]/div[1]/a[2]/h2/text()')[0]
    # url_infos = selector.xpath('//div[@class="article block untagged mb15"]')

    print(id1)