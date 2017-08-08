#!/bin/usr/python3.4.exe
#June 28, 2015
#used to rename files
#it will rename all files in current directory and subdirs. 
#it will also rename sub dirs

import os
import re
#L:\MitchumLab\Individual Lab Folders\XunliangLiu\potato_peptide\20170721_xylem_cytoledon\cropped
os.chdir("L:/MitchumLab/Individual Lab Folders/XunliangLiu/potato_peptide/20170721_xylem_cytoledon\cropped")
for fn in os.listdir('.'):
    #print (os.path.splitext(fn)[1])
    if os.path.isfile(fn) and (os.path.splitext(fn)[1] in ['.tif', '.tiff']):
        if len(fn.split('_')) > 2 :
            subfn = '_'.join(fn.split('_')[2:])
            #if len(subfn.split(' ')) < 2:
            #    subfn = '20160210 ' + subfn
            if '.tif.tif' in subfn:
                subfn = re.sub('.tif.tif','.tif',subfn)
            print('rename %s to %s' % (fn, subfn))
            os.rename(fn, subfn)
        else: 
            print('%s not renamed' % fn)
            continue
