from django.db import models

# Create your models here.

"""
用户评论的数据必须被存储到数据库里，以便其他用户访问时 Django 能从数据库取回这些数据然后展示给访问的用户，因此我们需要为评论设计数据库模型
"""

class Comment(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField(max_length=255)
    url = models.URLField(blank=True)
    text = models.TextField()
    created_time = models.DateField(auto_now_add=True)

    """
    这个评论是关联到某篇文章（Post）的，由于一个评论只能属于一篇文章，一篇文章可以有多个评论，是一对多的关系，因此这里我们使用了 ForeignKey
    """
    post = models.ForeignKey('blog.Post')

    def __str__(self):
        return self.text[:20]

