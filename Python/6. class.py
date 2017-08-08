# -*- coding: utf-8 -*-
"""
Created on Wed Feb  8 09:21:33 2017

@author: xunliangliu
"""
class Person():
    pass

x = Person()     # can use an empty class to bundle several data items together
x.name = "John"
x.dept = "Biology"
x.age = 32


class Emplyee(Person):      # Emplyee is a subclass of Person()
    def __init__(self, name): # when there's an parameter in __init__(). 
        self.name = name      # this parameter must be included when create an instance of this object
        self.age = None       # could still initialize other attributions
        
y = Emplyee("Janney")        # "Janney" is required since there's a "name" parameter in __init__()
y.dept = "Chemistry"         # can add attributions even not initialized in __init__()
y.age = 28



print(b'Hello %s, %d'%(b'World',42))

while True:
    mon =int( input('month:'))
    if mon == -1:
        print("exit...")
        break
    assert 1 <= mon <=12, "%d out of range."%mon
    print('this is month: ', mon)   