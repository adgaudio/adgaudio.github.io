---
layout: post
title: Design and Circuitry for a Smart Brake Light
---

Biking in New York often means traveling through highly congested areas.
Cyclists zip between cars on the road and contend with congested bike paths.
The path is fraught with obstacles.  One fear I have is an unexpected need to
brake quickly that causes an accident with the person behind me.  To minimize
this risk, I decided to build a brake light that responds to the bike's
movements.  Similarly to a car, the light should turn brighter red when
braking.  This post will explore the requirements and circuit design for the
brake light with a focus on how to choose components that work together.

A brake light can be designed in many different ways.  To constrain the
problem, I'll present my requirements for such a light.  First, I don't want a
complex installation.  The light should simply attach to a bag, seat post,
helmet or clothing.  I decided that connecting to the brake pad to detect
braking was too involved (this requirement made the problem much more
complicated).  Also, upon installation, the light could be oriented in any
position; it should operate properly if facing forwards, backwards, or any
other direction.  Third, the light should be able to detect brake events as
distinct from noise, and the algorithm should generally work for any vehicle,
not just bicycles.  Fourth, the light must operate on battery power for at least
an hour, and it should not be too heavy or complicated to recharge.  Last, I
assumed the device is energy efficient and designed for a resource constrained
environment.

My solution to these requirements was to detect brake events using an
accelerometer.  Specifically, a microcontroller can process accelerometer
readings to decide how to drive an LED.  If the accelerometer readings suggest
deceleration in the forward direction, the light should turn brighter red.  In
this circuit, the microcontroller reads data, processes it and operates an LED
driver.  This post presents a circuit design for this device.

<img src="/img/2016-07-15-bike-light-circuit-diagram.jpg" alt="Smart Brake Light Circuit Diagram" style="width: 85%;"/>

One caveat and note: Because I am not an electrical engineer, I heavily used
these two sites for instruction:  [PCBHeaven article explaining various
constant current drivers (link to page
4)](http://www.pcbheaven.com/userpages/LED_driving_and_controlling_methods/?topic=worklog&p=3)
and an [Instructable implementing a constant current
circuit](http://www.instructables.com/id/Circuits-for-using-High-Power-LED-s/?ALLSTEPS).
These links are excellent resources, but they missed some details.  This post
covers some details not well explained in those links, and focuses more
specifically on how to choose compatible components for the circuit.  I
recommend reviewing the PCBHeaven article before reading this article.

Firstly, how does the circuit work?  We can simplify the circuit into two
conceptual pieces: a current limiting circuit on the right, and logic
controlling it on the left.  The current limiting portion of this circuit
primarily contains 2 transistors, $Q_1$ and $Q_2$, and 2 resistors, $R_1$ and
$R_2$.  The PCBHeaven article describes quite nicely how these components work
together:  (I tweaked variable names R1 and R2)

    When power is applied, the gate resistor R1 turns on the MOSFET. This
    allows current to run through the LED, the MOSFET and the sensing resistor
    R2. As current increases, the voltage drop across R2 is increased as well.
    When this voltage drop reaches the base-emitter voltage of the transistor,
    the transistor is turned on. This will pull the MOSFET's gate
    to the ground turning it off. Therefore, the current through the LED is
    regulated to the one defined by the resistor R2.

The other portion of this circuit is fairly straightforward.  The IC controls
$R_1$ via a digital pin.  The LED toggles on when the pin changes high, and off
when the pin goes low.  The voltage regulator helps to stabilize the
accelerometer values.  Finally, I inserted an optional boost converter beside
the LED.  This is probably unnecessary and inefficient, but I added it because
in one experiment I used a 9V LED with a 3.6V battery.  I think the boost
converter will help stabilize LED brightness as the voltage in the battery
drains, but I have not tested this hypothesis.

With this basic understanding of the circuit in mind, we can begin to define
requirements of this circuit's design and show how choices of component
specifications affect these requirements.  Hopefully my description here will
help you better understand the circuitry.  I found this exercise a worthwhile
way to simultaneously learn and test my understanding of the circuitry.

We can start our goal to choose components for the circuit by choosing the LED
we want to use, say, the Cree XP-E Red LED
[(datasheet)](http://www.cree.com/~/media/Files/Cree/LED-Components-and-Modules/XLamp/Data-and-Binning/XLampXPE.pdf).
The datasheet specifies that the LED has a forward voltage of $V_{LED} = 2.3V$
at current $I_{LED} = 700mA$, and this is the maximum current rating for the
red LED.  Based on the datasheet, then, our target current for this particular
color should be less than or equal to 700mA.  The $I_{LED} = 0.7A$ will be
useful later.

Independently of our LED choice, we can also choose an appropriate $Q_1$
transistor.  Luckily, most common NPN transistors are appropriate.  The key
specification here is that the transistor's base-emitter saturation threshold
should be some small (but not too small) value.  It has to be small enough to
guarantee that the voltage potential at the MOSFET source is greater than the
transistor's base-emitter voltage ($V_{Q_{1BE}}$) but less than the
transistor's absolute maximum $V_{BE}$, as defined in its datasheet.  A small
value also has the advantage that less power is lost through $R_3$.  A very
useful way to think about this is with the following equation:  $$V_{battery} -
V_{LED} - V_{Q_{2DS}} - V_{Q_{1BE}} == 0$$.  This equation will appear again
during MOSFET and battery discussions.  Let's chose the transistor `2n3904`
([datasheet](https://www.sparkfun.com/datasheets/Components/2N3904.pdf)), which
has $V_{Q_{1BE}} = 0.65V$.

Having chosen a $Q_1$ transistor with known $V_{Q_{1BE}}$ as well as a max
current, $I_{LED}$, we can then choose the appropriate $R_3$.  As a reminder,
$R_3$ determines the maximum current through the LED.  So how can we choose the
appropriate resistor?  The key idea in this circuit is that $V_{Q_{1BE}}$
determines the voltage drop across $R_3$, or: $V_{R_{3}} == V_{Q_{1BE}}$.  We
can therefore derive that an ideal value for $R_3 = V_{R_{3}} / I_{R_{3}} =
0.65 / 0.7 = 0.92 \text{Ohms}$.  If we used a 1 ohm resistor, which is more
common than .92 ohms, the current through the LED would 0.65A (ie $0.65 / 1$).
Therefore, we will set $R_3$ equal to a 1ohm resistor.  The next consideration
for this resistor is its power rating.  Since, $P = I * V = 0.65 * .65 = 0.42W$,
we need a resistor rated for at least 1/2 watt; let's round up to 1 watt.  In
summary, $R_3$ is a 1 ohm, 1 watt resistor.

At this point, we've identified the LED, $Q_1$ and $R_2$ and we can now select
the MOSFET, or $Q_2$.  The [MOSFET](https://en.wikipedia.org/wiki/MOSFET) is a
transistor that uses a relatively small current to control a much larger
current load.  I found two requirements that determine if a MOSFET is usable in
this circuit.  The first requirement is that the maximum activation threshold,
or voltage between gate and source ($V_{GS}$ in datasheets), must be less than
the high voltage emitted by a pin on the IC.  If we assume the IC runs at 3.3V,
then the threshold should be smaller than that.  The second requirement is that
we respect the absolute maximum rating of its drain to source voltage and also
ensure we don't overheat the component.  It turns out that this has more to do
with our choice of battery; a higher voltage battery results in more power (and
heat) lost in the MOSFET.  I'll explain why this is the case.

The MOSFET in our circuit guarantees that the voltage drop between its drain
and source ($V_{Q_{2DS}}$) is sufficiently large to satisfy this equation we
saw before: $$V_{battery} - V_{LED} - V_{Q_{2DS}} - V_{Q_{1BE}} == 0$$.  You
might notice that, with $V_{LED}$ and $V_{Q_{1BE}}$ fixed, this essentially
comes down to choosing a battery voltage very close to $V_{LED} + V_{Q_{1BE}}$.
For instance, if we assumed that the battery voltage, $V_{battery}$ changes
between 3.6V and 4.2V, and we plug in the other previously determined values,
then: $0.65 \leq V_{Q_{2DS}} \leq 1.25$.  Clearly, a higher battery voltage
results in more power lost in the MOSFET.  We can evaluate the worst case power
draw from this component for the given max battery voltage as $P_{Q_{2}} = I * V =
I_{LED} * V_{Q_{2DS}} = 0.65 * 1.25 = 0.8$ watts.  And finally, we can estimate
the temperature of the MOSFET by plugging its rate of heat dissipation, $R_t$
into the equation $\text{Temp} = P * R_t = 0.8 * R_t$.  The MOSFET's datasheet
will give us an idea whether this temperature will require a heatsink.  I chose
to use the IRLB8743 MOSFET
([datasheet](http://www.infineon.com/dgdl/irlb8743pbf.pdf?fileId=5546d462533600a4015356605d6b2593)).
Without a heatsink, its $R_t = 62$ degrees C per watt, resulting in a very
acceptable temperature of 50.375 Celsius.

As previously mentioned, the battery's voltage should be just large enough to
power the IC and LED, but no larger because excess voltage is lost as heat in
the MOSFET.  I used 3.6V rechargeable Lithium Ion batteries.

Last but not least for the constant current components, we can choose almost
arbitrarily an $R_1$ resistor with a relatively high resistance.  When choosing
a resistor value, we simply want the maximum resistance that still provides
enough voltage potential to drive the MOSFET.  The PCBHeaven article suggests
.8 to 1mA of current.  For instance, if the IC pin voltage is 3.3V and the
MOSFET gate-source voltage is 2.35, we can calculate a desired $R_1 =
(V_{\text{IC_pin}} - V_{Q_{2GS}}) / .001 = 950 \text{ohms}$.  In practice, I
used a 10kOhm resistor and had no problems.

At this point, we have discussed all components except the IC, accelerometer
and voltage regulator.  I will only briefly cover my choices for these, as the
circuitry for them is simple.  The IC is an ATTiny85; the choice of
microcontroller doesn't really matter, though it's worth mentioning that the
chip works with the chosen battery voltage.  The accelerometer, ADXL335
([datasheet](https://www.sparkfun.com/datasheets/Components/SMD/adxl335.pdf)),
I found readily available and conveniently soldered onto a breakout board.  The
version I purchased was unregulated, and I added a low dropout (LDO) linear
regulator, AP7365
([datasheet](http://pdf1.alldatasheet.com/datasheet-pdf/view/351012/DIODES/AP7365.html)).
This regulator's datasheet requires two 1uF capacitors between IN-GND and
OUT-GND.  If the battery voltage is significantly far from the IC and
accelerometer voltage requirements, this kind of linear regulator may shed too
much power or overheat or temporarily disable itself.

I hope this description of the circuit was helpful and informative.  It took
quite a lot of research to figure out!  For those interested in building the
circuit, I am pasting the "cheat sheet" below:

Components for any color LED:

- LED: Cree XLamp XP-E Red 620-630NM w/20mm Star Base
- R1: 10k ohm (1/4W) resistor
- R2: 1 ohm (>=1W) resistor (choose this to determine current through LED)
- Q1: 2n3904 NPN transistor (VBE == VR3)
- Q2: IRLB8743 MOSFET
- Lithion Ion 3.6V battery
- Accelerometer: ADXL335 at 3V (find one with onboard regulator)
- Voltage Regulator: AP7365 and 2 1uF capacitors (only if accelerometer doesn't already have onboard regulator)
- IC: ATTiny85 (you'd need to build/buy an AVR ISP to program it)


Note: If you swap out the LED, you may also want to use a different R2.
For instance, the Cree XP-E White LED could use an R2 of .68ohm to get a
current of 956mA.  Also, LEDs like Cree XM-L2 are brighter but battery hungry.

Useful equations mentioned in the post:

- $V_{battery} - V_{LED} - V_{Q_{2DS}} - V_{Q_{1BE}} == 0$
- $V_{R_{3}} == V_{Q_{1BE}}$ and therefore, $R_3 = V_{R_{3}} / I_{R_{3}}$
- $P_{Q_{2}} = I_{LED} * V_{Q_{2DS}}$
