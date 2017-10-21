---
layout: default
title: Projects
permalink: /projects/
redirect_from: "/"
---

### Bike Lights: Building, Researching, Learning

Biking in NYC is both terrifying and absolutely awesome.  One fear of mine is
hard to overcome: getting hit from behind when braking quickly on a crowded
bike path or the street.  I became inspired to solve this problem and decided
to build an intelligent tail light that analyzes accelerometer readings to
shine brighter red when braking.  It turns out that a reliable and portable
light like this is quite challenging to implement.  Neat problems abound!

I am exposing my research and efforts on this project in a series of blog posts
on the topic of bike lights.  So far, I've done some cool things!  I have a
couple prototypes, I've learned to program an AVR ATTiny85, I built a few
constant current circuits from scratch, and I created some probabilistic
algorithms to detect braking from accelerometer data.

The following links document my journey through this process.  Please check my:

* Series of [blog posts documenting this project](/2016/07/08/foray-into-bike-lights-from-front-to-back)
* Github code:
  *  3d printer designs
      *  [1st prototype](https://github.com/adgaudio/3dPrinter/blob/master/random_parts/bike_light.scad)
      *  [2nd prototype](https://github.com/adgaudio/3dPrinter/blob/master/random_parts/bike_light_from_gu10_bulb.scad)
      *  [battery pack (nothing specific at this link)](https://github.com/adgaudio/3dPrinter/blob/master/random_parts/)
      *  check the repository from those links for other designs
  * [programming the ATTiny85 microcontroller](https://github.com/adgaudio/attiny85_blink_LED)
  * [algorithm for the smart brake light (in python)](https://github.com/adgaudio/smart_brake_light)


Please check the [blog post series](/2016/07/08/foray-into-bike-lights-from-front-to-back) for progress!

### Stolos, Relay and Relay.Mesos

This represents 3 projects I undertook while a data scientist at Sailthru.
These projects solve distributed systems problems for the data science team.

Check the following GitHub pages:

  * [Stolos: A Directed Acyclic Graph task dependency scheduler designed to
  simplify complex distributed pipelines](https://github.com/sailthru/stolos)
  * [Relay: A self-tuning thermostat for distributed systems that minimizes the
  error between some metric and a target](https://github.com/sailthru/relay)
  * [Relay.Mesos: A mesos plugin for Relay that lets you auto-scale the number
  of currently running instances of a bash
  command](https://github.com/sailthru/relay.mesos)

### DLP Printer

In an attempt to solve some existing problems with diy DLP printer designs, I
designed and built this printer from scratch.  Basically, the printer makes
objects by hardening a liquid plastic solution only in places where (laser)
light shines with enough intensity.  I'm currently writing firmware and
software for it.  I really want to build clear, micro-scale objects that can
perform sophisticated operations (like moving water through a particular
lattice structure).  The liquid plastic side of things also seems like a great
medium to embed different compounds.

* [GitHub repository for its development](https://github.com/adgaudio/dlp_printer)

Update: UV lasers are dangerous.  They can blind you faster than you can blink.
The reflected beam is also dangerous.  I temporarily paused further work on
this after I had created some unexpected burn marks in my furniture.  Maybe
I'll resume with a DLP projector next go around...


<h3>I proposed underwater!</h3>
<p>
While scuba diving at night, on a surprise vacation in Bonaire with a 3D printed florescent ring, an invisible ink message, 3D printed blue and white dive lights, and a blacklight in a peanut butter jar filled with mineral oil!  And my fiance, Emma, is amazing.
</p>

### A Self-Sourced MendelMax RepRap 3D printer

Two months, an apartment littered with hardware, curious blobs of plastic, and
several all night-ers later, I have finally finished building my first 3D
printer!  But my little printing revolution is nothing compared to the 3D
printing movement that will revolutionize the manufacturing industry, so hang
on to your seats!

For me, this project was an amazing first step into mechanical design and
electronics.  I sourced all the parts and tools from McMaster and elsewhere to
build the printer by hand.  In my NYC studio apartment, I quickly amassed a
collection of things and created a "workshop" beside to my bed.  The joys of
New York are that everything is close together. :)  I learned that mechanical
motion is hard, and careful calibration takes a lot of effort.  Lacking
instructions for many components, such as electronics and y axis, I made stuff
up to fill the gaps.

I will never forget the sheer excitement and feeling of "oh my God, I really
can do this!" when the motors on the machine moved for the first time.  I
treasure my first blob of plastic that should have been a cube; the object is
very symbolic for me.  The project helped me realize that problems that appear
vastly complicated and confusing are sometimes secretly just within reach.  The
problem of building a complex electromechanical device to create 3D objects in
this case did not require years of effort and discovery on my part, but was
simply a matter of finding which paths have already been well developed by
others.  I am grateful to those that made this experience possible for me.

Check my GitHub repository for the things I've built with this printer.

* [3D printed designs](https://github.com/adgaudio/3dPrinter)
* [Tooling for OpenSCAD](https://github.com/adgaudio/OpenSCAD-Tools)

<h3>Artificially Intelligent Yogurt Maker</h3>
<p>
A what?!  Well, I could have called it pid-controlled thermostat, or maybe just "milk heater," but those names just fall short.  Few people realize that a PID controller utilizes a predictive algorithm that must be "trained," or "tuned," to the proper parameters.  And yes, my yogurt is tastier than Fage...maybe not than Brown Cow, though!
</p>

<h3>Kaggle Wordpress Data Science Competition</h3>
<p>
Excitement is mounting amidst the start of my second kaggle competition!  This time around, I'm using my machine learning and data science skills to recommend the top Wordpress posts a user is most likely to "like."  There's a lot that goes into a recommendation system like this one - blended models, probability density estimation, collaborative filtering, feature extraction...  I better not say too much!  Checkout the tip of the iceberg on <a href="http://www.github.com/adgaudio/kaggle-wordpress" target="_blank">github</a>!
</p>

<h3>Kaggle Competition - <a href="http://datascienceglobal.org" target="_blank">Data Science Global</a> (Air Quality Prediction)</h3>
<p>
Sweating through the night really paid off when David, Asher and I won <a href="http://www.kaggle.com/c/dsg-hackathon/leaderboard?league=New%20York%20City" target="_blank">5th place in NYC</a> and 28th globally!  Predicting air pollution patterns in Chicago is tricky business, so what's our secret?  Keep it simple, keep it real, and know the math you're using!
</p>

<h3>Stanford Machine Learning Class with Andrew Ng</h3>
<p>
Well, this was pretty darn fun, I have to admit.  Coming away from this class with a <a href="/img/ml_statement_of_accomplishment.pdf" target="_blank">perfect score</a> in the class and two notebooks full of valuable information.  I can't tell you the number of times I've checked back to my notes in the past several months!
</p>

<h3>PyGotham</h3>
<p>
That's right, a New York City Python conference!  The brilliant idea of an awesome friend, Gloria, <a target="_blank" href="http://pygotham.org/">PyGotham</a> takes place for the first time on September 16th and 17th, 2011.  As a participant in this excellent lineup of <a target="_blank" href="http://pygotham.org/talkvote/scheduled_talks/">speakers and presentations</a>, I will give a 90 minute class about IPython and Tmux.  There will also be a Wii-mote laser-tag scavenger hunt, coding tournament, afterparty and many other fun events.  In addition to speaking, I have helped Gloria build the PyGotham website, and will be doing something mischevious with wii-motes, cell phones and IR leds! 
</p>


<h3>Hunchworks, in collaboration with United Nations Global Pulse</h3>
<p>
We're developing a social networking platform to help UN analysts and crisis mappers generate hypotheses about global crises so they can more effectively identify crises and possible solutions before we are aware of them.  The platform will utilize crowd sourcing and machine intelligence to identify patterns in collected data and help users generate stronger hypotheses.  For more details, you can google the project and checkout these links:  <a target="_blank" href="https://github.com/global-pulse/HunchWorks/wiki/Project-background">GitHub</a>, <a target="_blank" href="http://adaptivepath.com/ideas/global-pulse-hunchworks-project-week-3-challenge">Description from Adaptive Path</a>, <a target="_blank" href="https://sites.google.com/site/unglobalpulse/workspace-capabilities/hunch-labs">Global Pulse google page</a>, <a target="_blank" href="http://www.unglobalpulse.org/">UN Global Pulse</a>
</p>


<h3>Heartbeat: The Intelligent MP3 Player</h3>
<p>
We know that igniting feeling from We Will Rock You by Queen, and the sheer intensity of Aretha Franklin's huge voice. Many of us have drifted into the worlds of Radiohead or the Beatles. We feel music: sweaty, emotional, soothing.  We explore it: rhythmically, harmonically, analytically.  Good music is captivating on many levels, and because of this captivating effect, we can use music as a tool. 
</p>
<p>
Introducing Heartbeat, The Intelligent Music Player.  This project is inspired by <a target="_blank" href='http://heart.bmj.com/content/92/4/445.full?sid=00ffbddf-b343-4b8a-97d3-76811c05ba6c'>current findings</a> that the human heart rate increases when humans listen to faster tempos and simpler rhythmic structures (Bernardi, Porta, & Sleight, 2005).
</p>
<p>
Heartbeat, The Intelligent Music Player, is a portable mp3 player that chooses songs with highest probability of having some measurable biological effect. The device wirelessly determines heart rate via a transmitter strapped around one's chest, and it might one day also incorporate other sensors: it could measure breathing rate, determine how fast someone moves (steps per minute), analyze ambient noises, ambient temperature, even data from a cell phone about issues relevant to one's daily life: Are you sending more txt messages than you receive? Are your stocks crashing?  With some further development, Heartbeat is useful for finding out which songs invoke more general biological response, for regulating heart rate, and for maintaining musical and biological stimulation.
</p> 

<!-- {% comment %}
<p>
The next step in this project's development is to match heart rate data to a music library.  Matching rhythm signatures on the songs in a music library to heart rate data can help determine which songs would be good to run to, or good to work to.  Pattern recognition algorithms, a neural network, and machine learning can identify specific songs, and aspects of songs (like a change in tempo or the number of pauses in energy), that affect heart rate.  Given the wealth of information and approaches available, I have been trying out different ways to complete the project.  Be sure to come back and see my tutorial about FFTs, theories about visualizing the beat of a song, and whatever else I deem acceptable for public scrutiny!  I will be posting more as I develop this website and my projects.
</p>
{% endcomment %} -->


<h3>Software contribution to Research and Education Networking Information Sharing Center</h3>
<p>
I designed and developed a darknet software package for the Shared Darknet Project at REN-ISAC.  
</p>
<p>
The <a href="http://www.ren-isac.net/shared_darknet/" target="_blank">Shared Darknet Project</a>: "The Shared Darknet (SD) is a project under the auspices of REN-ISAC (RI). The SD objective is to develop a persistent and evolving darknet resource using combined data contributions of participating sites and joint efforts in analysis and analytics development. SD enables the discovery of operationally actionable information regarding sources of threat, the understanding of attacks, malware, threat evolution, and miscreant behavior, and is a source of real-world data for innovative research."
</p>


<h3>GaudiosOnline: An Online Family Identity Space</h3>
<p>
As the Internet becomes a larger part of who we are, the question of our identity becomes an increasingly relevant problem.  Are we mostly material bodies with skin and bones, or are we non-physical beings with a thinking mind?  Particularly as we continue to identify ourselves with online and digital spaces like Facebook and Google+, Wikipedia, and the internet in general, and as we exercise the intellectual more than the physical part of ourselves, we will continue to struggle with this question of our identity.
</p>
<p>
Welcome to Gaudiosonline, the framework for a novel kind of identity: an online home for my family.  I like to think of this as a digital space for thoughts, projects, memories and conversation.  The public facing side to this project will one day be <a href = "http://www.gaudiosonline.com" target="_blank">here</a>.
</p>


<h3>Galvanic Skin Response (GSR) Instrument</h3>
<p>
The first time I focused a stereomicroscope with 100x magnification on my finger, I saw tiny pores holding little sweat bubbles.  Looking closer, I realized that those bubbles were getting larger as I thought about them.  Then it hit me - my thoughts controlled the amount of liquid on my finger!
</p>
<p>
A Galvanic Skin Response (GSR) Instrument, also known as the polygraph and lie detector, measures skin conductivity.  Because sweat contains salts, our fingers conduct electricity.  Specifically, dry skin has more resistance (~100,000 ohms) than moist skin (~15,000 ohms).  
</p>

{% comment %}
<p>
Since Kary Mullis (a nobel prize winning scientist and the guy who invented PCR, a method to mass reproduce DNA) has already managed to use a GSR device, a Playboy magazine, and wireless FM transmitter to impress a bunch of nurses with his psychic ability to switch on a lightbulb (from his autobiography, "Dancing Naked In The Mind Field," page 81-5), I've taken a different route.
</p>
{% endcomment %}

<p>
My GSR device was originally meant for an experiment using live dancers and live music, but it turns out that we couldn't really move when wired up, so instead I piped its output to <a href="http://puredata.info/" target="_blank">PureData</a> using an <a target="_blank" href="http://www.arduino.cc/">Arduino</a> board.  The result was crazy electronic music!
</p>


<h3><a style="font-size: inherit;" href='/projects/music/'>Live at Bard  -- May 6, 2010</a></h3>
<p>
This is my jazz quartet featuring my compositions and sax playing.  This is the second part of my two-concert series entitled, "Cultivating Expression: Connecting With Each Other Through Jazz."  All original compositions.
</p>
