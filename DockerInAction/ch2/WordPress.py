#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午9:42
# @Author  : Insomnia
# @Desc    : TODO
# @File    : WordPress.py
# @Software: PyCharm
import utils.SudoCmd

if __name__ == '__main__':
    cmd = utils.SudoCmd.sudoCmd()
    db = 'docker run -d --name wpdb -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5'
    cmd.run(db)