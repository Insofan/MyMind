#!/usr/bin/env python
#coding=utf-8

import time

import requests
from bs4 import BeautifulSoup

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36'
}

# 要安装bs4  requests lxml这三个库
def judgement_sex(class_name):
    if class_name == ['member_boy_ico']:
        return '男'
    else:
        return '女'

def get_links(url):
    wb_data = requests.get(url, headers=headers)
    soup = BeautifulSoup(wb_data.text, 'lxml')
    links = soup.select('#page_list > ul > li > a')
    for link in links:
        href = link.get("href")
        print(href)
        get_info(href)

def get_info(url):
    wb_data = requests.get(url, headers=headers)
    soup = BeautifulSoup(wb_data.text, 'lxml')
    titles = soup.select('div.pho_info > h4')
    addresses = soup.select('p > span.pr5')
    prices = soup.select('#pricePart > div.day_l > span')
    imgs = soup.select('#floatRightBox > div.js_box.clearfix > div.member_pic > a > img')
    names = soup.select('#floatRightBox > div.js_box.clearfix > div.w_240 > h6 > a')
    sexs = soup.select('#floatRightBox > div.js_box.clearfix > div.w_240 > h6 > span')

    for title, address, price, img, name, sex in zip(titles, addresses, prices, imgs, names, sexs):
        data = {
            'title': title.get_text().strip(),
            'address': address.get_text().strip(),
            'price': price.get_text(),
            'img': img.get("src"),
            'name': name.get_text(),
            'sex': judgement_sex(sex.get("class"))
        }
        print(data)

if __name__ == '__main__':
    urls = ['http://bj.xiaozhu.com/search-duanzufang-p{}-0/'.format(number) for number in range(1, 14)]
    for singleUrl in urls:
        get_links(singleUrl)
        time.sleep(2)