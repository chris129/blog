# -*- coding: utf-8 -*-

from django.shortcuts import render,get_object_or_404
from .models import Post

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
    return render(request,'blog/detail.html',context={'post':post})