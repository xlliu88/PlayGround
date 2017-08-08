# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 19:40:09 2017

@author: xunliangliu
"""

import random as rnd
import math
import pylab

def rollDice(nDice = 1):
    return tuple([rnd.choice(range(1,7)) for i in range(nDice)])

#def roll(n = 1,nDice = 1):  # n: number of rounds
#    return [rollDice(nDice) for i in range(n)]
def isYahtzee(r):
    if not type(r) == type(tuple([])) or len(r) < 2:
        print ('fairRoll takes at least two dices')
        return -1
    return all([x == sum(r)/len(r) for x in r])
    
def test(reps, n = 1, nDice = 1):
    for rep in range(reps):
        totle = []
        yahtzee = []
        for rod in range(n):
            dice = rollDice(nDice)
            totle.append(dice)
            if isYahtzee(dice):
                yahtzee.append(dice)
        #print ("Result: ",totle)
        #print ("FairRoll: ", fairroll)
        print ("Percent FairRoll: ", len(yahtzee)/len(totle) * 100)

def testPascal(nTrials):
    '''the chance of getting a double 6 in 24 rolls of a pair of dice'''
    pascal = 0
    for trials in range(nTrials):
        for i in range(24):
            res = rollDice(2)
            if res == (6,6):
                pascal += 1
                break
    return pascal/nTrials * 100

#rollDice(1)
#test(10,10000,3)
test_set = [1,2,3,4,5,10,50,100,1000,10000]
win = []
for t in test_set:
    win.append(testPascal(t))
    
#pylab.plot([math.log10(ts) for ts in testset],win)
pylab.plot(test_set,win,'k')
pylab.xscale('log')
pylab.ylim(0,100)
pylab.show()
print ([round(w,2)for w in win])
#print('chance of win:', testPascal(1000000))

## to get the Variation of the simulation. test how many trials will give confident on result.
test_set = [1,2,3,4,5,10,50,100,1000]
var = []
win = []
for t in test_set:
    res = []
    for rep in range(50):
        res.append(testPascal(t))
    mean = sum(res)/len(res)
    v = math.sqrt(sum([(x - mean)**2 for x in res])/len(res))
    var.append(v)
    win.append(mean)

var = [round(v,2) for v in var]
win = [round(w,2) for w in win]
 
pylab.plot(test_set, var, 'r-.', label = 'Var')
pylab.plot(test_set, win, label = 'winning chance')
pylab.xscale('log')
pylab.ylim(0, 100)
pylab.show()