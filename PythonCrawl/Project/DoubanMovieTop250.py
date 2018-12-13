#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-12-13 下午10:20
# @Author  : Insomnia
# @Desc    : Top250 movie 存入mysql
# @File    : DoubanMovieTop250.py
# @Software: PyCharm

import requests
from lxml import etree
import re
import pymysql
import time
import utils.Header

conn = pymysql.connect(host='localhost', user='root', passwd='admin123456', db='exercise', port=3306, charset='utf8')
# 数据库光标
cursor = conn.cursor()

headers = utils.Header.headers
proxies = {
    "http": "http://207.148.85.247:8123",
    # "https": "https://221.228.17.172:8181",
}

def get_movie_url(url):
    html = requests.get(url, headers=headers, proxies=proxies)
    selector = etree.HTML(html.text)
    movie_hrefs = selector.xpath('//div[@class="hd"]/a/@href')
    for movie_href in movie_hrefs:
        get_movie_info(movie_href)

def get_movie_info(url):
    html = requests.get(url, headers=headers)
    selector = etree.HTML(html.text)
    try:
        name = selector.xpath('//*[@id="content"]/h1/span[1]/text()')[0]
        director = selector.xpath('//*[@id="info"]/span[1]/span[2]/a/text()')[0]
        actors = selector.xpath('//*[@id="info"]/span[3]/span[2]')[0]
        actor = actors.xpath('string(.)')
        style = re.findall('<span property="v:genre">(.*?)</span>', html.text, re.S)[0]
        country = re.findall('<span class="pl">制片国家/地区:</span>(.*?)<br/>', html.text, re.S)[0]
        release_time = re.findall('<span class="pl">制片国家/地区:</span>(.*?)<br/>', html.text, re.S)[0]
        time = re.findall('片长:</span>.*?(.*?)</span>', html.text, re.S)[0]
        score = selector.xpath('//*[@id="interest_sectl"]/div[1]/div[2]/strong/text()')[0]
        cursor.execute("insert into doubanmovie (name, director, actor, country, release_time, style, time, sc"
                       "ore) values (%s, "
                       "%s, %s, "
                       "%s, %s,"
                       " "
                       "%s, %s, %s)", (str(name), str(director), str(actor), str(country), str(release_time),
                                           str(style), str(time), str(score)))
    except IndexError:
        pass

if __name__ == '__main__':
    urls = ['https://movie.douban.com/top250?start={}'.format(str(i)) for i in range(0, 250, 25)]
    for url in urls:
        get_movie_url(url)
        time.sleep(3)
    conn.commit()
