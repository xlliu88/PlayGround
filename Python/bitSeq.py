# -*- coding: utf-8 -*-
"""
Created on Fri Feb 10 20:54:01 2017

@author: xunliangliu
"""



import time

def seqBit(seq):
    ntBit = {"A":0b00, "T":0b11, "C":0b01, "G":0b10}
    bitSeq = 0b11
    for c in seq:
        bitSeq = (bitSeq << 2) + ntBit[c]
    return bitSeq

def bitSeq(bseq):
    bitNt = {0:'A', 3:"T", 1:"C", 2:"G"}
    seq = ''
    
    while bseq:
        b = (bseq >> 2 << 2)^bseq
        seq = seq + bitNt[b]
        bseq >>= 2
    seq = seq[::-1]
    return seq[1:]
    
def test():
    '''To demonstrate that whatever nt a sequence startwith, 
    it can be converted correctly
    '''
    
    for nt in ['AT','TC','CA','GT']:
        bseq = seqBit(nt)
        seq2 = bitSeq(bseq)
        print("Bitseq: ", bseq)
        print("seq from bit: ", seq2)
        
        
        
test()
seq = 'GTGGAGCTGATATTATTATTCTTCTTTCTGATGGCACTGTTGGTATCTCTCTCCTCTTCAAGTTCCATATCGGATGGTGTGTTTGAATCACAAACCTCGGTTAGTGGAAGGAACCTTCGTCATGCCAAGAAAAAATGTGAAGTGAACTTTGAGTATATGGACTACAAGGTCTTGACAAAGAGGTGCAAAGGTCCAGCGTTTCCAGCCAAAGAATGTTGCTCTGCTTTTAAAGAATTTGCATGTCCTTACGTGAGTCAGATCAACGACATGAATAGTGATTGTGCACAGACAATGTTCAGCTACATGAATATTTATGGAAACTACCCTACTGGCCTTTTCGCTAACGAGTGCAGAGAAAGGAAAGATGGGCTTGTTTGCCCTTTACCACCTCTCTATTCACATAACCTAAACGCCTCAACTGCTGATTCGACTCCTCGTTTTATCTCGCTGTTGATCTCTGCTGCAACCGCTGTTTTTGCTTTGTTAGTGTTGACTTGA'
bseq = seqBit(seq)
seq2 = bitSeq(bseq) 
        

def bittest(n):
    t1 = time.time()
    for i in range(n):
        
        if nt['A']^nt['T'] == 3:
            r = "comp"
        elif nt['A']^nt['G'] == 0:
            r = 'match'
        else:
            continue
    t2 = time.time()
    
    return t2-t1

def lettertest(n):
    t1 = time.time()
    for i in range(n):
        if nt2["A"] == "T":
            r = 'comp'
        elif nt2["A"] == "A":
            r = 'match'
        else:
            continue
    t2 = time.time()
    return t2 - t1
        
        
nt = {"A":0b00, "T":0b11, "C":0b01, "G":0b10}
nt2 = {"A":"T", "T":"A", "C":"G", "G":"C"}


t1 = time.time()
0b00^0b11 == 3
t2 = time.time()
t2 - t1
print(bittest(10000))
print(lettertest(10000))

print(nt[0]^nt[0])
print(nt[0]^nt[1])
print(nt[0]^nt[2])
print(nt[0]^nt[3])

x = -5
b = x.bit_length()
x = x >> x.bit_length()