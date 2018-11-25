#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午3:41
# @Author  : Insomnia
# @Desc    : 正则
# @File    : regular.py
# @Software: PyCharm

import re
a = 'xxIxxjshdxxlovexxsffaxxpythonxx'
infos = re.findall("xx(.*?)xx",a)
print(infos)

a = 'one1two2three3'

infos = re.search('\d+', a)
print(infos.group())