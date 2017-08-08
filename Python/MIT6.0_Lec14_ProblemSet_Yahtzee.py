# -*- coding: utf-8 -*-
"""
Created on Mon Feb 27 13:05:10 2017

@author: xunliangliu
"""

import random as rnd
import math
import pylab

def stdDev(X):
    m = sum(X)/len(X)
    ss = sum([(x-m)**2 for x in X])
    return math.sqrt(ss/len(X))
    
def rollDice(nDice = 1):
    return [rnd.choice(range(1,7)) for i in range(nDice)]

#def roll(n = 1,nDice = 1):  # n: number of rounds
#    return [rollDice(nDice) for i in range(n)]
def isYahtzee(r):
    if not type(r) == type([]) or len(r) < 2:
        print ('it takes at least two dices to get Yahtzee')
        return -1
    return all([x == sum(r)/len(r) for x in r])
    
def test(reps, n = 1, nDice = 1):
    YahRates = []
    for rep in range(reps):
        y = 0
        for rod in range(n):
            if isYahtzee(rollDice(nDice)):
                y+=1
        yahrate = y/n * 100
        #print ("Percent Yahtzeer: ", y)
        YahRates.append(yahrate)
    m = sum(YahRates)/len(YahRates)
    sd = stdDev(YahRates)
    return m, sd
    
reps = [10**x for x in range(4)]
Ymean = []
Ysd = []
for r in reps:
    mean, sd = test(r, 1, 5)
    Ymean.append(mean)
    Ysd.append(Ysd)

xx = pylab.array(reps)
pylab.plot(reps, Ymean, label = 'mean')
pylab.plot(reps, Ysd, label = 'SD')
pylab.xscale('log')
pylab.show()