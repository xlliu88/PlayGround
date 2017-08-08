# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 14:39:02 2017

@author: xunliangliu
"""

import pylab
import random

def clear(n, P, nSteps):
    ''' analytic model of exponential decay'''
    remain = [n]
    for s in range(nSteps):
        remain.append(n*((1-P)**s))
    return remain

def clearSim(n,P,nSteps):
    ''' simulation model of exponential decay'''
    remain = [n]
    nMol = n
    for s in range(nSteps):
        for x in range(nMol):
            if random.random() <= P:
                nMol -= 1
        if s !=0 and s%100 == 0: # if molecular duplicates at certain time intervel.
            nMol *= 2
        remain.append(nMol)
    return remain
    
    
time = 500
pylab.plot(clear(10000, 0.01, time), 'r-', label = 'Expotential Decay')
pylab.plot(clearSim(10000, 0.01, time), 'g--', label = 'Simulation')
pylab.xlabel('time')
pylab.ylabel('Remaining Molecular')
# pylab.semilogy()
pylab.show()




