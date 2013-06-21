---
layout: post
title: IPython Shell Integration
---

This post shows you how to take IPython's sweet bash/shell integration to another level.  Of particular interest is my last example, which utilizes IPython's syntax and bash integration to create a scripting language that supports pure Python + IPython features + bash (as supported by IPython).

##### First off, some distinctions: IPython has aliases, macros, and magics.  They are different things. 

* Aliases are shortcuts to bash commands that get piped out to the os in a subprocess.  One alias is a tuple. ie. ("showmydirectory", "ls").  
* Macros are shortcuts to python code stored as a string.  They are editable via the '%edit' magic command
* Magics are functions special to IPython that take parameters and utilize IPython internals to do helpful things.  They can be identified by the '%' at the beginning.

##### On to some code:

1. Import everything within your path that is executable as an IPython alias.  This means you can use bash commands like 'git status' or 'tail -f somefilename | grep something' without explicitly using the '!' to define a bash command. 

~~~ python
        In [1]: %rehashx # rehashx is a magic function
~~~

2. Define an IPython alias within the IPython Interpreter.

~~~ python
        In [2]: touch myfile
    
        In [3]: a = get_ipython()
    
        In [4]: a.alias_manager.define_alias('foo', 'ls %s')
    
        In [5]: foo myfile
        myfile
~~~

3. Profile Customization: Automatically port bash aliases and run the magic, %rehashx, on startup. 
    
    Add the following code to your config file

~~~ python
        # your config file is probably here
        $ ls ~/.config/ipython/profile_default/ipython_config.py)
~~~

    Note: you can also just run this interactively in the IPython interpreter.

~~~ python
        # Add all of the following code to your ipython config file

        c = get_config()

        # Port bash aliases to ipython
        import os
        a = os.popen("bash -l -c 'alias'").read()
        a = a.replace('=',' ').replace('"','''"').replace("'",''"'").split('alias ')
        a =  [tuple(x.strip().split(' ', 1)) for x in a]
        c.AliasManager.user_aliases = [x for x in a if len(x) == 2]
~~~

4. Use IPython as a system shell, and integrate bash code with python code!

~~~ python
        In [6]: !echo 'some data\n0 1 2 3\n4 5 6\n7 8 9' > myfile

        In [7]: !!tail myfile
        Out[7]: ['some data', '0 1 2 3', '4 5 6', '7 8 9']

        In [8]: _ #access to your output history. for details, type hist? at the ipython prompt
        Out[8]: ['some data', '0 1 2 3', '4 5 6', '7 8 9']

        In [9]: a = !ls -l # store bash output as a python variable

        In [10]: b ='from ipython' ; c = ' and me'

        In [11]: !echo 'hello $b' # use python variables in bash cmds
        hello from ipython

        In [12]: !echo 'hello ${b + c}' # embed python code into the bash code
        hello from ipython and me
~~~

    Using SList, you can do all sorts of transformations on output from bash commands.

~~~ python
        In [14]: touch myfile # if you get a SyntaxError, perhaps you didn't use %rehashx?
        In [15]: mkdir mydir

        In [16]: a = !ls -dl myfile mydir

        In [17]: print type(a)
         class 'IPython.utils.text.SList'>

        In [18]: a.fields()
        Out[18]:
        ['drwxr-xr-x', '2', 'agaudio', 'staff', '68', 'Oct', '2', '15:38', 'mydir'],
        ['-rw-r--r--', '1', 'agaudio', 'staff', '30', 'Oct', '2', '15:35', 'myfile']]

        In [19]: a.fields(-1)
        Out[19]: ['mydir', 'myfile']

        In [20]: a.grep(r'^d') # regular expression grep
        Out[20]: ['drwxr-xr-x  2 agaudio  staff  68 Oct  2 15:38 mydir']

        # return list of filepaths for all directories returned by ls -l
        In [21]: a.grep(r'^d').fields(-1).p 
        Out[21]: [path(u'mydir')]
~~~

5. A whole new replacement for python (and bash) scripting!  Supports pure python + IPython + bash (as it works in IPython)

    <a href="https://github.com/adgaudio/My-Code/blob/master/projects/ipython_scripting/ipyscript.py" target="_blank">Use this program to execute scripts</a>

    <a href="https://github.com/adgaudio/My-Code/blob/master/projects/ipython_scripting/example.ipy" target="_blank">An example script</a>

    Execute script

~~~ c
         $ chmod +x ipyscript.py
         $ ./ipyscript example.ipy
~~~

    * Note: There is also a method in IPython core that (I believe) attempts to achieve a similar effect:

~~~ python
            In [1]: IPython.core.interactiveshell.InteractiveShell.safe_execfile_ipy??
        
            # This can be accessed like this:
            In [2]: c = get_ipython()
    
            In [3]: c.safe_execfile_ipy('./example.ipy')
~~~
        
Unfortunately, it doesn't work very well

##### For more tips
Checkout the notes for my talk on tmux and ipython:

~~~ python
        git clone https://github.com/adgaudio/Tmux-IPython-Talk.git
~~~

Or the video of my talk: <a href="http://blip.tv/pygotham/tmux-ipython-awesome-5586324">HERE (python in the second half)</a>

