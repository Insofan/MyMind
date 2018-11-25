#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午5:07
# @Author  : Insomnia
# @Desc    : TODO
# @File    : SudoCmd.py
# @Software: PyCharm

import os

SUDO_PASSWORD = '3156110'

class sudoCmd:
    def run(self, cmd):
        os.system('echo %s|sudo -S %s' % (SUDO_PASSWORD, cmd))
