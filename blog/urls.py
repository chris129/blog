# -*- coding: utf-8 -*-
from django.conf.urls import url
from . import views

app_name='blog'
urlpatterns = [
    url(r'^$',views.index,name='index'),
    url(r'^post/(?P<pk>[0-9]+)/$', views.detail, name='detail'),
    #两个括号括起来的地方是两个命名组参数,/archives/2017/3/等价于：archives(request, year=2017, month=3)
    url(r'^archives/(?P<year>[0-9]{4})/(?P<month>[0-9]{1,2})/$',views.archives,name='archives'),
    url(r'^category/(?P<pk>[0-9]+)/$',views.category,name='category'),
]