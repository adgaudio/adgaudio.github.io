---
layout: post
title: Artificially Intelligent Yogurt Maker!
---

In this post, we're going to build a thermostat.  Thermostats are great things to know how to build, because they have a wide variety of uses: [Sous-vide](http://en.wikipedia.org/wiki/Sous-vide), home brewing, automating kiln temperature for pottery, making yogurt, adding temperature control to a soldering iron, smart fridges, etc.  The device described here can be used for all of the above.

You might be wondering what it is that makes a thermostat artificially intelligent.  Temperature control problems, and control theory in general, are surprisingly complex, but the problem is intuitively simple:  To make yogurt, we wish to heat a container of milk.  As we heat the milk, the milk particles closest to the heat source will  have a higher temperature than the rest of the liquid.  We've just recognized the milk container as a [dynamical system](http://en.wikipedia.org/wiki/Dynamical_system), where warmer particles are gradually moving towards colder particles over time.  Now let's say a temperature sensor is placed in the coldest corner of the milk container, and let's use this sensor to determine when to turn on the heating element.  Because the milk heats up unevenly, we will drastically over-heat our milk if we wait for the temperature sensor to reach the target temperature.  And to complicate the problem further, the rate of heat transfer across the milk is different at different temperatures.  So what can we do?

The [PID controller](http://en.wikipedia.org/wiki/PID_controller) is a thermostat (and generic control mechanism for dynamical systems) that takes into consideration three things: 


1. how far away the current measured temperature is from the target temperature
  - $$P = (currentTemp - targetTemp)$$
1. the history of temperature recordings
  - $$I = \int_0^{time} (temp_{time} - targetTemp)$$
  - How much have we been off by in the past?
1. and a measurement of how this error is changing
  - $$D = \frac{d}{d(time)}(currentTemp - targetTemp)$$
  - In the next split-second, will we go further away from our target, or closer to it?


PID, which stands for proportional-integral-derivative, combines these three things as a weighted sum to identify how far away from some target variable (a target temperature) we actually are.  

   $$ {Actual Error} = x_0*P + x_1*I + x_2*D$$

The $x$ values are simply weights that define how much we should value P over I or D.  In our case, $x$ values characterize how heat flows through our milk container.  If we can tune these values to the correct number, we will then have a clear estimate for how far away current container temperature is from our target temperature.  That estimate can then directly determine what percentage of the next 2 seconds (or any arbitrarily chosen period) the heating element should be turned on for.  Because the process for finding these $x$ values is laborious to determine by manual testing, people have developed several different (machine learning) algorithms to tune these parameters, and the actual process of using a PID controller is simply one of making predictions using the learned $x$ parameters.


The next section of this post is a tutorial describing how you can build your own yogurt maker.  We will use a PID controller to power an electrical (GFCI) outlet using electricity from a wall outlet.  You will need a few essential ingredients.

**NOTE: I take no responsibility for anything you do as a consequence of these instructions.  Proceed entirely at your own risk!**

- Power input/ground: your home's wall outlet and [3-prong plug + wire](http://www.amazon.com/Cables-Unlimted-6-feet-Mickey-Mouse/dp/B000234TYI/ref=sr_1_1?ie=UTF8&qid=1360520734&sr=8-1&keywords=3+prong+cord)
- Power output: [GFCI Outlet rated to 15A](http://www.amazon.com/Leviton-N7599-W-SmartLock-Non-Tamper-Resistant-Receptacle/dp/B0088XA58I/ref=sr_1_7?ie=UTF8&qid=1360519826&sr=8-7&keywords=gfci+outlet)
- [AC/DC Solid State Relay with heat sink](http://www.amazon.com/DC-AC-Solid-State-Relay-Heatsink/dp/B005K2IXHU/ref=sr_1_cc_3?s=aps&ie=UTF8&qid=1360520183&sr=1-3-catcorr&keywords=25a+solid+state+relay+heat+sink) and [thermal paste](http://www.amazon.com/Arctic-Silver-Polysynthetic-Thermal-Compound/dp/B0002VFXFE/ref=sr_1_1?ie=UTF8&qid=1360520555&sr=8-1&keywords=thermal+paste)
- [PID Controller](http://www.amazon.com/AGPtek%C2%AE-Universal-Temperature-Controller-Fahrenheit/dp/B007MMOEWY/ref=sr_1_4?ie=UTF8&qid=1360520952&sr=8-4&keywords=PID+controller)
- [Thermocouple (PT100, waterproof)](http://www.amazon.com/gp/product/B0052IGFZ4/ref=oh_details_o02_s00_i00).  You may need a different one for your project.
- Pretty enclosure box that you'd be comfortable making holes in  (I bought a plastic one from The Container Store and basically destroyed it trying to cut out holes)
- Spare wire (capable of sustaining at least 15A), crimp connectors, and a crimp tool.
- Optionally: [Wire Nut Connectors](http://www.amazon.com/Neiko-Wire-Nut-Connector-Assortment/dp/B000K7M35I/ref=pd_cp_hi_0)

Once you've collected the parts, it's time to put them together!  
**Before you start connecting components, triple check that everything is disconnected from a power source!**

The wiring diagram we'll follow should look something like this:

![Wiring Schematic for PID
controller](https://docs.google.com/drawings/d/1qveALLv8Jq3F9mkyogwh8JpCPrlEZ2nVHWoX5YzQ-3A/pub?w=753&h=383)

The AC power source, which comes from a wall outlet in your home and is
carried through the 3-prong plug, has 2 hot wires and 1 ground wire.
One of the hot leads (it doesn't matter which one) goes to two places:
directly into the AC side of the SSR relay, and also to one of the "AC
in" terminals of the PID controller.  The other hot lead connects to the
GFCI outlet, and also to the second "AC in" terminal on the PID
controller.  There are two ways to connect the wires: You can either
splice the hot leads with two spare wires (of sufficient gauge) using a
wire nut and then connect each end to the PID and relay, respectively.
The other option is to avoid splicing wires altogether by first
connecting each hot leads to its respective terminal on the relay, and
then connecting the PID "AC in" directly to that same terminal on the
relay.  I prefer to use the splice + wire nut method, because splicing
can make things much clearer.  The ground (green wire, typically)
connects to the GFCI ground.  If you aren't sure which 2 wires are the
hot ones, that's bad.  At this point, you need to be absolutely certain
which wire is ground and which ones are hot.  The hardest step here is
figuring out which terminals on the PID controller are the right ones.
Consult your PID controller manual for which ports are the relevant ones,
as different models have slightly different configurations.

Then, cut a section of spare wire.  The spare wire should be rated to at least the same amperage as your outlet.  The outlet listed above is rated to 15A.  18AWG wire can handle a maximum of 16A, according to [this site](http://www.powerstream.com/Wire_Size.htm), so that gauge should be fine for our purposes.  Connect one end to the available terminal on the AC side of the relay, and the other to the available terminal on the GFCI outlet.  

Third, cut two sections of spare wire.  With one wire, connect the "DC out +" terminal on the PID controller to the "DC +" terminal of the relay.  With the second wire, connect the PID controller's "DC out -" terminal to the relay's "DC -" terminal.  Your final wiring configuration should look like the image below.  For clarity, I removed the hot leads from the picture.  If you chose the wire nut route, you should have one hot lead connected to each wire nut, and ground connected to the GFCI outlet.  In this picture, the striped green wire is not ground.

![Diagram 1](http://farm8.staticflickr.com/7281/8746941960_3cb7797efd.jpg)

At this point, you should have wires connected to: all 4 terminals of the relay, all 3 terminals of the GFCI outlet, and 4 wires connected to the PID controller.  The last remaining step for the electrical side of things is to connect the thermocouple to the PID controller.  The thermocouple listed above has 3 wires, which correspond with three terminals on the PID controller.  The instruction sheet on your PID controller will tell you where to connect the thermocouple.

Great!  Now you should technically be able to plug the device into the wall and start using it.  Double check the wiring and then plug the 3-prong plug into the wall.  The PID controller should turn on.  When it does, evaluate that the temperature reading seems reasonably accurate, and that it changes when you touch the thermocouple.  Then, adjust some of the target temperature settings until you see the light on the relay (or your GFCI outlet, if it has one) turn on.  Once you pass this step, you know that everything is wired correctly.

The only remaining steps here are to mount the heat sink on the relay
using thermal compound and a couple screws (if the heat sink has screw
holes, which it should), and then to make your enclosure box.  Applying
thermal paste is fairly simple: Clean the relevant heat sink surface
(and relay bottom) with alcohol.  Dab a drop of thermal paste on the
heat sink.  Use a credit card to spread it evenly into a thin layer.
When the layer looks evenly distributed, plop the relay on top of it and
screw it onto the heat sink.  See a video of this on youtube:

<iframe width="560" height="315"
src="//www.youtube.com/embed/I3gx6c62D7I" frameborder="0"
allowfullscreen></iframe>

The enclosure box can be a pain in the ass if you don't have the proper tools.  I'll leave the design of that to you, since you will probably have different dimensions than I do.  I recently built my own 3d printer, so I may make my own enclosure the day I decide to build my own PID controller using an Arduino...  Otherwise, here's my final product! 

For a yogurt maker, simply connect a heating element (such as a crock pot) to the GFCI outlet, fill the crock pot with milk and a scoop of (non-honey flavored) yogurt, set the target temperature to 100 degrees Farenheit, and wait 5-7 hours.  In the last year, I've had really good success around 95 to 108 degrees F.  The lower end of the temperature range makes for a smoother, Wallaby-like yogurt, while brewing at the higher end results in chunkier yogurt.  The amount of time it's brewing for defines how sour tasting the whey will be.

![Yogurt Maker](http://farm8.staticflickr.com/7306/8746941858_a19afa1c49.jpg)
