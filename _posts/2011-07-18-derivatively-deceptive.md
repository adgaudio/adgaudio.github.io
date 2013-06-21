---
layout: post
title: Derivatively Deceptive!
---

*A conceptual explanation of derivatives, partial derivatives, directional derivatives, and differential equations*

A derivative can be thought of as a result of comparing two quantities that change with respect to one another. 

Imagine a graph with an arbitrarily chosen domain, x, and range, y, and imagine that we plot some function, f, in this plane.   This function can only tell you the resulting y for any given any x; it cannot explicitly say whether the next y value is 'increasing' or 'decreasing.' 

Enter the derivative:  The derivative is a value (returned by the derivative operator) that describes how y changes as you progress through every value of x.  More specifically, the derivative determines how much y is changing (increasing or decreasing) relative to a constantly changing x.  Because the relationship between x and y is relative, we can switch our point of view to say the derivative also tells us whether x is changing more or less than the change in y.  A derivative operator is a function that returns a derivative, or a single value describing how much more (or less) one variable is changing than the other variable in the given original function.

There are derivatives of derivatives.  This is also like saying there are functions of functions.  In terms of our original function on the x,y plane, the first derivative can be seen as a value that describes how y changes with respect to x.  The 2nd derivative, then, describes how the first derivative changes in respect to x, or how the change in y changes with respect to x.  The 3rd and 4th derivatives follow in the same manner.  Every derivative is the result of passing an input to the derivative operator.

A real world application of this concept is plotting velocity as distance (y) over time (x) in the x,y plane.  If velocity is a derivative of the position, defined by funtion g, acceleration is the derivative of g at a given time, and rate of change of acceleration is the next derivative after that.

Partial derivatives are taken for functions with multiple inputs( for instance, f(x,z) = y ) where we assume that one of the variables is constant.  If we assume that z is constant for a given x, then we can find the derivative (ie the change in y given x).  This is a partial derivative.

A directional derivative is a generalization of the partial derivative.  It describes the change in y when both x and z are changing.  Imagine we are plotting a 3-D manifold (a 3D object that passes the vertical line test) in the x,y,z coordinate system.  Now, slice the object on the (x,z) plane.  Here, if we have found all the partial derivatives for one given z, then we have calculated all the partial derivatives  (change in y for this x) on the x axis.  Similarly, if we find all partial derivatives given one x, we have a group of partial derivatives on the z axis.  What this means is that we can define a (x,z) plane containing all the groups of partial derivatives on the z axis (given every x) and all the groups of partial derivatives on the x axis (given every z).  Taking this a step further, for a given point in the (x,z) plane, we can define a vector that determines how much to weight to place the partial derivative given z and the partial derivative given x.  The value of this vector is the directional derivative.

Derivative notation: The 4 main notations are named after their creators: Leibniz, Lagrange, Newton, Euler.  You should Wikipedia 'Derivative' for the math and symbols.

Lastly, and probably too briefly, differential equations: A differential equation states that the sum of all derivatives for a given function defines the given function.  So, solving a differential equation is usually a matter of identifying all the derivatives that make up a function.  In many cases, there are an infinite or unknown amount of derivatives, but in simple equations, there are only one or two derivatives (the rest are equal to zero). 

---

If you're still interested, get your hands dirty with some math!  
