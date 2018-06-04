# -*- coding: utf-8 -*-

from django.shortcuts import render,get_object_or_404
from .models import Post,Category
import  markdown
from django.views.generic import ListView,DetailView




"""
def index(request):
     #注意此post_list后面千万不能逗号，不然类型就从QuerySet变成了tunple
     post_list = Post.objects.all().order_by('-created_time')
     return render(request,'blog/index.html',context={'post_list':post_list}
     )
将index改写成类视图
一个类视图，首先需要继承 Django 提供的某个类视图。至于继承哪个类视图，需要根据你的视图功能而定。比如这里 IndexView 的功能是从数据库中获
取文章（Post）列表，ListView 就是从数据库中获取某个模型列表数据的，所以 IndexView 继承 ListView
model。将 model 指定为 Post，告诉 Django 我要获取的模型是 Post。
template_name。指定这个视图渲染的模板。
context_object_name。指定获取的模型列表数据保存的变量名。这个变量会被传递给模板
"""
class IndexView(ListView):
    model = Post
    template_name = 'blog/index.html'
    context_object_name = 'post_list'
    # index 视图函数首先通过 Post.objects.all() 从数据库中获取文章（Post）列表数据，并将其保存到 post_list 变量中,而类视图 ListView
    # 已经帮我们写好了上述的分页逻辑，我们只需通过指定 paginate_by 属性来开启分页功能，其值代表每一页包含多少篇文章,这里设置每 2 篇文章一页
    # 分页
    paginate_by = 2
    """
    然后在模板中设置分页导航，比如上一页、下一页的按钮，以及显示一些页面信息。我们这里设置和 Django 官方博客那样的分页导航样式（
    具体的样式见上图）。ListView 传递了以下和分页有关的模板变量供我们在模板中使用
    paginator ，即Paginator 的实例。
    page_obj ，当前请求页面分页对象。
    is_paginated，是否已分页。只有当分页后页面超过两页时才算已分页。
    object_list，请求页面的对象列表，和 post_list 等价。所以在模板中循环文章列表时可以选 post_list ，也可以选 object_list
    """
    """
    官方分页例子：
    from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
    from django.shortcuts import render
    
    def listing(request):
        contact_list = Contacts.objects.all()
        paginator = Paginator(contact_list, 25) # 每页显示 25 个联系人
    
        page = request.GET.get('page')
        try:
            contacts = paginator.page(page)
        except PageNotAnInteger:
            # 如果用户请求的页码号不是整数，显示第一页
            contacts = paginator.page(1)
        except EmptyPage:
            # 如果用户请求的页码号超过了最大页码号，显示最后一页
            contacts = paginator.page(paginator.num_pages)
    
        return render(request, 'list.html', {'contacts': contacts})
        
    """


    """导航条设置：细化导航条，要求如下
    先来分析一下导航条的组成部分，可以看到整个分页导航条其实可以分成 七个部分：
    第 1 页页码，这一页需要始终显示。
    第 1 页页码后面的省略号部分。但要注意如果第 1 页的页码号后面紧跟着页码号 2，那么省略号就不应该显示。
    当前页码的左边部分，比如这里的 3-6。
    当前页码，比如这里的 7。
    当前页码的右边部分，比如这里的 8-11。
    最后一页页码前面的省略号部分。但要注意如果最后一页的页码号前面跟着的页码号是连续的，那么省略号就不应该显示。
    最后一页的页码号。
    """
    def get_context_data(self, **kwargs):
        """
        在视图函数中将模板变量传递给模板是通过给 render 函数的 context 参数传递一个字典实现的，
        例如 render(request, 'blog/index.html', context={'post_list': post_list})，
        这里传递了一个 {'post_list': post_list} 字典给模板。
        在类视图中，这个需要传递的模板变量字典是通过 get_context_data 获得的，
        所以我们复写该方法，以便我们能够自己再插入一些我们自定义的模板变量进去。
        """
        #首先获得父类生成的传递给模板的字典
        context =super().get_context_data(**kwargs)
        # 父类生成的字典中已有 paginator、page_obj、is_paginated 这三个模板变量，
        # paginator 是 Paginator 的一个实例，
        # page_obj 是 Page 的一个实例，
        # is_paginated 是一个布尔变量，用于指示是否已分页。
        # 例如如果规定每页 10 个数据，而本身只有 5 个数据，其实就用不着分页，此时 is_paginated=False。
        # 关于什么是 Paginator，Page 类在 Django Pagination 简单分页：http://zmrenwu.com/post/34/ 中已有详细说明。
        # 由于 context 是一个字典，所以调用 get 方法从中取出某个键对应的值。
        paginator = context.get('paginator')
        page = context.get('page_obj')
        is_paginated = context.get('is_paginated')

        # 调用自己写的 pagination_data 方法获得显示分页导航条需要的数据，见下方。
        pagination_data = self.pagination_data(paginator, page, is_paginated)

        # 将分页导航条的模板变量更新到 context 中，注意 pagination_data 方法返回的也是一个字典。
        context.update(pagination_data)
        # 将更新后的 context 返回，以便 ListView 使用这个字典中的模板变量去渲染模板。
        # 注意此时 context 字典中已有了显示分页导航条所需的数据。
        return context

    def pagination_data(self,paginator,page,is_paginated):
        if not is_paginated:
            #如果没有分页，则无需显示分页导航条，不用任何分页导航条的数据，因此返回一个空的字典
            return {}
        # 当前页左边连续的页码号，初始值为空
        left = []

        # 当前页右边连续的页码号，初始值为空
        right = []

        # 标示第 1 页页码后是否需要显示省略号
        left_has_more=False
        # 标示最后一页页码前是否需要显示省略号
        right_has_more=False

        # 标示是否需要显示第 1 页的页码号。
        # 因为如果当前页左边的连续页码号中已经含有第 1 页的页码号，此时就无需再显示第 1 页的页码号，
        # 其它情况下第一页的页码是始终需要显示的。
        # 初始值为 False
        first = False

        # 标示是否需要显示最后一页的页码号。
        # 需要此指示变量的理由和上面相同。
        last = False

        # 获得用户当前请求的页码号
        page_number = page.number

        # 获得分页后的总页数
        total_pages = paginator.num_pages

        # 获得整个分页页码列表，比如分了四页，那么就是 [1, 2, 3, 4]
        page_range = paginator.page_range

        if page_number == 1:
            # 如果用户请求的是第一页的数据，那么当前页左边的不需要数据，因此 left=[]（已默认为空）。
            # 此时只要获取当前页右边的连续页码号，
            # 比如分页页码列表是 [1, 2, 3, 4]，那么获取的就是 right = [2, 3]。
            # 注意这里只获取了当前页码后连续两个页码，你可以更改这个数字以获取更多页码。
            right = page_range[page_number:page_number + 2]

            # 如果最右边的页码号比最后一页的页码号减去 1 还要小，
            # 说明最右边的页码号和最后一页的页码号之间还有其它页码，因此需要显示省略号，通过 right_has_more 来指示。
            if right[-1] < total_pages - 1:
                right_has_more = True

            # 如果最右边的页码号比最后一页的页码号小，说明当前页右边的连续页码号中不包含最后一页的页码
            # 所以需要显示最后一页的页码号，通过 last 来指示
            if right[-1] < total_pages:
                last = True

        elif page_number == total_pages:
            # 如果用户请求的是最后一页的数据，那么当前页右边就不需要数据，因此 right=[]（已默认为空），
            # 此时只要获取当前页左边的连续页码号。
            # 比如分页页码列表是 [1, 2, 3, 4]，那么获取的就是 left = [2, 3]
            # 这里只获取了当前页码后连续两个页码，你可以更改这个数字以获取更多页码。
            left = page_range[(page_number - 3) if (page_number - 3) > 0 else 0:page_number - 1]

            # 如果最左边的页码号比第 2 页页码号还大，
            # 说明最左边的页码号和第 1 页的页码号之间还有其它页码，因此需要显示省略号，通过 left_has_more 来指示。
            if left[0] > 2:
                left_has_more = True

            # 如果最左边的页码号比第 1 页的页码号大，说明当前页左边的连续页码号中不包含第一页的页码，
            # 所以需要显示第一页的页码号，通过 first 来指示
            if left[0] > 1:
                first = True
        else:
            # 用户请求的既不是最后一页，也不是第 1 页，则需要获取当前页左右两边的连续页码号，
            # 这里只获取了当前页码前后连续两个页码，你可以更改这个数字以获取更多页码。
            left = page_range[(page_number - 3) if (page_number - 3) > 0 else 0:page_number - 1]
            right = page_range[page_number:page_number + 2]

            # 是否需要显示最后一页和最后一页前的省略号
            if right[-1] < total_pages - 1:
                right_has_more = True
            if right[-1] < total_pages:
                last = True

            # 是否需要显示第 1 页和第 1 页后的省略号
            if left[0] > 2:
                left_has_more = True
            if left[0] > 1:
                first = True

        data = {
            'left': left,
            'right': right,
            'left_has_more': left_has_more,
            'right_has_more': right_has_more,
            'first': first,
            'last': last,
        }

        return data
            











from comments.forms import CommentForm
def detail(request,pk):
    """
    视图函数很简单，它根据我们从 URL 捕获的文章 id（也就是 pk，这里 pk 和 id 是等价的）获取数据库中文章 id 为该值的记录，然后传递给模板
    注意这里我们用到了从 django.shortcuts 模块导入的 get_object_or_404 方法，其作用就是当传入的 pk 对应的 Post 在数据库存在时，
    就返回对应的 post，如果不存在，就给用户返回一个 404 错误，表明用户请求的文章不存在。
    """
    post = get_object_or_404(Post,pk=pk)
    #阅读量+1
    post.increase_views()
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
    form = CommentForm()
    #获取这篇文章下的全部评论
    comment_list = post.comment_set.all()
    #将文章、表单、以及文章下的评论列表作为模板变量传给 detail.html 模板，以便渲染相应数据
    context = {'post':post,
               'form':form,
               'comment_list':comment_list
               }
    return render(request, 'blog/detail.html', context=context)

#使用类重写detail，除了从数据库中获取模型列表的数据外，从数据库获取模型的一条记录数据也是常见的需求，使用DetailView

class PostDetailView(DetailView):
    model = Post
    template_name = 'blog/detail.html'
    context_object_name = 'post'

    def get(self,request,*args,**kwargs):
        """
        覆写 get 方法的目的是因为每当文章被访问一次，就得将文章阅读量 +1
        get 方法返回的是一个 HttpResponse 实例
        之所以需要先调用父类的 get 方法，是因为只有当 get 方法被调用后，
        才有 self.object 属性，其值为 Post 模型实例，即被访问的文章 post
        """
        response = super(PostDetailView,self).get(request,*args,**kwargs)
        #将阅读量+1，self.object 的值就是被访问的文章 post
        self.object.increase_views()
        # 视图必须返回一个 HttpResponse 对象
        return response

    def get_object(self, queryset=None):
        # 覆写 get_object 方法的目的是因为需要对 post 的 body 值进行渲染
        post = super(PostDetailView,self).get_object(queryset=None)
        post.body = markdown.markdown(post.body,
                                      extensions=[
                                         'markdown.extensions.extra',
                                         'markdown.extensions.codehilite',
                                         'markdown.extensions.toc',
                                      ])
        return post

    def get_context_data(self, **kwargs):
        #覆写 get_context_data 的目的是因为除了将 post 传递给模板外（DetailView 已经帮我们完成）
        # 还要把评论表单、post 下的评论列表传递给模板
        context = super(PostDetailView,self).get_context_data(**kwargs)
        form = CommentForm()
        comment_list = self.object.comment_set.all()
        context.update({
            'form': form,
            'comment_list': comment_list
        })
        return context
"""
PostDetailView 稍微复杂一点，主要是等价的 detail 视图函数本来就比较复杂，下面来一步步对照 detail 视图函数中的代码讲解。
首先我们为 PostDetailView 类指定了一些属性的值，这些属性的含义和 ListView 中是一样的，这里不再重复讲解。
紧接着我们覆写了 get 方法。这对应着 detail 视图函数中将 post 的阅读量 +1 的那部分代码。事实上，你可以简单地把 get 方法的调用看成是 
detail 视图函数的调用。
接着我们又复写了 get_object 方法。这对应着 detail 视图函数中根据文章的 id（也就是 pk）获取文章，然后对文章的 post.body 进行 
Markdown 渲染的代码部分。
最后我们复写了 get_context_data 方法。这部分对应着 detail 视图函数中生成评论表单、获取 post 下的评论列表的代码部分。
这个方法返回的值是一个字典，这个字典就是模板变量字典，最终会被传递给模板。
你也许会被这么多方法搞乱，为了便于理解，你可以简单地把 get 方法看成是 detail 视图函数，至于其它的像 get_object、get_context_data 
都是辅助方法，这些方法最终在 get 方法中被调用，这里你没有看到被调用的原因是它们隐含在了 super(PostDetailView, self).get(request,
 *args, **kwargs) 即父类 get 方法的调用中。最终传递给浏览器的 HTTP 响应就是 get 方法返回的 HttpResponse 对象。
"""


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

#使用类重新archives
class ArchivesView(ListView):
    model = Post
    template_name = 'blog/index.html'
    context_object_name = 'post_list'

    def get_queryset(self):
        year = self.kwargs.get('year')
        month = self.kwargs.get('month')
        return super(ArchivesView, self).get_queryset().filter(created_time__year=year,
                                                               created_time__month=month
                                                               )


"""分类页面：
这里我们首先根据传入的 pk 值（也就是被访问的分类的 id 值）从数据库中获取到这个分类。get_object_or_404 函数和 detail 视图中一样，
其作用是如果用户访问的分类不存在，则返回一个 404 错误页面以提示用户访问的资源不存在。然后我们通过 filter 函数过滤出了该分类下的全部文章。
同样也和首页视图中一样对返回的文章列表进行了排序。
"""
from .admin import  Category

# def category(request,pk):
#     cate = get_object_or_404(Category,pk=pk)
#     post_list = Post.objects.filter(category=cate).order_by('-created_time')
#     return render(request,'blog/index.html',context={'post_list':post_list})


"""
改写category为类视图
覆写了父类的 get_queryset 方法。该方法默认获取指定模型的全部列表数据。为了获取指定分类下的文章列表数据，我们覆写该方法，改变它的默认行为
在类视图中，从 URL 捕获的命名组参数值保存在实例的 kwargs 属性（是一个字典）里，非命名组参数值保存在实例的 args 属性（是一个列表）里
我们使了 self.kwargs.get('pk') 来获取从 URL 捕获的分类 id 值
调用父类的 get_queryset 方法获得全部文章列表，紧接着就对返回的结果调用了 filter 方法来筛选该分类下的全部文章并返回
"""
class CategoryView(ListView):
    model = Post
    template_name = 'blog/index.html'
    context_object_name = 'post_list'

    def get_queryset(self):
        cate = get_object_or_404(Category,pk=self.kwargs.get('pk'))
        return super(CategoryView,self).get_queryset().filter(category=cate)




#标签云视图-显示某个标签下的文章列表
#显示某个标签下的文章列表和我们之前做的点击分类后显示该分类下的文章列表是一样的。回顾一下显示分类下的文章列表时的做法，经典的 Django 三部曲。
#首先是定义视图函数，然后编写模板文件，最后将视图函数和 URL 模式绑定。标签和分类是完全一样的步骤，因此稍微修改一下分类相关的代码就可以用于标签
class TagView(ListView):
    model = Post
    template_name = 'blog/index.html'
    context_object_name = 'post_list'

    def get_queryset(self):
        tag = get_object_or_404(Tag, pk=self.kwargs.get('pk'))
        return super(TagView, self).get_queryset().filter(tags=tag)


