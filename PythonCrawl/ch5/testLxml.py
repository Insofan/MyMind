#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午10:18
# @Author  : Insomnia
# @Desc    : TODO
# @File    : testLxml.py
# @Software: PyCharm

from lxml import etree

if __name__ == '__main__':
    print("HELLO WORLD")
    html = etree.parse('./flower.html')
    result = etree.tostring(html, pretty_print=True)
    print(result)