#!/usr/bin/python3.4.exe
#to sort confocal z stack images
#Xunliang Liu
#Feb 26, 2016

import os
import sys
import re
import shutil


def UserConfirm(select):
    print('You selected %s' % select)
    confirm = input('(y/n?): ')
    if confirm.lower() != 'n':
        return True
    else:
        return False

def DesFold(q_fold):
    """ to list folders match to user's input
        and return the folder of user's choice
    """
    match_fold = list()
    p = '.'
    for item in os.listdir():
        if (q_fold.lower() in item.lower()) and os.path.isdir(item):
            print('find folder %s'  % item)
            match_fold.append(item)
        else:
            continue
    
    print ('%d folder match to your input %s' % (len(match_fold), q_fold))
    print('No.\tfolder name')
    for fold in match_fold:
        print ('%d\t%s' % (match_fold.index(fold) + 1, fold))
    
    while True:
        select = input('Enter the fold Number (press q to exit): ')
        try:
            select = int(select)
            if select > len(match_fold):
                print ('select out of range. only %d folder found' % len(match_fold))
                continue
            else:
                if UserConfirm(match_fold[select-1]):
                    return match_fold[select-1]
                else:
                    continue
        except:
            print('%s is not a number, please try again' % select)
            continue
        
def SetCh():
    """to define channels"""
    channel = dict()
    channel['ch00'] = 'YFP'
    channel['ch01'] = 'mCherry'
    channel['ch02'] = 'BF'
    print ('default settings:')
    for key, value in channel.items():
        print ('%s: %s' % (key, value))
    if UserConfirm('Default'):
        return channel
    else:
        channel = dict()
        print ('Enter channels. press q when finished:')
        x = 0
        while True:
            ch = 'ch0%d'%x
            channel[ch] = input(ch+':')
            if channel[ch].lower() == 'q':
                return channel
                break
            x += 1
    
    
    
def zSort(t_fold, channel):
    """to sort files into different channels"""
    folder = 'empty'
    p = os.path.join('.', t_fold)

    for file in os.listdir(p):
        if os.path.isfile(os.path.join(p,file)) and re.search('_z\d\d', file):  #check if it's a z-stack file
            file_pre = file.split('_z')[0]
            if file_pre != folder:
                folder = file_pre
                print('making fold %s' % folder)
                try:
                    os.makedirs(os.path.join(p,folder))
                except:
                    print ('folder %s exist' % folder)
                    pass
                for key in channel.keys():
                    print ('making folder %s' % channel[key])
                    try:
                        os.makedirs(os.path.join(p, folder, channel[key]))
                    except:
                        print ('folder %s exist' % channel[key])
                        pass
            
            ch = re.findall('_(ch\d\d)',file)
            if ch:
                ch = ch[0]
                print('moving file %s' % file)
                shutil.move(os.path.join(p,file), os.path.join(p, folder, channel[ch]))
            else:
                shutil.move(os.path.join(p,file), os.path.join(p, folder))

            
            
if __name__ == "__main__":
    channel = SetCh()
    folder = input('input folder name: ')
    folder = DesFold(folder)
    zSort(folder, channel)
        