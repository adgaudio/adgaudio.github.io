---
layout: post
title: Frequently Ocurring Pairs and the N choose k problem
---

This post explores what ${N\choose k}$ means.

I was tasked a few days ago to identify the pairs of elements that occur in at least X lists data.  So how could we go about doing this?

Perhaps the more intuitive implementation (and computationally problematic) would be to find all possible pairs of elements and make a running tally of how many times each pair has occurred.  But for large data, this could be a problem for the following reason:

Supposing each list in the data contained 100 elements, there would be ${100\choose 2}$ different possible combinations.  ${100\choose 2}$ is a spiffy way of asking, "How many 2-element pairs can I make with these 100 elements," or perhaps more directly, "How many 2-element combinations can I make with 100 elements?"  In math terms, you say there are "N choose k," or "100 choose 2" combinations.

Thinking about this, you may have realized that for a large number of elements, the number of pairs gets large quickly.  Lets take a look at what ${N\choose k}$ means mathematically (...I just got LaTeX working with markdown, so bear with me!)

$$
\begin{eqnarray*}{n\choose k} & = & \mbox{(all k-element permutations of n)} * \frac{1}{\mbox{(number of duplicate combinations)}{!}} \\\
& = & \Bigg(n * (n-1) * (n-2) * \ldots\Bigg) * \frac{1}{k!}\\\
& = &\frac{n!}{(n-k)!} * \frac{1}{k!} \\\
\end{eqnarray*}
$$


Let's break down what this means.  Taking a permutation is like grouping the elements in different orderings.  So, an array like, $[a,b,c,d]$, would have these 3-element pairs (I chose 3 because it's larger than 2).  Notice that if we only looked at the first 2 elements, we see that each pair occurs multiple times.  In other words, if we group the (k+i)-element permutations into k-element permutations, we have lots of duplicates!

{::nomarkdown}
  <table border=0>
    <tr><td style="padding:1em;">
      $$
       \begin{array}{}\\\
      abc & abd \\\
      acb & acd \\\
      adb & adc \\\
      bac & bad \\\
      bca & bcd \\\
      bda & bdc \\\
      \ldots \\\
      \end{array}
      $$
    </td><td style="padding:1em;">
      $\overrightarrow{}$
    </td><td style="padding:1em;">
      $ \begin{array}{}\\\
      ab \\\ ac \\\ ad \\\
      ba \\\ bc \\\ bd \\\
      \ldots \\\
      \end{array}$
  </td></tr>
  </table>
{:/}


This idea of grouping elements is cool, because now we can see that 2-element permutations are a subset of 3-element permutations.  It also happens that the $(n-k)!$ term in the denominator of the "n choose k" formula above deduplicates these permutations.  Let's see how.  First, look at total possible number of permutations (ie k=n, or "n-element permutations").  Second, find the number of 2-element permutations.  Last, we can generalize a formula for finding the number of k-element permutations

1. Finding the number of permutations for an array of size n=4:  Conceptually, I like to think of this as recursively counting all the groups and groups of groups (etc) of elements.  What I mean by this is that if have our 4 element array, there would be a maximum of 4 1-element structures ($[a], [b], [c], [d]$), each of which expands to 3 2-element structures (ie for $a$: $[ab, ac, ad]$), each of which expands to 2 3-element structures (ie for $ab$: $[abc, abd]$), etc.  Applying this concept mathematically, the initial array has 4 (1-letter) groups, each of which expands to 3 2-letter groups.  Therefore, the total number of groups is $4 * 3 = 12$.  Each of those 3 groups further expands into 2 3-letter subgroups, giving us $4 * 3 * 2 * 1$.  Therefore, the number of permutations for an array of size n is $n!$.

2. By the logic above, finding the number of 2-element permutations in an array of size n=4 is super simple!  Each of 1-element structures expands 3 2-element structures, giving us a total of $4 * 3 = 12$ two element structures.

3. Generalizing steps 1 and 2, we can now find the number of k-element permutations in an array of size n!

    $$
    \begin{eqnarray*}\mbox{number of n-element permutations:} \\\
    n * (n-1) * (n-2) * \ldots * 1 & = & n! \\\
    \\\
    \mbox{number of 2-element permutations:} \\\
    n * (n-1) & = & n! / (n-2)! \\\
    \\\
    \mbox{generalized eqtn: number of k-element permutations:} \\\
    \frac{n!}{(n-k)!}\\\
    \end{eqnarray*}
    $$


There's one more step - the conversion of permutations to combinations.  Looking back all the 2 element permutations, we see that $ab$ and $ba$ are distinct pairs.  Permutations care about order.  Combinations, on the other hand, don't; $ab$ and $ba$ are the same thing.  In much the same way that we de-duplicated our permutations, now we must de-duplicate again.  The logic you use here is very similar.  Basically, the number of duplicate combinations for all k-element permutations in an array is the number of permutations for an array of length k.

$$
\begin{eqnarray*}
\mbox{generalized eqtn: number of k-element permutations} & = & \frac{n!}{(n-k)!}\\\
\mbox{number of duplicate k-element combinations} & = & k * (k-1) * (k-2) * \ldots * 1 \\\
\\\
\mbox{n choose k} = {n \choose k} & = & \frac{n!}{(n-k)!} * \frac{1}{k!}\\\
\end{eqnarray*}
$$


At the beginning of this post, I identified the N choose k problem as a reason why certain computations were inefficient.  To that point, check out how quickly the number of 2-element combinations increases for different sizes of n!


{::nomarkdown}
<table border=1px>
  <tr>
    <th>N</th>
    <th>Num combinations</th>
  </tr>
  <tr>
    <td>100</td><td>4950</td>
  </tr>
  <tr>
    <td>200</td><td>19900</td>
  </tr>
  <tr>
    <td>300</td><td>44850</td>
  </tr>
</table>
{:/}

For large n, the number of 2-element pairs we'd end up counting would be impractically large.  So large, in fact, that counting all those pairs is eventually impractical to fit in, say 4 or 8 gb of ram.  So how can we count frequently occurring k-element pairs?  In the next blog post, we'll explore answers to this question by learning about the Probability Mass Function of a binomial distribution and doing some probability!  See you then.
