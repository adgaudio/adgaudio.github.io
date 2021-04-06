---
layout: post
title: Solving the Vim and Comand-t segmentation fault problem
---

Does this apply to you?  Follow ahead to resolve your issues

Problem:  A seg fault occurs when using the command-t plugin for vim

{% highlight c %}
    # vim works until you try to use the command-t plugin:
    $ vim
    Vim: Caught deadly signal SEGV
    Vim: Finished.
    Segmentation fault  
{% endhighlight %}

Reason:  Command-t and vim were compiled against a different versions of ruby 

Resolution:
First, lets find out if you really do have vim and command-t installed.  

{% highlight c %}
    # Check: Is vim compiled with ruby support?
    $ vim --version |grep ruby
    +quickfix +reltime +rightleft +ruby +scrollbind +signs +smartindent -sniff
    
    # Check: Do you have command-t installed?
    ## My plugin is installed here (thanks to the pathogen plugin)
    ## your plugin may be installed in some place like ~/.vim/plugin
    $ ls -d ~/.vim/bundle/command-t
    /Users/agaudio/.vim/bundle/command-t # on my mac

    # Check: Does vim work without command-t?
    #### NOTE: your plugin path may be different
    $ mv ~/.vim/bundle/command-t ~ && vim && mv ~/command-t ~/.vim/bundle/  

    # Check: You are getting that seg fault with command-t installed, right?
    $ vim
{% endhighlight %}

Assuming you've passed those checks, lets find out whether vim and command-t use different ruby libraries

My Vim install uses this ruby library:

{% highlight c %}
    $ otool -L `which vim`|grep ruby
        /opt/local/lib/libruby.dylib (compatibility version 1.8.0, current version 1.8.7)
{% endhighlight %}


Get the Command-t ruby library:

{% highlight c %}
    $ cd ~/.vim/bundle/command-t #### NOTE: your plugin path may be different
    $ grep ^prefix `find . -name "Makefile"`
    prefix = $(DESTDIR)/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr

    ###NOTE: If you don't have a Makefile, you may need to do this first:
    $ rake make ; make 
    $ vim # maybe you've just fixed your problem?
{% endhighlight %}

At this point, we can see that vim was compiled with a different library than command-t.  Moving forward, we have two options.  First, you could compile command-t to match vim, or second, you could compile vim to match command-t.  This question may depend on whether you want to use the system ruby, or in my case, the macports installation of ruby. 

Below shows how to compile command-t to match the ruby lib vim was compiled with.  If you want to compile vim from source, look elsewhere.


{% highlight c %}
    # These are the interpreters available to me.  This will be different for you.
    $ which -a ruby
    /opt/local/bin/ruby
    /usr/bin/ruby
    /opt/local/bin/ruby

    # Find which of the above ruby interpreters matches vim's ruby library. 
    # (we used "otool -L vim" to find vim's ruby library, remember?)
    # In my case, the /opt/local/bin/ruby interpreter matches the ruby lib I'm interested in
    $ /opt/local/bin/ruby -e 'puts $:'
    /opt/local/lib/ruby/site_ruby/1.8
    /opt/local/lib/ruby/site_ruby/1.8/i686-darwin10
    /opt/local/lib/ruby/site_ruby
    /opt/local/lib/ruby/vendor_ruby/1.8
    /opt/local/lib/ruby/vendor_ruby/1.8/i686-darwin10
    /opt/local/lib/ruby/vendor_ruby
    /opt/local/lib/ruby/1.8
    /opt/local/lib/ruby/1.8/i686-darwin10
    .
{% endhighlight %}

Now, compile command-t with the interpreter that matches vim's ruby lib:

{% highlight c %}
    $ cd ~/.vim/bundle/command-t 
    # cd into dir containing extconf.rb (if necessary):
    $ cd `dirname \`find . -name "extconf.rb"\`` 

    $ /opt/local/bin/ruby extconf.rb 
    $ make
{% endhighlight %}

Test vim works

{% highlight c %}
    $ vim
{% endhighlight %}
    
    :)

