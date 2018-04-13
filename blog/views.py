# -*- coding: utf-8 -*-

from django.shortcuts import render,get_object_or_404
from .models import Post
import  markdown

def index(request):
    #注意此post_list后面千万不能参数，不然类型就从QuerySet变成了tunple
    post_list = Post.objects.all().order_by('-created_time')
    return render(request,'blog/index.html',context={'post_list':post_list}
    )



def detail(request,pk):
    """
    视图函数很简单，它根据我们从 URL 捕获的文章 id（也就是 pk，这里 pk 和 id 是等价的）获取数据库中文章 id 为该值的记录，然后传递给模板
    注意这里我们用到了从 django.shortcuts 模块导入的 get_object_or_404 方法，其作用就是当传入的 pk 对应的 Post 在数据库存在时，
    就返回对应的 post，如果不存在，就给用户返回一个 404 错误，表明用户请求的文章不存在。
    """
    post = get_object_or_404(Post,pk=pk)
    """
    这样我们在模板中展示 {{ post.body }} 的时候，就不再是原始的 Markdown 文本了，而是渲染过后的 HTML 文本。注意这里我们给 markdown 
    渲染函数传递了额外的参数 extensions，它是对 Markdown 语法的拓展，这里我们使用了三个拓展，分别是 extra、codehilite、toc。extra 
    本身包含很多拓展，而 codehilite 是语法高亮拓展，这为我们后面的实现代码高亮功能提供基础，而 toc 则允许我们自动生成目录
    文章详情页没有看到预期的效果，而是类似于一堆乱码一样的 HTML 标签，这是由于安全考虑， HTML 代码在 Django 的模板中都会被转义，
    在模板中找到展示博客文章主体的 {{ post.body }} 部分，为其加上 safe 过滤器，{{ post.body|safe }}，大功告成，这下看到预期效果了
    """
    post.body = markdown.markdown(post.body,
                                  extensions=[
                                     'markdown.extensions.extra',
                                     'markdown.extensions.codehilite',
                                     'markdown.extensions.toc',
                                  ])
    return render(request, 'blog/detail.html', context={'post': post})


"""
模型管理器（objects）的 filter 函数来过滤文章。由于是按照日期归档，因此这里根据文章发表的年和月来过滤。具体来说，就是根据 created_time 
的 year 和 month 属性过滤，筛选出文章发表在对应的 year 年和 month 月的文章。注意这里 created_time 是 Python 的 date 对象，
其有一个 year 和 month 属性,Python 中类实例调用属性的方法通常是 created_time.year，但是由于这里作为函数的参数列表，所以 Django 
要求我们把点替换成了两个下划线，即 created_time__year
"""

def archives(request,year,month):
    post_list = Post.objects.filter(created_time__year=year,
                                    created_time__month=month).order_by('-created_time')
    return render(request,'blog/index.html',context={'post_list':post_list})



"""分类页面：
这里我们首先根据传入的 pk 值（也就是被访问的分类的 id 值）从数据库中获取到这个分类。get_object_or_404 函数和 detail 视图中一样，
其作用是如果用户访问的分类不存在，则返回一个 404 错误页面以提示用户访问的资源不存在。然后我们通过 filter 函数过滤出了该分类下的全部文章。
同样也和首页视图中一样对返回的文章列表进行了排序。
"""
from .admin import  Category

def category(request,pk):
    cate = get_object_or_404(Category,pk=pk)
    post_list = Post.objects.filter(category=cate).order_by('-created_time')
    return render(request,'blog/index.html',context={'post_list':post_list})

