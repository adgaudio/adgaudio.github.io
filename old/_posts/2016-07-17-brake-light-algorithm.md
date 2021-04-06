---
layout: post
title: Design and Circuitry for a Smart Brake Light
---


1. An algorithm for a "smart" brake light using rolling averages, the Z score,
   and the binomial probability mass function.


detecting a brake event from accelerometer data.

the data: what it looks like, what it tells us, what it doesn't tell us.
  - assumptions
the goal: detect a brake event.  how can we identify an event

rolling average as a sliding window.  what happens when changing the width
z score
binomial probability mass function
 - visualization

problem of direction

averaging


for the problem of direction post:
Accelerometer data poses several challenges, particularly when used in
small embedded devices.  Accelerations can describe how a velocity has
changed, but they do not directly describe velocity or location.  One
can infer a velocity or position from accelerometer data using basic
laws of classical mechanics, but assumptions must be defined.
Newtonian physics, but different assumptions must be made.  For
instance, .  what was accelerating  particularly because the data made
available does not so on an embedded device.  Accelerometer data does

