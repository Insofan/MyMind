#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-27 下午11:27
# @Author  : Insomnia
# @Desc    : TODO
# @File    : TestCsv.py
# @Software: PyCharm

import csv

if __name__ == '__main__':
    fp = open('./test.csv', 'w+')
    writer = csv.writer(fp)
    writer.writerow(('id', 'name'))
    writer.writerow(('1', 'name1'))
    writer.writerow(('2', 'name2'))
    writer.writerow(('3', 'name3'))
