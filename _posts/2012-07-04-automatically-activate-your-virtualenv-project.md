---
layout: post
title: Automatically activate your virtualenv project
---

[Virtualenv](http://www.virtualenv.org/en/latest/index.html) and [Virtualenvwrapper](http://www.doughellmann.com/projects/virtualenvwrapper/) are fantastic tools.  But have you ever wondered how to automatically load the environment when you cd into your project's directory?   I bet you've probably crawled the web and found solutions like [aliasing "cd"](http://www.doughellmann.com/docs/virtualenvwrapper/tips.html#automatically-run-workon-when-entering-a-directory) or making some sort of [bash function](http://toranbillups.com/blog/archive/2012/4/22/Automatically-activate-your-virtualenv).  But really, it should be easier.

So have you heard about ruby's rvm?  Besides being a ruby version manager, it lets you create directory-specific ".rvmrc" files which execute every time you cd into a directory.

If you don't have rvm already, [install it](https://rvm.io/rvm/install/) and learn ruby.  Then try this when you decide you like python better (hah!):

{% highlight c %}
    proj_name=PROJECT_NAME
    if [ "${VIRTUAL_ENV##*/}" != "$proj_name" ]
    then
      workon "$proj_name"
    fi
{% endhighlight %}


