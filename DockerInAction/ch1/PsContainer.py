#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午9:03
# @Author  : Insomnia
# @Desc    : TODO
# @File    : PsContainer.py
# @Software: PyCharm

import utils.SudoCmd

if __name__ == '__main__':
    cmd = utils.SudoCmd.sudoCmd()
    # 书中第一个 hello world docker
    script = "docker ps -a"
    cmd.run(script)