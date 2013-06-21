---
layout: post
title: Dynamic Inheritance In Python
---

Dynamic Inheritance is useful when you need to instantiate an object whose base class is only known at the time of instantiation.

For instance, I have a few different sequences:

{% highlight python %}
    a = [1,2,3]
    print type(a)

    b = (4,5,6)
    print type(b)

    c = {7:1, 8:1, 9:1}
    print type(c)
{% endhighlight %}

And I want to instantiate an object that inherits the same class as one of the above input sequences.  Unfortunately, I can't know which sequence I will inherit from until the program is about to instantiate my object.

Rather than answering the question outright, this post will explain how dynamic inheritance works by example, but will leave the particular implementation of this problem to the reader.  So\u2026 how can one dynamically inherit a class at time of instantiation?

One option is to define a factory function and a nested class definition to dynamically build and return a class:


{% highlight python %}
    def make(cls):
        """Return a NewClass that inherits from given class object (not an instance of a class)"""

        class NewClass(cls): pass
        return NewClass

    NewClass = make(list)
    print NewClass.__bases__ # the list of classes NewClass inherits from

    newclass_instance = NewClass([1,2,3])
{% endhighlight %}


Taking this a step further, you can return an instance that dynamically inherits a class type:

{% highlight python %}
    def makeinst(cls, *args, **kwargs):
        """Return an instance of NewClass that inherits from given cls, initialized with given params"""
        class NewClass(cls): pass
        return NewClass(*args, **kwargs)

    newclass_instance = makeinst(list, (4,5,6))
{% endhighlight %}

Which leads us to implement a MixIn: (This means that the cls will have all its methods + the methods in the mixin at its disposal. Super useful!)

{% highlight python %}
    def makeWithMixin(cls, mixin):
        class NewClass(cls, mixin): pass
        #rename class
        NewClass.__name__ = "%s_%s" % (cls.__name__, mixin.__name__)
        return NewClass

    class Car(object): pass
    truck = makeWithMixin(Car, list)
{% endhighlight %}

This is how you would add multiple mixins at once: (Note that the following example doesn't work when the underlying C structure for each class type is different).

{% highlight python %}
    def makeWithMixins(cls, mixins):
        for mixin in mixins:
            if mixin not in cls.__bases__:
                cls.__bases__ = (mixin,) + cls.__bases__
            else:
                print "Cannot add %s to %s" % (mixin, cls)
        return cls

    # workaround for http://bugs.python.org/issue672115
    class object(object): pass

    class Car(object): pass
    class Submarine(object): a = 1
    class Plane(object): b = 1
    mixedlist = makeWithMixins(Car, (Submarine, Plane))
{% endhighlight %}

Or you can pass in an instance and let your NewClass inherit the same type that the instance is.

{% highlight python %}
    def makeinst2(instance):
        class NewClass(instance.__class__): pass
        # assume instance.__init__(instance.__repr__()) will work
        return NewClass(instance)
{% endhighlight %}

As you can see, there are several variations of saying, more or less, the same thing.  The above code shows you how to mash classes together using inheritance.  The approach of using a nested class inside a function isn't the only approach.  Python's type() builtin provides really cool builtin ways of doing this:

The builtin, type, can also make class objects dynamically:

{% highlight python %}
    name = 'NewClass'
    bases = (list, )
    dict = argparse.Namespace()
    NewClass = type(name, bases, dict)

    newclass_instance = NewClass([1,2,3])
{% endhighlight %}

For further details, you might also want to checkout the __new__ method.  And python metaprogramming
