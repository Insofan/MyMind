#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time    : 18-11-25 下午9:01
# @Author  : Insomnia
# @Desc    : 运行一个带ngin和邮件服务器的网络监视器
# @File    : Watcher.py
# @Software: PyCharm
import utils.SudoCmd

if __name__ == '__main__':
    cmd = utils.SudoCmd.sudoCmd()
    nginx = 'docker run --detach --name web nginx:latest'
    mail = 'docker run -d --name mailer dockerinaction/ch2_mailer'
    watcher = 'docker run --interactive --tty --link web:web --name web_test busybox:latest /bin/sh'
    agent = 'docker run -it --name agent --link web:insideweb --link mailer:insidemailer dockerinaction/ch2_agent'
    # script = nginx
    # script = mail
    # script = watcher
    # 用 sudo docker exec -it 运行中容器id /bin/bash 进入容器命令行
    #  可以用 sudo docker logs web 来查看各个容器的日志
    script = agent
    cmd.run(script)
