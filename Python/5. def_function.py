# -*- coding: utf-8 -*-
"""
Created on Sat Feb  4 16:08:12 2017

@author: xunliangliu
"""
a = 100
b = 13
divmod(a,b)

with open('tuple_list.py') as fp:
    for line in iter(fp.readline, ''):
    #for line in fp:
        print(line,end='\t')
        
# use list as an argument.
def f(a, L=[]):
    """This is a test of docs.
    
    This function append a to list L
    Use f.__doc__ to show this description.
    """
    if not L: # the default value of argument will only be evaluated once; 
        L=[]
    L.append(a)
    return L
    
print(f(2))
print(f(4)) # it will be [2,4] without line 22 and 23

def fun(x,y,*arg, **args):
    '''*arg will be packed as a tuple
    and **args will be packed as a dict
    args in **args must have a key
    '''
    pass
    