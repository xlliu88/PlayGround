# used to rename files in a directory and all subdirectories
# change file select criteria accordingly;
# change rename rules accordingly;
# Aug 21, 2016
# Xunliang Liu
# xlliu88@gmail.com

import os

for root, dirs, files in os.walk('.'):
    for fn in files:
        print 'Processing file %s'%fn
        if fn.startswith('_'): # file select criteria. aka, which files need rename
            newfn = '_'.join(fn.split('_')[2:]) # rename rules
            if '.tif.tif' in newfn: #additional rename rules
                newfn = newfn.replace('.tif.tif','.tif')

            if newfn in files: # to check if the new file name has any conflict with existing file names
                print 'file %s exist, overwright?' % newfn
                userinput = raw_input('Y/any other key to skip:')
                if not userinput == 'Y':
                    print 'file %s is skipped due to name confliction.' % fn
                    continue
            
            print 'rename ', fn, ' to ', newfn
            os.rename((root + '/' + fn), (root + '/' + newfn)) # rename the file, the file will be in the same folder
        
        else:
            print 'skiping file %s'%fn
            continue