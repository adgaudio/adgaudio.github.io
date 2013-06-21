---
layout: post
title: Probability Mass Function of a Binomial Distribution (PMF)
---

This post is part 2 of my previous one: [Frequently Ocurring Pairs and the n-choose-k-Problem](http://127.0.0.1:8000/blog/frequently-ocurring-pairs-and-n-choose-k-problem).

In part 1, we derived an equation for ${n\choose k}$, or the number of k-element combinations from a group of size $n$ by thinking about permutations and combinations.  In this post, we'll use this knowledge and some probability to identify which specific pairs occur more than $K$ times in our collection of size $n$.  A key difference between this and last post is that previously we knew only the number of elements in our data set.  In this post, our input is a collection of $n$ elements.

In the earlier post, we figured out the number of $k$-element pairs in a set of size $n$: 
$${n\choose k} = \frac{n!}{k!(n-k)!}$$  

In this post, we'll cover the probability mass function, where K is the number of occurrences of a particular pair (of any size), and N is the number of observations we make:

$$ \begin{eqnarray*}
 \text{pmf} & = & p(K \text{ successes in } N \text{ trials}) \\\
& = & {N\choose K} * p^K * (1-p)^{N-K}
\end{eqnarray*}
 $$

>> Note that the similarity between variables $k$, $K$, $n$ and $N$ may be confusing, but I am trying maintain similarity with the notation you might find on Wikipedia.  Specifically, $n$ individual elements are grouped into k-element pairings.  The collection of all k-element pairs that can be made from $n$ elements has a size of $N$ and the k-element pairs can be grouped into arbitrary sizes, $K$.

For the sake of this post, let's assume that the occurrence of any pair is independent of the occurrence of any other.  In other words, occurrence of one event (ie the k-element pair) has absolutely no influence on the occurrence of any other event (ie any other k-element pair), and this applies to all events in our space (of size $N$).  This assumption leads us to the very useful insight that we don't have to care about what other k-element pairs exist (or don't exist) when questioning whether a particular k-element pair exists.

So how do we know whether a k-element pair exists?  In other words, what is the probability of a k-element pair?  Imagine we have a set of $N$ unique elements, and then pop a pair out of the set.  In this case, we could say that there is a $1/N$ chance that our pair is equal to any particular pair in the set that we've already chosen.  Now let's complicate things by saying that our collection of $N$ elements is no longer unique.  If we were to pop one k-element pair out of the set, we certainly could not say that there is a $1/N$ chance that our pair is equal to some particular pair in the collection, because we don't know what fraction of the collection that any particular pair represents.  Rewording this a little, we can say that the probability of pulling one particular pair in the set depends on how many duplicates of that particular pair exist in the collection, or more specifically, 

$$
\begin{eqnarray*}
p(\text{pair}) \\\
& = & p(\text{1st dup pair}) \text{ OR } p(\text{2nd dup pair}) \text{ OR }  \ldots \text{ OR }  p(\text{m-th dup pair}) \\\
& = & p(\text{pair}) + p(\text{2nd dup pair}) + \ldots + p(\text{m-th dup pair}) \\\
& = &p(\text{pair}) * (\text{num duplicates}) \\\
& = &(1/N) * (\text{num duplicates}) \\\
\end{eqnarray*}
$$

>> The individual probabilities of each duplicate pair are the same because we've assumed that the occurrence of any pair is completely independent of the other.  If we considered conditional dependence, each $p(\text{ith dup pair})$ would depend on other elements and this blog post is probably irrelevant unless $n$ is very large.

As you can see above, we've defined the probability of pulling a particular k-element pair from the collection of pairs.  If we counted the number of occurrences of each pair, we'd be able to find the probability of each pair.  In this case, the most likely pair would be the most frequently occurring one, which basically solves the original task to find the most frequently occurring pairs.  However, this wouldn't give a clear minimum number to "most frequent."  In our case, we want to be able to say, "which k-element pairs occur at least $K$ times with high probability?"

At this point, we have two important problems.  As we saw in the previous post, it quickly becomes unfeasible to enumerate all possible k-element pairs in a larger collection because the number of pairs will skyrocket as the number of distinct elements in the collection increases (the n choose k problem).  This problem is a sampling problem, and that is outside of our scope here.  However, we can imagine (as an exercise for another blog post, perhaps) that we've sampled a subset of our collection to choose relevant k-element pairs and assign each pair a probability.  Second, we haven't figured out the probability that an event (k-element pair) will occur exactly $K$ times in a collection of individual elements.  We will solve the second problem and use our new knowledge to find pairs that occur more than K times.

So moving on, let's figure out the probability that an event, or a particular k-element pair, will occur exactly once ($K = 1$) and only on the first trial.  This means that the event will happen the first time and it won't happen ever again.  (This also implies that we know how many events there are, but we'll go over that later).  If an "event" is defined as the presence of a k-element pair, then the probability that it occurs once is the probability of having the pair, $p(\text{pair})$, and the probability of not having a pair, $p(\text{not pair})$, for all remaining events, $p(\text{not pair}) ** (\text{num events} - 1)$.  Combining this into one mathematical statement:

$$
\begin{eqnarray*}
p(\text{pair occurs exactly once}) \\\
& = & p(\text{pair}) \text{ AND } \Bigg(p(\text{not pair}) \text{ AND } p(\text{not pair})  \text{ AND } \ldots \Bigg) \\\
& = & p(\text{pair}) * p(\text{not pair})^{(\text{N} - 1)} \\\
\end{eqnarray*}
$$

What if we wanted the event to occur on only the first and second trial?

$$
\begin{eqnarray*}
p(\text{pair occurs exactly twice}) \\\
& = & p(\text{pair}) \text{ AND } p(\text{pair}) \text{ AND } \Bigg( p(\text{not pair})  \text{ AND } \ldots \Bigg) \\\
& = & p(\text{pair})^2 * p(\text{not pair})^{(\text{N} - 2)} \\\
\end{eqnarray*}
$$

We can abstract the pattern and note that $p(\text{not pair}) = 1 - p(\text{pair})$:

$$
\begin{eqnarray*}
p(\text{pair occurs K times}) \\\
& = & p(\text{pair})^\text{K} * (1-p(\text{pair}))^{N - K}
\end{eqnarray*}
$$

What we have just created is an equation for the probability that a particular k-element pair will occur on the the first trial and never again.  This means that if we had a collection of pairs, we can determine the (very small) probability that we'll see a particular pair once in our observations, and it will be precisely the first pair we observed.  This is pretty cool but entirely useless to us as is.  What we really want is to find the probability that a pair occurs once in all our observations, but we don't care if it appears first or last, and this is deceptively simple:

Imagine that we could enumerate all k-element pairs in a collection of $n$ elements, and therefore the size, $N$, of that enumerated collection is $N = {n \choose k}$.  The first time around, we look at $N$ k-element pairs and the first pair is $X$.  Then, we look at the same $N$ k-element pairs again, and $X$ is the second pair.  Imagine we do this $N$ times and see $X$ appear exactly once in each of the $N$ possible positions.  In this case, the probability that $X$ occurs exactly once (ie $K = 1$) anywhere in the set is:

$$
\begin{eqnarray*}
&p(&\text{pair occurs exactly once in n observations}) \\\
&=&p(\text{pair occurs only 1st}) \text{ OR } p(\text{pair occurs only 2nd}) \text{ OR } \ldots \\\
\end{eqnarray*}
$$

Now we're onto something!  If we were to expand this out to the pair happening exactly twice ($K=2$), we'd suddenly have a much larger, but very similar problem.  In fact, we'd have an $N$ choose $K=2$ possible number of scenarios.

$$
\begin{eqnarray*}
&p(&\text{pair occurs exactly twice in n observations}) \\\
&=&p(\text{pair occurs only 1st and 2nd}) \text{ OR } p(\text{pair occurs only 1st and 3rd}) \text{ OR } \ldots \\\
&\ldots& \text { OR } p(\text{pair occurs only 2nd and 3rd}) \text { OR } \ldots \\\
\end{eqnarray*}
$$

The count of terms separated by $\text{ OR }$ in the above expression is equal to the number of $K$ groupings (1st and 2nd, 1nd and 3rd, 2nd and 3rd, etc) that exist in the set of all $N$ pairs, or specifically, $N \choose K$ pairs.  (Remember: $N = {n \choose k}$, so we can also write ${n\choose k}\choose K$).  Knowing this, we can simply say that:

$$
\begin{eqnarray*}
\text{pmf} & = & p(K \text{ successes in } N \text{ trials}) \\\
&=& {N \choose K} * p(\text{k-element pair occurs exactly K times}) \\\
&=& {N \choose K} * p(\text{k-element pair})^K * (1-p(\text{k-element pair}))^{N - 1} \\\
\end{eqnarray*}
$$

Great, we've just recreated the probability mass function for a binomial distribution!  If we set, say, K=10 and plug in a $p(\text{pair})$ value, we will know the likelihood that a pair will occur exactly 10 times.   If we repeat with K=11, we'll see the probability either increase or decrease.  If the pmf value increases when K does, then we know that the most likely frequency for the pair is greater than 10, and otherwise, we're most likely to see the pair 10 or fewer times.  We can perform this comparison for the pairs we have a hunch are most frequent (say we sampled a random subset of the input data set and assigned a probability to the relevant found pairs) and filter from those the ones whose pmf value is increasing between K=10 and K=11.  In other words, we want only the k-element pairs that are most likely to appear more than 10 times.  And there you have it!
