# -*- coding: utf-8 -*-
"""
Created on Wed Feb 15 20:08:25 2017

@author: xunliangliu
"""

import random as rnd
import math

class Location():
    def __init__(self, x, y):
        self.x = x
        self.y = y
        
    def getX(self):
        return self.x
    
    def getY(self):
        return self.y
    
    def distFrom(self, other):
        assert isinstance(other, Location)
        return ((self.x - other.x)**2 + (self.y - other.y)**2)**0.5
    
    def move(self, deltax, deltay):
        '''Be careful about the return type'''
        
        return Location(self.x + deltax, self.y + deltay)
    
    def __str__(self):
        return '(%d, %d)' % (self.x, self.y)

    
class Field():
    def __init__(self):
        self.drunks = {}
        
    def addDrunk(self, drunk, loc):
        d = self.makeDrunk(drunk) # in case drunk was given as a string
        if d in self.drunks:
            raise ValueError ('%s is already in the Field.' % d.name)
        self.drunks[d] = loc
            
    def rmDrunk(self, drunk):
        d = self.makeDrunk(drunk) 
        if not d in self.drunks:
            raise ValueError ('%s is not in the Field!' % d.name)
        del self.drunks[d]
            
    def makeDrunk(self, name):
        '''make drunk using drunk name:
        
        take the name of a drunk (string) and make it to a Drunk object
        if drunk is already a Drunk object, return itself'''
        
        if isinstance(name, Drunk):
            return name
        elif isinstance(name, str):
            return Drunk(name)
        else:
            raise TypeError ('This function takes Drunk() or str() type.' )
            
    def moveDrunk(self, drunk):
        d = self.makeDrunk(drunk)
        x, y = d.takeStep()
        
        if not d in self.drunks:
            raise ValueError ('%s is not in the Field' % d)
        self.drunks[d] = self.drunks[d].move(x, y)
          
    def getLoc(self, drunk):
        d = self.makeDrunk(drunk)
        if not d in self.drunks:
            raise ValueError ('%s is not in the field.' % d)
        return self.drunks[d]
    
    def showDrunks(self):
        if self.drunks:
            print('\tName\tLocation')
            for j in self.drunks:
                print('\t\t%s' % j, end = '\t')
                print(self.drunks[j])
        else:
            print('No drunk found in the fields.')
                
class Drunk():
    def __init__(self, name):
        self.name = name
        
    def takeStep(self):
        return rnd.choice([(-1,0),(1,0),(0,1),(0,-1)])
       
    def __str__(self):
        return self.name

        
def walk(f, drunk, steps):
    '''return the final location after a number of steps of walk'''
    
    assert isinstance(f, Field)
    assert isinstance(drunk, Drunk)
    assert isinstance(steps, int)

    for s in range(steps):
        f.moveDrunk(drunk)
    return f.getLoc(drunk)


def walkSim(nSteps, nTrials):
    dists = []
    for t in range(nTrials):
        f = Field()
        d = Drunk('John')
        d_loc = Location(0,0)
        f.addDrunk(d,d_loc)
        stop = walk(f, d, nSteps)
        
        distance = d_loc.distFrom(stop)
        dists.append(distance)
        dists = [float('%.2f' % dist) for dist in dists] # clean the data

    return dists
    
def uTest(test_set, nTrials):
    import pylab
    mean_dist = []

    for ts in test_set:
        result = walkSim(ts, nTrials)
        mean_dist.append(sum(result)/len(result))
        print('RANDOM WALK OF %d STEPS; %d TRIALS' % (ts, nTrials))
        print('\tMAX = %.2f;\tMIN = %.2f;\tMEAN = %.2f' % \
              (max(result), min(result), sum(result)/len(result)))
        #print('\t', result)
    xx = [math.log10(t) for t in test_set]
    pylab.plot(xx, mean_dist)
    pylab.show()
    
    
uTest([1, 10, 100, 1000, 10000], 20)    
    

