---
layout: post
title: Excel to CSV easy solution
---

Converting an excel doc to a csv format that Mac OSX can be a pain in the ass every once in a while.  For those of you who have issues, I have found the solution! 


The Problem:

Line parsing.  Mac apps (like Excel and Textmate, etc) read and write line endings as carriage returns.  Terminal/unix programs read and write line endings as line feeds.

Line feed is represented as:
    \n
    10 (ascii ordinal value)
    0xa (hex)

Carriage return is represented as:
    \r
    13 (ascii ordinal value)
    0xd


The Solutions:

Luckily, this isn't that complicated.  Basically, you need to convert \r to \n, and there a several ways to do this.

1.   Change the shell encoding to a format that can read carriage returns, and then find and replace carriage returns

{% highlight c %}
    $ LANG=en_US.ISO8859-1 tr '\r' '\n' &lt; INPUT.csv &gt; OUTPUT.csv
{% endhighlight %}

2. dos2unix - a terminal program that comes with a whole set of tools to basically automate the above code

    Assuming you have dos2unix installed:

{% highlight c %}
    $ dos2unix INPUT.csv > OUTPUT.csv
{% endhighlight %}

3. TextMate - If you prefer GUI, you can open the csv in TextMate and "Save As" csv with "LF" line endings

