# -*- coding: utf-8 -*-
"""
Created on Sun Feb  5 12:55:06 2017

@author: xunliangliu
"""

# list comprehension
lst1 = [1,4,5,8]
lst2 = list(range(1,10))
lst3 = list("aliefeoiliejf")

sq = [x**2 for x in lst1]
sqdict = [{x:x**2} for x in lst1] # return a list of dicts
sqdict2 = {x:x**2 for x in lst1}   # return a dict
sqtup = [(x,x**2) for x in lst1] # return a list of tuples
set_comp = {x for x in lst3}    # will return a set, with no duplications

m = [x for x in lst1 if x >= 5]
mn = [(x,y) for x in lst1 for y in lst2 if x != y]
md = [(x,y) for x in lst1 for y in lst2 if x % y == 0]
    
# flatten a list of lists by list comprehension
matrix = [[1,2,3], [4,5,6], [7,8,9]]    
f_vec = [x for v in matrix for x in v]  # return [1, 2, 3, 4, 5, 6, 7, 8, 9]
# transpose of a matrix
col = len(matrix[0])
trans_m = [[row[i] for row in matrix] for i in range(col)] # equel to two nested for loops

# dictionary
d1 = dict([('sape', 4139), ('guido', 4127), ('jack', 4098)])  # dict() create a dict from (key,value) pairs   
d2 = dict(sape=4139, guido=4127, jack=4098) # equel to the previous expression
sqdict2 = {x:x**2 for x in lst1}   # dict created by dict comprehension

# use zip() function to pair k,v to a dict
k_lst = ['sape', 'guido', 'jack']
v_lst = [4139, 4127, 4098]
dzip = {k:v for k,v in zip(k_lst,v_lst)}
