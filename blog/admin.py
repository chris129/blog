from django.contrib import admin

# Register your models here.

from .models import Post,Category,Tag
##注册服务到Django后台管理，使用后台发布文章
admin.site.register(Post)
admin.site.register(Category)
admin.site.register(Tag)