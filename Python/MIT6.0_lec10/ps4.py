# 6.00 Problem Set 4
#
# Caesar Cipher Skeleton
#
import string
import random
import time

WORDLIST_FILENAME = ".\MIT6.0_lec10\words.txt"

# -----------------------------------
# Helper code
# (you don't need to understand this helper code)
def load_words():
    print ("Loading word list from file...")
    with open(WORDLIST_FILENAME, 'r') as inFile:
        line = inFile.readline()
        wordlist = line.split()
        print ("  ", len(wordlist), "words loaded.")
    return wordlist

wordlist = load_words()

def is_word(wordlist, word):
    """
    Determines if word is a valid word.
    """
    word = word.lower()
    word = word.strip(" !@#$%^&*()-_+={}[]|\:;'<>?,./\"")
    return word in wordlist

def random_word(wordlist):
    """
    Returns a random word from wordlist.
    """
    return random.choice(wordlist)

def random_string(wordlist, n):
    """
    Returns a string containing n random words from wordlist
    """
    return " ".join([random_word(wordlist) for _ in range(n)])

def random_scrambled(wordlist, n):
    """
    Generates a test string by generating an n-word random string
    and encrypting it with a sequence of random shifts.
    """
    s = random_string(wordlist, n) + " "
    shifts = [(i, random.randint(0, 26)) for i in range(len(s)) if s[i-1] == ' ']
    return apply_shifts(s, shifts)[:-1]

def get_fable_string():
    """
    Returns a fable in encrypted text.
    """
    f = open("fable.txt", "r")
    fable = str(f.read())
    f.close()
    return fable


# (end of helper code)
# -----------------------------------

#
# Problem 1: Encryption
#
def build_coder(shift):
    """
    Returns a dict that can apply a Caesar cipher to a letter.
    The cipher is defined by the shift value. Ignores non-letter characters
    like punctuation and numbers.

    shift: -27 < int < 27
    returns: dict
    """
    lets1 = [chr(i) for i in range(97,123)] + [' ']
    lets2 = [chr(i) for i in range(65,91)]
    shift %= len(lets1)

    code = {ch:lets1[(idx+shift)%len(lets1)] for idx, ch in enumerate(lets1)}
    code2 = {ch:lets2[(idx+shift)%len(lets2)] for idx, ch in enumerate(lets2)}
    code.update(code2)
    return code

def build_encoder(shift):
    """
    Returns a dict that can be used to encode a plain text. For example, you
    could encrypt the plain text by calling the following commands
    
    The cipher is defined by the shift value. Ignores non-letter characters
    like punctuation and numbers.
    """
    encode = build_coder(shift)
    return encode
    ### TODO.

def build_decoder(shift):
    """
    Returns a dict that can be used to decode an encrypted text. For example, you
    could decrypt an encrypted text by calling the following commands
    
    The cipher is defined by the shift value. Ignores non-letter characters
    like punctuation and numbers.
    """
    decode = {v:k for k,v in build_coder(shift).items()}
    return decode


def apply_coder(text, coder):
    """
    Applies the coder to the text. Returns the encoded text.

    text: string
    coder: dict with mappings of characters to shifted characters
    """
    # list complihansive is faster than for loop
    encoded = [coder[c] if (c.isalpha() or c == ' ') else c for c in text ]
    return ''.join(encoded)
    ### TODO.
def apply_shift(text, shift):
    """
    Given a text, returns a new text Caesar shifted by the given shift
    offset. The empty space counts as the 27th letter of the alphabet,
    so spaces should be replaced by a lowercase letter as appropriate.
    Otherwise, lower case letters should remain lower case, upper case
    letters should remain upper case, and all other punctuation should
    stay as it is.
    """
    # list complihansive is faster than for loop
    code = build_coder(shift)
    shifted = [code[c] if (c.isalpha() or c == ' ') else c for c in text ]
    return ''.join(shifted)
    
# Problem 2: Codebreaking.
#
def find_best_shift(wordlist, text):
    """
    Decrypts the encoded text and returns the plaintext.

    text: string
    returns: 0 <= int < 27
    """
    
    for i in range(0, 27):
        decode = build_decoder(i)
        word = ''
        msg = ''
        for c in text:
            #print(c)
            if c.isalpha() or c == ' ':
                c =  decode[c]
            if not c.isalpha():
                if word and not is_word(wordlist, word):
                    break
                word = ''
            else:
                word += c
            msg += c
            
        else:
            return msg, i
    else:
        print('no best shifting found!')
        return None
# Problem 3: Multi-level encryption.
#
def find_best_shift2(wordlist,text):
    ''' this implementation reads better'''
    for i in range(0,27):
        word = ''
        msg = ''
        decode = build_decoder(i)

        for idx, c in enumerate(text):
            if c.isalpha() or c == ' ':
                c = decode[c]
            word += c
            
            if c == ' ' or idx == (len(text) - 1):
                if is_word(wordlist, word):
                    msg += word
                    word = ''
                else:
                    break
        else:
            return msg, i
    else:
        print('No best shifting found!')
        return None
                
                
                
def apply_shifts(text, shifts):
    """
    Applies a sequence of shifts to an input text.

    text: A string to apply the Ceasar shifts to 
    shifts: A list of tuples containing the location each shift should
    begin and the shift offset. Each tuple is of the form (location,
    shift) The shifts are layered: each one is applied from its
    starting position all the way through the end of the string.  
    returns: text after applying the shifts to the appropriate
    positions

    Example:
    >>> apply_shifts("Do Androids Dream of Electric Sheep?", [(0,6), (3, 18), (12, 16)])
    'JufYkaolfapxQdrnzmasmRyrpfdvpmEurrb?'
    """
    for start, shift in shifts:
        left = text[:start]
        right = text[start:]
        text = left + apply_shift(right, shift)
    return text
    
#
# Problem 4: Multi-level decryption.
def find_best_shifts(wordlist, text):
    """
    Given a scrambled string, returns a shift key that will decode the text to
    words in wordlist, or None if there is no such key.

    Hint: Make use of the recursive function
    find_best_shifts_rec(wordlist, text, start)

    wordlist: list of words
    text: scambled text to try to find the words for
    returns: list of tuples.  each tuple is (position in text, amount of shift)
    
    Examples:
    >>> s = random_scrambled(wordlist, 3)
    >>> s
    'eqorqukvqtbmultiform wyy ion'
    >>> shifts = find_best_shifts(wordlist, s)
    >>> shifts
    [(0, 25), (11, 2), (21, 5)]
    >>> apply_shifts(s, shifts)
    'compositor multiform accents'
    >>> s = apply_shifts("Do Androids Dream of Electric Sheep?", [(0,6), (3, 18), (12, 16)])
    >>> s
    'JufYkaolfapxQdrnzmasmRyrpfdvpmEurrb?'
    >>> shifts = find_best_shifts(wordlist, s)
    >>> print apply_shifts(s, shifts)
    Do Androids Dream of Electric Sheep?
    """


def find_best_shifts_rec(wordlist, text, start):
    """
    Given a scrambled string and a starting position from which
    to decode, returns a shift key that will decode the text to
    words in wordlist, or None if there is no such key.

    Hint: You will find this function much easier to implement
    if you use recursion.

    wordlist: list of words
    text: scambled text to try to find the words for
    start: where to start looking at shifts
    returns: list of tuples.  each tuple is (position in text, amount of shift)
    """
    
    #left = text[:start]
    right = text[start:]
    s = find_best_shift(wordlist, right)
    return s
    ### TODO.


def decrypt_fable():
     """
    Using the methods you created in this problem set,
    decrypt the fable given by the function get_fable_string().
    Once you decrypt the message, be sure to include as a comment
    at the end of this problem set how the fable relates to your
    education at MIT.

    returns: string - fable in plain text
    """
    ### TODO.




#What is the moral of the story?
#
#
#
#
#

coder = build_encoder(4)
decoder = build_decoder(3)  
ecd = apply_coder('Hello World!',coder)
msg0 = apply_coder(ecd, decoder)

text = ' '.join(wordlist[104:20101])
text2 = "Do Androids Dream of Electric Sheep?"
s = apply_coder(text, coder) 

t0_1 = time.time()
msg = find_best_shift2(wordlist, s)
dt_1 = time.time() - t0_1
                
t0_2 = time.time()
msg2 = find_best_shift(wordlist, s)
dt_2 = time.time() - t0_2
scrambled = apply_shifts("Do Androids Dream of Electric Sheep?", [(0,6), (3, 18), (12, 16)])