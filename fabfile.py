# -*- coding: utf-8 -*-
from fabric.api import env, run
from fabric.operations import sudo

GIT_REPO = "you git repository" ①

env.user = 'you host username' ②
env.password = 'you host password'

# 填写你自己的主机对应的域名
env.hosts = ['demo.zmrenwu.com']

# 一般情况下为 22 端口，如果非 22 端口请查看你的主机服务提供商提供的信息
env.port = '22'


def deploy():
    source_folder = '/home/yangxg/sites/zmrenwu.com/django-blog-tutorial' ③

    run('cd %s && git pull' % source_folder) ④
    run("""
        cd {} &&
        ../env/bin/pip install -r requirements.txt &&
        ../env/bin/python3 manage.py collectstatic --noinput &&
        ../env/bin/python3 manage.py migrate
        """.format(source_folder)) ⑤
    sudo('restart gunicorn-demo.zmrenwu.com') ⑥
    sudo('service nginx reload')

# 解释：
# ① 你的代码托管仓库地址。
#
# ② 配置一些服务器的地址信息和账户信息，各参数的含义分别为：
#
# env.user：用于登录服务器的用户名
# env.password：用户名对应的密码
# env.hosts：服务器的 IP 地址，也可以是解析到这个 IP 的域名
# env.port：SSH 远程服务器的端口号
# ③ 需要部署的项目根目录在服务器上的位置。
#
# ④ 通过 run 方法在服务器上执行命令，传入的参数为需要执行的命令，用字符串包裹。这里执行了两条命令，不同命令间用 && 符号连接：
#
# cd 命令进入到需要部署的项目根目录
# git pull 拉取远程仓库的最新代码
# ⑤ 对应上述部署过程中 3-5 的几条命令。因为启用了虚拟环境，所以运行的是虚拟环境 ../env/bin/ 下的 pip 和 python
#
# ⑥ 重启 Gunicorn 和 Nginx，由于这两条命令要在超级权限下运行，所以使用了 sudo 方法而不是 run 方法。
#
# 注意全部的脚本代码要放在 deploy 函数里，Fabric 会自动检测 fabfile.py 脚本中的 deploy 函数并运行。
#
# 由于脚本中有登录服务器的用户名和密码等敏感信息，不要把 fabfile.py 文件也上传到公开的代码托管仓库。



# 执行函数
# 执行 Fabric 自动部署脚本
# 进入 fabfile.py 文件所在的目录，在 Python2 的环境下用 fab 命令运行这个脚本文件。
#
# 比如我的是 Windows 环境，Python2 安装在 C:\Python27\ 下，那么运行：
#
# C:\Python27\Scripts\fab deploy
# 这时 Fabric 会自动检测到 fabfile.py 脚本中的 deploy 函数并运行，你会看到命令行输出了一系列字符串，如果在最后看到

