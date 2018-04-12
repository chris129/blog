# -*- coding: utf-8 -*-

from django.shortcuts import render
from .models import Post

def index(request):
    #注意此post_list后面千万不能参数，不然类型就从QuerySet变成了tunple
    post_list = Post.objects.all().order_by('-created_time')
    return render(request,'blog/index.html',context={'post_list':post_list}
    )
