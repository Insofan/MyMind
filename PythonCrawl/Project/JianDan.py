#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-12-12 下午9:54
# @Author  : Insomnia
# @Desc    : 现在煎蛋和 妹子图 都无法下载图片
# @File    : JianDan.py
# @Software: PyCharm

import requests
from lxml import etree
import utils.Header

urls = ['http://jandan.net/ooxx/page-{}'.format(str(i)) for i in range(0, 20)]
path = '/home/inso/Desktop/Python/JanDan/'

headers = utils.Header.headers

def getPhoto(url):
    html = requests.get(url)
    selector = etree.HTML(html.text)
    photoUrls = selector.xpath('//p/a[@class="view_img_link"]/@href')
    for photoUrl in photoUrls:
        data = requests.get('http:'+photoUrl, headers)
        fp = open(path + photoUrl[-10:], 'wb')
        fp.write(data.content)
        fp.close()



if __name__ == '__main__':
    print("HELLO WORLD")
    for url in urls:
        getPhoto(url)