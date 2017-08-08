# -*- coding: utf-8 -*-
"""
Created on Tue Jun 27 19:03:40 2017
to rename syncytia size images:
  1. use 2-digit number instead of 1-digit number for plate number
  2. if a file name ends with '_', add a number after '_'

@author: xunliangliu
"""

import os
import re

os.chdir("L:\MitchumLab\Individual Lab Folders\XunliangLiu\CLAVATA_project\Infection_BIK_WT_2")
def filetype(fn):
	if '.' in fn:
		return fn.split('.')[-1]
	else:
		print (fn, "is not a file name!")
		return -1
	
	
for root, dirs, files in os.walk('.'):
  for f in files:
    fext = filetype(f).lower() if filetype(f) != -1 else next
    
    if fext == 'tif' or fext == 'tiff':
      ## use 2-digit for plate# instand of 1-digit
      if re.findall("R\dP\d[A,B,C]\dT\d",f):
        newfn = "P0".join(f.split('P'))
        os.rename(root + '/' + f, root + '/' + newfn)
        print ("!!! Rename... ", f, "to", newfn)
      
      ## if file name end with '_', add a number at the end
      if f.split('.')[-2][-1] == '_':
        s=1
        while True:
          jnt = '_' + str(s)
          newfn = jnt.join(f.split('_'))
          if not newfn in files: # if file name already exist, file# add 1
            os.rename(root + '/' + f, root + '/' + newfn)
            break
          print ("filename ", newfn, "exist")
          s = s+1

    else:
      next
    

      #print (f, "is not a tiff file")
"R1P01B1T2_0.tif"