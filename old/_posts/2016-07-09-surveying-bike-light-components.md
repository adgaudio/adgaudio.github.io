---
layout: post
title: Surveying bike light components
---

A simple search for bike lights on Google, at REI or in a bike shop will show
that lights made today consist of LEDs with a battery, button, electronics and
a reflective plastic lens.  From there, things begin to vary.  This post
surveys the basic components of a simple, generic bike light with two goals in
mind.  The first goal is to introduce basic knowledge necessary to begin
building a bike light: How do the basic components work at a high level?  What
kinds of challenges do these components introduce?  Learning how these
components work may provide some intuition about why so many variations of bike
light exist.  The second goal of this survey is to open the door for deeper and
more focused future blog posts as well as inspire my ongoing research into the
topic.

As the primary component of a bike light is an LED, it seems reasonable to
survey the LED first.  LED stands for Light Emitting Diode.  Being a diode, the
LED has some interesting properties.  One property of a light emitting diode is
that it will not emit light or sustain a noticeable current unless the voltage
across its two leads exceeds some threshold.  When the voltage exceeds the
threshold, the diode has almost 0 resistance and allows infinite current
(thereby also affecting voltage).  Since higher current through the diode
results in a brighter light and also in heat generated, the LED can quickly act
like a short circuit and burn out or catch fire.  Therefore, a mechanism must
exist to limit the maximum amount of current allowed to flow through the LED
when it is turned on.  Check Wikipedia for details about
[LEDs](https://en.wikipedia.org/wiki/Light-emitting_diode) and
[diodes](https://en.wikipedia.org/wiki/Diode).

The process of controlling the light output of an LED is typically referred to
as "driving an LED."  There are various ways to "drive" an LED, and different
LED drivers typically make choices that maximize energy efficiency and minimize
circuit complexity.  A driver must supply current to the LED, and secondly it
might also vary the light's brightness.  A very simple circuit to drive an LED
could use a resistor in line with the LED.  However, if the LED draws a lot of
power, it will waste a fair amount of electricity as heat in the resistor.
This inefficiency is costly in a battery operated system.  More complex
constant current (CC) circuits use two transistors and two resistors arranged
in a particular way that efficiently limits the max current through the diode.
There are a variety of ways to power LEDs, and the required power electronics
can be quite sophisticated!  I have not found many good tutorials on constant
current LED drivers, but [this
instructable](http://www.instructables.com/id/Power-LED-s---simplest-light-with-constant-current/?ALLSTEPS)
is enlightening, and [this pcbheaven.com
tutorial](http://www.pcbheaven.com/userpages/LED_driving_and_controlling_methods/)
is great.  A more helpful search term is "constant current circuit."

Dimming an LED, or changing its brightness, is also a feature of LED drivers.
Somewhat surprisingly, dimming is not as simple as one might think.  An
inefficient way to dim an LED is to reduce the current through it.  This
method, known as "analog dimming," is problematic because, as [DigiKey
explains](http://www.digikey.com/en/articles/techzone/2010/apr/how-to-dim-an-led),
"the regulator supplying the current to the LED must soak up any power not
supplied to the LED. [...] That power is wasted as heat."  Due to the issues
with the analog approach, a digital method has been developed called Pulse
Width Modulation (PWM).  PWM provides a way to represent an analog signal by
controlling the duty cycle of a square wave of high frequency.  In other words,
a square wave oscillates between high and low voltages.  When the square wave
goes high, the LED turns on; the LED is off when the square wave goes low.
This on-off cycle happens many times per second.  In each on-off cycle, known
as a wave's period, adjusting the proportion of that period spent in the high
region will adjust the perceived brightness.  This proportion is known as the
duty cycle, and a 70% duty cycle is brighter than a 20% duty cycle.  A
convenient way to think about PWM is to think of it as a "flicker" rate where
the duty cycle adjusts the percent of time the square wave is high.  In this
context, you may notice intuitively that if the frequency of a PWM signal is
low, it will flicker slowly enough that the human eye could see the individual
on-off cycles.  Low frequency PWM can be useful for power savings in some
contexts because faster clock speeds are associated with more energy usage.
High frequency PWM avoids flickering in LEDs.  Therefore, to adjust brightness,
we want a high frequency PWM signal with variable duty cycle.  Implementing PWM
in an embedded system is an elaborate topic, and several articles online are
dedicated to the topic.  We will dive into this in a future blog post.

Pursuing the LED topic further, it is important to recognize that there are
many different kinds of LEDs, both in terms of form factor and purpose.  One
distinction worth pointing out is high power vs low power leds.  In bike
lights, front lights use high power, super bright LEDs.  Cree and Luxeon Rebel
are common brands, for instance.  These diodes use more current (typically on
the order of 0.5 to 2 amps).  High power LEDs are so bright that they leave
white spots in your eyes for a few minutes if you look directly at them.
Because they draw so much current, they can get quite hot and are therefore
mounted on different kinds heat sinks typically using a thermal epoxy.  These
heat sinks themselves have a variety of shapes, sizes and materials.  Low power
LEDs, on the other hand, have different requirements.  These are more common as
red tail lights.  Because low power leds they they have much smaller demands on
power consumption, we can often replace complex constant current circuits with
resistors.  These LEDs can quickly burn out though if given an incorrect
voltage, and it is important to realize voltage varies quite a bit between
various colors (red is probably the only useful color for a bike light). Thus,
we can have high power LEDs for the front light and high or low power LEDs for
the back light.

Another distinction between LEDs is their forward voltage.  The forward voltage
is the voltage drop across leads of the LED when the nominal current flows
through it.  LEDs designed for battery operated settings (such as flashlights
and bike lights) tend to have a forward voltage of 3.6 volts, which is quite
similar to a standard voltage for Lithium batteries.  However, LEDs designed to
replace household Halogen bulbs (like the gu10 variety) will expect to run off
of a much higher voltage.  The gu10 bulbs I tested had a forward voltage of 9V.
GU10 bulbs are neat because they have perfect heat sinks for bike lights, but
the higher voltage requirement makes them a appealing choice.

Finally, on the topic of LEDs, it is also useful to consider how LEDs are sold
and packaged.  In general, the packaging methods for an LED component are the
same as they are for many electronic components.  Common forms for the surface
mount LEDs are as a "tape" or "roll" of tiny components that must be surface
mount soldered onto a heat sink.  Very small batches are sometimes sold in
ziploc bags.  The process of soldering a suface mounted LED onto anything is
quite complicated because the diodes are sensitive to heat and moisture.  Many
methods for soldering exist and are quite elaborate in production settings.  I
generally recommend avoiding surface mount soldering (SMD) of LEDs, though if
necessary, I recommend using solder paste and a hot air gun, and also watch a
few instructional Youtube videos.  The most common form of surface mount LED
sold to hobbyists is the "star" shaped heat sink with an LED already mounted
onto it.  I highly recommend these as a first start.  The form factor for
through-hole LEDs does not provide a means to sink heat, so through-hole LEDs
are low-power.  These are fairly straightforward.  Shopping online
for LEDs is probably the best way to learn more about varieties available.

Moving on from LEDs, we can enter the world of batteries and battery chargers.
For a bike light, the key considerations for a battery are its voltage, its
milli-amphere hour (mAh) rating, form factor, whether it is rechargeable and
its chemistry.  Picking an appropriate voltage battery depends on the voltage
requirements for the LED driver and other electronics.  Typically, a 3.6V
Lithium battery is a good choice.  The mAh rating for batteries, for marketing
purposes by battery vendors, is a unit of measurement that is mis-used to
represent battery capacity.  Milli-amphere hours technically is not a measure
of the battery's capacity, but a unit of charge that defines how much total
charge the battery contains.  An acceptable approximation of how many hours a
battery will last is to divide its mAh value by the mA consumption.  There is a
relationship between mAh and voltage worth knowning.  Specifically, placing
batteries in serial will add their voltages but not their mAh.  Conversely,
batteries in parallel have a constant voltage but increase in total mAh.

In terms of battery form factor, there are several shapes and sizes of
batteries, and size is often an important consideration in project design.
Naming conventions for battery form factors is messy.  However, for larger
cylindrical Lithium-ion batteries, the naming convention is fairly
straight-forward and useful.  According to
[Wikipedia](https://en.wikipedia.org/wiki/List_of_battery_sizes#Lithium-Ion_batteries_.28rechargeable.29),
"the larger rechargeable cells are typically assigned five-digit numbers, where
the first two digits are the (approximate) diameter in millimeters, followed by
the last three digits indicating the (approximate) height in tenths of
millimeters."  For instance, 18650 batteries popular in LED flashlights are
18mm in diameter and 65mm long.

Battery chemistry is very complicated and I have not studied it.  Chargers for
battery chemistries are also quite complicated and detailed.  Relevant facts Lithium
batteries are that they easily explode or catch fire if incorrectly charge,
they die if depleted beyond some minimum voltage, and they can emit huge
amounts of current.  To solve the minimum voltage problem, some batteries are
"protected" meaning they have integrated circuits that will prevent current
draw if the battery voltage drops below a minimum acceptable limit.  Protected
batteries are typically longer than unprotected batteries, and therefore this
is evident in the last 3 digits of their conventional names.

Regarding batteries, my recommendation for a bike light is to stick with one of
these 3 options:  Use 3.6 Lithium batteries for a high power LED, and consider
AA or AAA cells for low power LEDs.  Battery packs are also available and
decent options.  If Lithium, be aware of protected vs unprotected batteries.

Finally, as this post has grown quite long, I will briefly outline the topic of
buttons.  Buttons are, surprisingly, also a large topic.  I find the
distinction between a "button" and "switch" confusing, so I will define terms.
A button refers to any mechanism by which pressing it results in some action.
I consider a button as mechanical interface that activates a switch.  A switch
is any device that can open or close a circuit.  For instance, the "lock"
button in a wifi-enabled door lock might be an icon on your phone.  The switch
is the component on the door lock that receives the wifi message to "lock door"
and triggers the door lock.  In general, the process for choosing a button is
identify a possible design, then choose the appropriate switch for that design,
next implement a prototype and iterate on these steps until happy.  Different
kinds of switches exist, including reed, latching, momentary, rocker and
"button" switches.  [Read about them on
Wikipedia](https://en.wikipedia.org/wiki/Switch).  A bike light typically has
requirements that the button be waterproof or water resistant (see [Wikipedia
on IP ratings](https://en.wikipedia.org/wiki/IP_Code)).  Designing a
water-resistant button requires some creativity, and I'll cover my approach to
it in a future blog post.

One useful way to learn about switches is by shopping online (ie
[DigiKey](http://www.digikey.com/product-search/en/switches?keywords=)) and
reading the datasheets for the various products.  There are literally tens
of thousands of products available, which I find quite impressive.  I would
guess there are two reasons why so many switches exist.

First, switches they are cheap, easy to amass, often easy to swap out, and, I
presume, easy to manufacture.  When trying switches, designers do not need to
think as carefully about the specifications of the switch as they do about
other electric components such as transistors.  The second reason I think so
many products are available is that people (such as myself) naturally confuse
the "button" with the "switch." While buttons seem like simple, dumb
components, a button is not a switch.  The mentality that a button as a simple
topic not worth spending time on goes hand in hand with an unrealistic
expectation that a "ready to go" button should be available.  The reality,
though, is that designing a reliable button can be quite challenging as it
integrates with and often requires additional mechanical parts.  For instance,
I recently took apart my electric shaver and noticed that the "button"
component was directly integrated into the plastic body of the shaver;
certainly, a company like Digikey couldn't sell this button without advance
knowledge of that particular product's design.  The switch, however, was a
standard tactile switch.  I argue that a switch, unlike a button, is a clearly
defined and "ready to go" component.  As a result of the availability of
switches and the confusion between buttons and switches, people are eager to
try switches that also solve both the button design problem, when what they
should probably be doing is designing a button and then swapping out switches
that fit into the design.

The last topic on buttons and switches I'll bring up is that of debounce
algorithms.  Specifically, when a switch acts on a circuit, say to open or
close a circuit, it affects the circuit in a variety of ways.  Ideally, we
expect a switch simply to open the circuit or close the circuit.  In reality,
the switch has resistance, current and voltage limits, and will exhibit
complicated, probably chaotic, period of instability during state changes.
This reality can pose significant problems.  For instance, imagine a momentary
switch controls the power of a bike light.  When the button is pressed and
released, the light toggles on.  The problem arises in detecting what denoes a
"press" event and a "release" event, and debounce algorithms specialize in
solving this.  Specifically, when a momentary switch is pressed, a metal
contact flips into position such that it closes a circuit.  During the process
of flipping, the contact can close and open the circuit many times within a few
milliseconds until it stabilizes in the "closed circuit" state.  On release, a
similar process may happen.  I have not stumbled across research that explores
what actually happens to the circuit during the flip, but I imagine it is quite
complex and seeping with theoretical mathematics.  For practical purposes, we
simply need to create algorithms that identify the instability of the switch
and use that period to define when the switch is explicitly "pressed" and
"released."  There is an abundance of information about debounce algorithms and
their implementations available online.  [Here's one good
article](http://www.embedded.com/electronics-blogs/break-points/4024981/My-favorite-software-debouncers).

And that concludes our survey of bike light components!  As previously stated,
the primary goal of this post is to present a high level view of how the basic
components of a bike light work so we can both gain insights into the types of
challenges that these components introduce, and secondly, garner intuition for
why different variations components exist.  We discussed differe LEDs and
challenges of driving them.  We also discussed important factors in choosing
batteries, particularly Lithium ones.  We also exposed some often confused
intricacies between buttons and switches.  Careful readers will note that I
have not covered reflective lens design and materials for lights.  I have
chosen to skip discussion of reflective materials for the light because I have
not done much research into it.  I hope this post serves as useful starting
point for those undertaking similar projects.  Please follow feel free to check
out my other posts on this topic, by checking [this project's table of
contents](/2016/07/08/foray-into-bike-lights-from-front-to-back)!
