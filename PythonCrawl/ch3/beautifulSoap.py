#!/usr/bin/env python
#coding=utf-8

import requests
from bs4 import BeautifulSoup
headers = {
'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36'
}
# 用request 请求, 用bs4 来结构化请求的html
res = requests.get('http://bj.xiaozhu.com/', headers=headers)
soup = BeautifulSoup(res.text, 'html.parser')
# find( name , attrs , recursive , text , **kwargs )
# 用chrome copy和copy selector来选择下面的
prices = soup.select('#page_list > ul > li > div.result_btm_con.lodgeunitname > span.result_price > i')

# price 是<i>398</i>, 用gettest来获取

for price in prices:
    print(price.get_text())
# url 页的结构是: http://bj.xiaozhu.com/search-duanzufang-p1-0/, http://bj.xiaozhu.com/search-duanzufang-p2-0/
# 替换p后面的数字
