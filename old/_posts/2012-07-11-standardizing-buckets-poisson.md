---
layout: post
title: Standardizing buckets with Poisson
---

So I did a fun project a little while ago at work using a Poisson regression to standardize a bunch of data buckets, and decided that I should share it in the interest of solidifying my own understanding of the concepts, and (hopefully) helping someone who may also find this topic exciting.  [wikipedia Poisson distribution](http://en.wikipedia.org/wiki/Poisson_distribution) and [wikipedia: Poisson regression](http://en.wikipedia.org/wiki/Poisson_regression).

The problem: We have 1.7 million ads targeting users of different ages.  So for example, one age bucket targets 15 to 20 year olds, and other might target 16 to 18 year olds.  Each ad also has performance information, such as the number of clicks or impressions it received.  The task is to break these non-standard age buckets into standardized age ranges and estimate any given feature accordingly.  This is a perfect opportunity for the Poisson distribution!  Mathematically, the task is to figure out how to describe the distribution of a desired bucket by examining all of the buckets from the data set that included this desired bucket's age range.

    ie.  Go from this:  22-26 year olds -> 10 clicks, 23-25 year olds -> 4 clicks, ...
         To this:       22-23 year olds -> 3 clicks, 24-25 year olds -> 5 clicks, ...

More specifically, each relevant bucket - or relevant ad - has a probability mass function (ie fancy words meaning it's just a histogram) where each discrete age in the bucket's age range has a specific number of clicks or impressions that can be drawn from the poisson distribution for that ad.  This sampling step is the interesting part mathematically, because we can define it as a joint probability and do some transformations that give us computer-friendly numerical operations. Let me show you:

    p(ageY;bucketX) = poisson(ageY|bucketX) = lambda**ageY * e**(-lambda) / ageY!
    where lambda = mean of the distribution

and

    for all relevant buckets, for all ages:
      desired_bucket_distribution = p(age1;bucket1) * p(age1;bucket2) * 
                                    p(age2;bucket1) * p(age2;bucket2) * ... 

We take the log of everything, because there's no way in hell a computer can handle multiplying thousands of small probabilities.  (Log is great because it lets us add terms together, rather than multiply)

    log(desired_bucket_distribution) = log(p(ageY;bucketX)) + ... 
                                     = log(lambda**ageY * e**(-lambda) / ageY!) + ...
                                     = ageY * log(lambda) - lambda - log(ageY!) + ...

also, notice that we've isolated the factorial term, log(ageY!), from any of the lambdas, and that's also superhelpful, because according to [wikipedia](http://en.wikipedia.org/wiki/Poisson_regression#Maximum_likelihood-based_parameter_estimation) we can drop log(ageY!) from the equation.  I don't understand the reasoning, but wikipedia says because we are only trying to find the best value for lambda, and since log(ageY!) doesn't have a lambda component, we can drop the term.

                                     = ageY * log(lambda) - lambda + ...

Lastly, by summing these probability mass functions for all relevant ads and their age ranges, we define a new probability distribution (technically a log distribution) that defines our new desired bucket.  Performing gradient ascent on this distribution will ideally get you the log of the mean of the distribution and solves the original task of predicting a value for each desired age range.

Isn't that cool?!
