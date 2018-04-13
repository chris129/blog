# -*- coding: utf-8 -*-
from django.conf.urls import url

from . import views

app_name = 'comments'

urlpatterns = [
    url(r'^comment/post/(?P<post_pk>[0-9]+)/$',views.post_commnet,name='post_comment'),
]