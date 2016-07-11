---
layout: post
title: A foray into bike lights, from front to back.
---

Conceptually, a bike light can seem simple: a bit of wires, a battery
and light bulb.  But take a closer look at one.  There is a lot going on
in there.  Voltages are changing thousands of times a second, debouncing
algorithms distinguish between user interaction and noise, power
electronics limit current draw through the LED.  While a bike light can
seem astoundingly simple, a bit of inspection reveals that the simplest
light hides an incredible amount of complexity and is the result of
research from many disciplines.  A bike light isn't just a useful physical
object, it is a gateway to research and discovery.

I would like to share with you my ongoing project to build and explore
bike lights.  I will present this topic as series of blog posts.  My
overall goal is two-fold:  First, I want to present to you a basic
knowledge of electronics, probability, engineering and programming so
that you may be inspired to start a project of your own.  Second, I am
excited to highlight some of the concepts, algorithms, and mathematics
hidden behind such a deceptively simple topic.  I hope you will join me
in this adventure and peek into a deep and fascinating world.

The audience for these posts varies depending on the topic.
Hopefully, someone generally interested in electronics, probability,
software and hardware can enjoy these posts.

Here is a "table of contents" for the upcoming series.  I will write
these posts out of order and link to them here:

1. [Surveying bike light components](/2016/07/09/surveying-bike-light-components):

    > The series begins by introducing the components of a typical bike
light and reviewing how these components work and what challenges they
introduce.  Think of it as a survey of relevant hardware components.

1. A deeper dive into the process of creating a constant current circuit
   to drive the LED.  We will lightly review how the circuit works and
use a few important equations for choosing components of the circuit.

1. AVR programming an ATTiny85 microcontroller without Arduino

1. PWM and debouncing on an AVR microcontroller

1. Presenting my first 2 simple white bike light builds and why the
   first one burned out.

1. Circuit design and concept for a "smart" brake light.

1. An algorithm for a "smart" brake light using rolling averages, the Z score,
   and the binomial probability mass function.

1. An algorithm to calculate moving averages of a timeseries in an
   extremely low memory environment.

1. The problem with 3 dimensional accelerometer readings to account for
   road bumps, inclines, turns.  Research experiments and potential next steps.
