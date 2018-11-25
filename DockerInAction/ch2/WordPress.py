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
    db = 'docker run -d --name db2 -p 13306:3306 -p 13060:33060 -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5'
    # 下面会报错
    # wp = 'docker run -d --name wp2 --link wpdb:mysql -p 80 --read-only wordpress:4'
    # wp2 = 'docker run -d --name wp3 --link wpdb:mysql -p 80 -v /run/lock/apache2/ -v /run/apache2/ --read-only ' \
    #       'wordpress:4'
    #  这里-e WORDPRESS_DB_HOST=用来指定端口
    #  用ifconfig 查看docker0 的虚拟地址, 然后 连接这个地址 expose 映射的3306地址
    wp3 = 'docker run -d --name wp4 -e WORDPRESS_DB_HOST=172.17.0.1:13306 --link wpdb:mysql -p 80 -v ' \
          '/run/lock/apache2/ -v /run/apache2/ -v /tmp/ ' \
          '--read-only ' \
          'wordpress:4'
    cmd.run(wp3)