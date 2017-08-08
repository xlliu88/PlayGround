# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 20:33:47 2017
MIT_6.00_drunk walk

@author: xunliangliu
"""

import random as rnd

class Location():
    def __init__(self, x, y):
        self.x = x
        self.y = y
        
    def getX(self):
        return self.x
    
    def getY(self):
        return self.y
    
    def distFrom(self, other):
        assert isinstance(other, Location) #('Other is not a Field() class')
        return ((self.x - other.x)**2 + (self.y - other.y)**2)**0.5
    
    def move(self, step):
        assert isinstance(step, tuple) and len(step) == 2
        self.x = self.x + step[0]
        self.y = self.y + step[1]
        
    def __str__(self):
        return '(%d, %d)' % (self.x, self.y)

    
class Field():
    def __init__(self):
        self.drunks = {}
        
    def addDrunk(self, drunk):
        if isinstance(drunk, Drunk):
            if drunk.name in self.drunks.keys():
                raise ValueError ('%s is already in the field.' % drunk.name)
            self.drunks[drunk.name] = drunk.location
        elif isinstance(drunk,str):
            if drunk in self.drunks.keys():
                raise ValueError ('%s is already in the Field.' % drunk)
            self.drunks[drunk] = Location(0,0)
        else:
            raise TypeError ('%s must be a Drunk or str object' % drunk)
            
    def rmDrunk(self, drunk):
        if isinstance(drunk, Drunk):
            if not drunk.name in self.drunks.keys():
                raise ValueError ('%s not found!' % drunk.name)
            del self.drunks[drunk.name]
        elif isinstance(drunk, str):
            if not drunk in self.drunks.keys():
                raise ValueError ('%s not found!' % drunk.name)
            del self.drunks[drunk]
        else:
            raise TypeError ('%s must be Drunk() or str() object.')
            
    def moveDrunk(self, drunk, step):
       assert isinstance(step, tuple)
       if isinstance(drunk, Drunk):
           if not drunk.name in self.drunks.keys():
               raise ValueError ('%s is not in the Field' % drunk.name)
           drunk.location.move(step)
       elif isinstance(drunk, str):
           if not drunk in self.drunks.keys():
               raise ValueError ('%s is not in the Field' % drunk)
           self.drunks[drunk].move(step)
       else:
           raise TypeError ('This function takes Drunk() or str() type.' )
    
    def getLoc(self, drunk):
        return self.drunks[drunk]
    
    def showDrunks(self):
        if self.drunks:
            print('\tName\tLocation')
            for jname, jloc in self.drunks.items():
                print('\t%s' % jname, end = '\t')
                print(jloc)
        else:
            print('No drunk found in the fields.')
                
class Drunk():
    def __init__(self, name, loc):
        self.name = name
        self.location = loc
        
    def takeStep(self):
        return rnd.choice([(-1,0),(1,0),(0,1),(0,-1)])
       
    def __str__(self):
        return '\tName: %s\tLocation: (%d, %d)' % \
               (self.name, self.location.x, self.location.y)
        
def walkSimulation(fd, drunk, steps):
    assert isinstance(fd, Field)
    assert isinstance(drunk, Drunk)
    assert isinstance(steps, int)
    for s in range(steps):
        fd.moveDrunk(drunk, drunk.takeStep())
    print('%d step of walk.\t final location (%d, %d)' % (steps, drunk.location.x, drunk.location.y))
    print('distance from origional: %f' % drunk.location.distance(Location(0,0)))
    return drunk.location.x, drunk.location.y


def walkTest(test_set):
    for t in test_set:
        walkSimulation(f, duk, t)

    
    
    
    
f = Field()
#loc = Location(0,0)
duk = Drunk('John',loc = Location(0,0))
duk2 = Drunk('Jenny', Location(2,4))
f.addDrunk(duk)
#f.addDrunk(duk2)
walkTest([0, 1, 10, 100, 1000, 10000])


f.drunks[0].location = Location(6,10)

loc = Location(0,0)
loc2 = Location(3,4)

loc2.distance(loc)
