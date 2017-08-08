# -*- coding: utf-8 -*-
"""
Created on Mon Feb 27 16:01:43 2017

@author: xunliangliu
"""

import random
import pylab
g1 = 0
g2 = 0
mean = 100.0
stdDev1 = 0.0
stdDev2 = 20.0
for i in range(1000):
  g1 += random.gauss(mean, stdDev1)
  g2 += random.gauss(mean, stdDev2) 
  
y1 = []
y2 = []
y3 = []
for i in range(20):
 y1.append(3*i**5)
 y2.append(i**3)
 y3.append(3**i)
pylab.figure(1)
pylab.plot(y1)
pylab.figure(2)
pylab.plot(y2)
pylab.semilogy()
pylab.figure(3)
pylab.plot(y3)
pylab.semilogy()
pylab.show()