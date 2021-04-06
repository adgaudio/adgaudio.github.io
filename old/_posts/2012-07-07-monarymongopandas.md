---
layout: post
title: Monary+Mongo+Pandas = :)
---

A lot of people such as myself waste time getting mongo data into numpy or pandas data structures.

You could do it using pymongo.  The general process would be to initialize the pymongo driver and make a query, wait for pymongo to convert stuff into lists of son (bson) objects (aka dictionaries), parse the data into arrays, and then copy it into some numpy array.  But work's been done for you already, so why do it again?

Thanks to [djcbeach](https://bitbucket.org/djcbeach/monary/wiki/Home), we have a nifty little module that utilizes mongo's C driver, the bson C library and python's ctypes module to load data directly into numpy arrays.  Its fast and easy!  From there, we can pass this into Wes McKinney's [pandas](http://pandas.pydata.org/) dataframe and be very, very happy.  

Lets look into this, shall we?

1. Assuming you have numpy already and a mongo server, install Monary.  Dont use pip, because the module isn't even in the cheeseshop.

{% highlight c %}
        $ hg clone ssh://hg@bitbucket.org/djcbeach/monary ./monary
        $ cd ./monary && python setup.py install
{% endhighlight %}

1. Make a db conneciton

{% highlight python %}
        $ python
        >>> from monary import Monary
        >>> mon = Monary() # connection to localhost
{% endhighlight %}

1.  Make a query and receive numpy arrays

{% highlight python %}
        >>> columns = ['field1', 'field2', 'field3']
        >>> numpy_arrays = mon.query('mydb', 
                        'mycollection', 
                        {'field1':'query_stuff'},
                        columns, 
                        ['int32', 'date', 'string:20'])
{% endhighlight %}

1. For ultimate happiness, pass this into a pandas DataFrame (assuming you've also installed pandas)

{% highlight python %}
        >>> import numpy
        >>> import pandas
        >>> df = numpy.matrix(arrs).transpose() 
        >>> df = pandas.DataFrame(df, columns=columns)
{% endhighlight %}

I don't think I could safely do a benchmark comparison to pymongo and not feel stupid about it, but if you were interested in seeing where this process spends most time, check this out:

I put the above code into a function called get_tu which populates 5 columns each with 1,200,000 rows of data (non NAN), and most of the ~2 seconds it took was waiting on mongo. (FYI - I'm using mongo 2.1.3-pre, returns data for this query ~.5 seconds faster than the current stable version of mongo)


{% highlight python %}
        In [53]: %prun -s cumulative main.get_tu()


   342 function calls in 2.221 seconds                                                                               

   Ordered by: cumulative time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.013    0.013    2.221    2.221 &lt;string&gt;:1(&lt;module&gt;)
        1    0.000    0.000    2.208    2.208 main.py:29(get_tu)
        1    1.569    1.569    1.588    1.588 monary.py:283(query)
       14    0.616    0.044    0.616    0.044 {numpy.core.multiarray.array}
        1    0.000    0.000    0.616    0.616 defmatrix.py:233(__new__)
        1    0.000    0.000    0.018    0.018 monary.py:231(_make_column_data)
        5    0.014    0.003    0.014    0.003 {numpy.core.multiarray.zeros}
        1    0.000    0.000    0.004    0.004 frame.py:323(__init__)
        5    0.000    0.000    0.004    0.001 numeric.py:1791(ones)
        5    0.004    0.001    0.004    0.001 {method 'fill' of 'numpy.ndarray' objects}
{% endhighlight %}
