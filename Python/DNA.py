# -*- coding: utf-8 -*-
"""
Created on Tue Feb  7 16:37:32 2017

@author: xunliangliu
"""

def reverse(seq):
    seq = seq.upper()
    return seq[::-1]

def comp(seq):
    nt_pair = {'A':'T','T':'A','C':'G','G':'C','N':'N'}
    seq_comp = ''
    for nt in seq.upper():
        seq_comp = seq_comp + nt_pair[nt]
    return seq_comp

seq = 'GCATGCTCCTCCTGGTCAT'
seq_re = reverse(seq)
seq_c = comp(seq)
seq_rc = reverse(seq_c)
seq2 = 'GGGCGGTCTATGCTTCGCTT'
#
#print (seq_re)
#print (seq_c)
#
#print (seq)
#print (reverse(seq_rc))

with open('result.txt','at') as res:
    res.write(seq + '\n')
    res.write(seq_c + '\n\n')
    #res.write('='* 40 + '\n')