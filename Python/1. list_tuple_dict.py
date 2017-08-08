# -*- coding: utf-8 -*-
"""
Created on Fri Feb  3 23:11:20 2017

@author: xunliangliu
"""

# tuple assignment
t = (10, 20)
(a,b) = t
print("a=%d; b=%d"%(a,b))
(b,a)=(a,b)
print("a=%d; b=%d"%(a,b))

a = "Apple"
b = "A" + "pp" + "le"
hex(id(a))
hex(id(b))



lst1 = [1,2,3,4,5,6,7,8]
lst2 = lst1          # lst2 and lst1 are pointing to the same object. change 1 will make another on change too!
lst3 = lst1[:]       # make a copy of lst1. two lists are independent
lst4 = lst1.copy()   # the same as previous line
lst1[3] = "100"
lsts = list('apple')
hex(id(lst1))       # to show the memory address of an various
hex(id(lst2))

## list references
lst1 = list('apple')
lst2 = list('orange')

lstFruit = [lst1,lst2]
lst1.pop()          # this change of lst1 will be refected in lstFruit also
lst1.clear()        # the same

id(lst1) == id(lstFruit[0]) # it's true.

lst1 = list('pear')   # this reassignment will not change lst1 in lstFruit
                      # reassignment changed the memory address of lst1
                      
                      
## zip
## return a list of tuples, in which each tuple contains items with same index in each list
lstzip = list(zip(lst1,lst3))
lstzip2 = list(zip(lst1,lsts)) # when two lists are not same in length, the longer list will be truncated

              
## dict
emplyees = {'John':51, 'Jenny': 25, 'Chris':33}
# get function:
emplyees.get('Adam', None) # if not exit return None

#character counting
seq = 'AGCGGCTATCCTAGAGTC'
ntCount = {}
for nt in seq:
    ntCount[nt] = ntCount.get(nt, 0) + 1 
    

def dot_product(v1,v2):
    pro = 0
    if type(v1) == type([]) and type(v1) == type([]):
        if len(v1) == len(v2):
            for i in range(0,len(v1)):
                pro = pro + v1[i]*v2[i]
        else:
            print ("vectors have different length.")
            return None
    else:
        print ("non-list parameter.")
        return None
    return pro

dp = dot_product([1,2],[1,2])

def replace(s, old, new):
    try:
        assert type(s) == type("")
    except:
        print ("TypeError: s should be a string")
        return None
    old = str(old)
    new = str(new)
    sl = list(s)
    nsl = []
    for i in sl:
        if i == old:
            nsl.append(new)
        else:
            nsl.append(i)
    return "".join(nsl)
    

