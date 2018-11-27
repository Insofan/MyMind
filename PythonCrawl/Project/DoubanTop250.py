#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午11:32
# @Author  : Insomnia
# @Desc    : TODO
# @File    : DoubanTop250.py
# @Software: PyCharm

from lxml import etree
import requests
import csv
import utils.Header
import time

fp = open("./douban.csv", 'wt', newline='',encoding='utf-8')
writer = csv.writer(fp)
writer.writerow(('name', 'url', 'authore', 'publisher', 'date', 'price', 'rate', 'comment'))
# range start end step
urls = ['https://book.douban.com/top250?start={}'.format(str(i)) for i in range(0, 250, 25)]
headers = utils.Header.headers
if __name__ == '__main__':
    print("豆瓣读书Top 250")

    for url in urls:
        html = requests.get(url, headers=headers)
        sel = etree.HTML(html.text)
        infos = sel.xpath('//tr[@class="item"]')
        for info in infos:
            name = info.xpath('td/div/a/@title')[0]
            url = info.xpath('td/div/a/@href')[0]
            book_infos = info.xpath('td/p/text()')[0]
            author = book_infos.split('/')[0]
            publisher = book_infos.split('/')[-3]
            date = book_infos.split('/')[-2]
            price = book_infos.split('/')[-1]
            rate = info.xpath('td/div/span[2]/text()')[0]
            comments = info.xpath('td/p/span[0]/text()')
            comment = comments[0] if len(comments)  != 0 else "空"
            writer.writerow((name, url, author, publisher, date, price, rate, comment))
    fp.close()
