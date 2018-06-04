# -*- coding: utf-8 -*
#自定义模板标签代码写在 blog_tags.py 文件中。其实模板标签本质上就是一个 Python 函数，因此按照 Python 函数的思路来编写模板标签的代码就可以
#定义好函数后，要按照 Django 的规定注册这个函数为模板标签

from ..models import Post,Category,Tag
from django.db.models.aggregates import Count


"""
这里我们首先导入 template 这个模块，然后实例化了一个 template.Library 类，并将函数 get_recent_posts 装饰为 register.simple_tag。
这样就可以在模板中使用语法 {% get_recent_posts %} 调用这个函数了
Django 1.9 后才支持 simple_tag 模板标签
"""
from django import template
register = template.Library()

@register.simple_tag
def get_recent_posts(num=5):
    return Post.objects.all().order_by('-created_time')[:num]


#归档
"""
这里 dates 方法会返回一个列表，列表中的元素为每一篇文章（Post）的创建时间，且是 Python 的 date 对象，精确到月份，降序排列。
接受的三个参数值表明了这些含义，一个是 created_time ，即 Post 的创建时间，month 是精度，order='DESC' 表明降序排列
（即离当前越近的时间越排在前面）
例如我们写了 3 篇文章，分别发布于 2017 年 2 月 21 日、2017 年 3 月 25 日、2017 年 3 月 28 日，
那么 dates 函数将返回 2017 年 3 月 和 2017 年 2 月这样一个时间列表，且降序排列，从而帮助我们实现按月归档的目的
"""
@register.simple_tag
def archives():
    return Post.objects.dates('created_time','month',order='DESC')

@register.simple_tag
def get_category():
    #return Category.objects.all()
    ##在我们的博客侧边栏有分类列表，显示博客已有的全部文章分类。现在想在分类名后显示该分类下有多少篇文章，该怎么做呢？
    # 最优雅的方式就是使用 Django 模型管理器的 annotate 方法,记得在顶部引入 count 函数
    # Count 计算分类下的文章数，其接受的参数为需要计数的模型的名称
    return Category.objects.annotate(num_posts=Count('post')).filter(num_posts__gt=0)
    #这个 Category.objects.annotate 方法和 Category.objects.all 有点类似，它会返回数据库中全部 Category 的记录，
    # 但同时它还会做一些额外的事情，在这里我们希望它做的额外事情就是去统计返回的 Category 记录的集合中每条记录下的文章数





#此外，annotate 方法不局限于用于本文提到的统计分类下的文章数，你也可以举一反三，只要是两个 model 类通过 ForeignKey 或者 ManyToMany
#关联起来，那么就可以使用 annotate 方法来统计数量。比如下面这样一个标签系统
# #统计标签下的文章数
# from blog.models import Tag
# # Count 计算分类下的文章数，其接受的参数为需要计数的模型的名称
tag_list = Tag.objects.annotate(num_posts=Count('post'))


@register.simple_tag
def get_categories():
    return Category.objects.annotate(num_posts=Count('post')).filter(num_posts__gt=0)


@register.simple_tag
def get_tags():
    return Tag.objects.annotate(num_posts=Count('post')).filter(num_posts__gt=0)