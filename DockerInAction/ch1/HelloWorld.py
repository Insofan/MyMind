#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午5:13
# @Author  : Insomnia
# @Desc    : 根目录 terminal 输入python -m ch1.HelloWorld
# @File    : HelloWorld.py
# @Software: PyCharm
import utils.SudoCmd

if __name__ == '__main__':
    cmd = utils.SudoCmd.sudoCmd()
    # 书中第一个 hello world docker
    script = "docker run dockerinaction/hello_world"
    cmd.run(script)
