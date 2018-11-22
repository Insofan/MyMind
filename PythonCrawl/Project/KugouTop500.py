#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-22 下午7:59
# @Author  : Insomnia
# @Desc    : 酷狗Top500歌曲信息
# @File    : KugouTop500.py
# @Software: PyCharm
import time
import requests
from bs4 import BeautifulSoup

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36'
}

def get_info(url):
    wb_data = requests.get(url, headers=headers)
    soup = BeautifulSoup(wb_data.text, 'lxml')
    ranks = soup.select('span.pc_temp_num')
    titles = soup.select('#rankWrap > div.pc_temp_songlist > ul > li > a')
    times = soup.select('div.pc_temp_songlist > ul > li > span.pc_temp_tips_r > span')
    for rank, title, time in zip(ranks, titles, times):
        # print(rank.get_text())
        # print(title.get_text().strip())
        # print(time.get_text().strip())
        if title.get_text().find('-') > 0:
            data = {
                'rank': rank.get_text().strip(),
                'singer': title.get_text().split('-')[0].strip(),
                'song': title.get_text().split('-')[1].strip(),
                'time': time.get_text().strip(),
            }
        else:
            data = {
                'rank': rank.get_text().strip(),
                'singer': title.get_text().split('-')[0].strip(),
                'song': '',
                'time': time.get_text().strip(),
            }
        print(data)


if __name__ == '__main__':

    urls = ["http://www.kugou.com/yy/rank/home/{}-8888.html?from=rank".format(str(i)) for i in range(1, 24)]

    for url in urls:
        # print(url)
        get_info(url)
        time.sleep(1)
