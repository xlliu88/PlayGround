# -*- coding: utf-8 -*-
"""
Created on Mon Feb 27 11:40:58 2017

@author: xunliangliu
"""
import random
import pylab

class SimpleVirus(object):
 """
 Representation of a simple virus (does not model drug effects/resistance).
 """
 def __init__(self, maxBirthProb, clearProb):
     """
     Initialize a SimpleVirus instance, saves all parameters as attributes
     of the instance.
     maxBirthProb: Maximum reproduction probability (a float between 0-1)
     clearProb: Maximum clearance probability (a float between 0-1).
     """
     self.maxBirthProb = maxBirthProb
     self.clearProb = clearProb
     
 def doesClear(self):
     """
     Stochastically determines whether this virus particle is cleared from
     the patient's body at a time step.
     returns: True with probability self.clearProb and otherwise returns
     False.
     """
     if random.random() <= self.clearProb:
         return True
     return False

 def reproduce(self, popDensity):
     """
     Stochastically determines whether this virus particle reproduces at a
     time step. Called by the update() method in the SimplePatient and
     Patient classes. The virus particle reproduces with probability
     self.maxBirthProb * (1 - popDensity).
     If this virus particle reproduces, then reproduce() creates and
     returns the instance of the offspring SimpleVirus (which has the same
     maxBirthProb and clearProb values as its parent).
     popDensity: the population density (a float), defined as the current
     virus population divided by the maximum population.
     returns: a new instance of the SimpleVirus class representing the
     offspring of this virus particle. The child should have the same
     maxBirthProb and clearProb values as this virus. Raises a
     NoChildException if this virus particle does not reproduce.
     """
     if random.random() <= self.maxBirthProb * (1 - popDensity):
         #print('duplicate')
         return SimpleVirus(self.maxBirthProb, self.clearProb)
     else:
         #print('No Child')
         return None
     
class SimplePatient(object):
     """
     Representation of a simplified patient. The patient does not take any
     drugs and his/her virus populations have no drug resistance.
     """
     def __init__(self, viruses, maxPop):
         """
         Initialization function, saves the viruses and maxPop parameters as
         attributes.
         viruses: The list representing the virus population (a list of
         SimpleVirus instances)
         maxPop: The maximum virus population for this patient (an integer)
         """ 
         self.viruses = viruses
         self.maxPop = maxPop
     def __str__(self):
         return self.name

     def getTotalPop(self):
         """
         Gets the current total virus population.
         returns: The total virus population (an integer)
         """
         return len(self.viruses)
         
     def update(self):
         """
         Update the state of the virus population in this patient for a single
         time step. update() should execute the following steps in this order:
         - Determine whether each virus particle survives and updates the list
           of virus particles accordingly.
         - The current population density is calculated. This population
           density value is used until the next call to update()
         - Determine whether each virus particle should reproduce and add
         offspring virus particles to the list of viruses in this patient.
         returns: the total virus population at the end of the update (an
         integer)
         """
         for i in range(len(self.viruses),0,-1):
             if self.viruses[i-1].doesClear():
                 self.viruses.remove(self.viruses[i-1])
         
         density = self.getTotalPop()/self.maxPop
         children = []
         for v in self.viruses:
             child = v.reproduce(density)
             if type(child) == type(v):
                 children.append(child)
         self.viruses = self.viruses + children
         
         return self.getTotalPop()

def noDrugSim(patient,time):
    pop = []
    for t in range(time):
        pop.append(patient.update())
    pylab.plot(pop, 'g-', label = str(patient))
    pylab.xlabel('Time (Hours)')
    pylab.ylabel('Virus Population')
    pylab.legend(loc = 'best')
    #pylab.show()

v = SimpleVirus(0.1, 0.05)
p1 = SimplePatient([v]*100, 1000)
p2 = SimplePatient([SimpleVirus(0.1, 0.05) for t in range(100)],1000)
p1.name = "Patient 1"
p2.name = "Patient 2"

noDrugSim(p2, 300)
noDrugSim(p1, 300)
pylab.show()
'''
pop1 = []
pop2 = []
random.seed()
for t in range(500):
    #print('#'*5, 'Round ', t+1)
    pop1.append(p1.update())
    pop2.append(p2.update())

pylab.plot(pop1, 'g-', label = 'Patient 1')
pylab.plot(pop2, 'r--', label = 'Patient 2')
pylab.xlabel('Time (Hours)')
pylab.ylabel('Virus Population')
pylab.legend(loc = 'best')
pylab.show()
'''