def term_to_array(term):
    '''Converts abcd to [1,1,1,1]'''

    i = 0
    L = []
    while i < len(term) - 1:
        if term[i + 1] == '\'':
            L.append(0)
            i += 2
        else:
            L.append(1)
            i += 1
    if term[-1] != "'":
        L.append(1)
    return L


def array_to_term(array):
    '''Converts [1,1,1,1] to abcd'''
    s = ""
    for i in range(len(array)):
        if array[i] == 0:
            s += chr(97 + i) + "'"
        elif array[i] == 1:
            s += chr(97 + i)
        else:
            pass
    return s


l = []


def MarkRegion(Array):
    m = []
    k = len(Array)
    n = len(Array[0])
    p = [0] * k
    # Making the list m -- it contains all the possible expansions
    # p is an indicator list -- it has 1 at the positions where there is possibility for expansion
    for i in range(k):

        for j in range(i + 1, k):
            r = 0
            for t in range(n):
                if Array[i][t] == Array[j][t]:
                    r += 1
            if r == n - 1:
                p[i] = 1
                p[j] = 1
                o = []
                for b in range(n):

                    if Array[i][b] == Array[j][b]:

                        o.append(Array[i][b])
                    else:
                        o.append('x')
                if demo == "Y":
                    print("The elements combining are: ", array_to_term(Array[i]), "and", array_to_term(Array[j]))
                    print("The combined term is: ", array_to_term(o))

                m.append(o)

    for g in range(k):
        if p[g] == 0:
            l.append(Array[g])
            # If there are no further possibilities for expansion, we append the array to the list

    # Recursion
    if len(m) != 0:
        MarkRegion(m)
    else:
        return


def find(v, w):
    MarkRegion(v)

    # to remove redundencies in the list l:
    n = len(l)
    for i in range(n):
        j = i + 1
        while j < n:
            if l[i] == l[j]:
                l.pop(j)
                j -= 1
                n -= 1
            j += 1
    if demo == "Y":
        print("The final list is: ")
        for i in l:
            print(array_to_term(i), end=" ")
        print()
    # To find the maximum expanded term corresponding to each term in func_True
    output = []
    for i in range(len(w)):
        max_x = 0
        max_Expansion = []
        for j in range(len(l)):
            count_x = 0
            correspondence = 0
            for k in range(len(w[0])):

                if l[j][k] == 'x':
                    count_x += 1
                if (l[j][k] == 'x' or l[j][k] == w[i][k]):
                    correspondence += 1
            if correspondence == len(w[0]):
                if count_x >= max_x:
                    max_x = count_x
                    max_Expansion = l[j]

        output.append(max_Expansion)
    return output


# n^2*N^(2logn)

def comb_function_expansion(func_TRUE, func_DC):
    """
    determines the maximum legal region for each term in the K-map function
    Arguments:
    func_TRUE: list containing the terms for which the output is '1'
    func_DC: list containing the terms for which the output is 'x'
    Return:
    a list of terms: expanded terms in form of boolean literals
    """
    func_TRUE = [term_to_array(i) for i in func_TRUE]
    func_DC = [term_to_array(i) for i in func_DC]
    out = find(func_TRUE + func_DC, func_TRUE)
    if out.count(['x', 'x']) == len(out):
        return [None] * len(out)
    out = [array_to_term(i) for i in out]
    l.clear()
    return out


demo = input("Do you want a demo?(Y/N) ")
#print(comb_function_expansion(["a'b'c'", "ab'c'", "a'bc", "a'bc'", "abc'"], ["ab'c"]))

#print(comb_function_expansion(["a'b'c'", "ab'c'", "a'bc", "a'bc'", "abc'"], ["ab'c"]))
print(comb_function_expansion(["a'b'c'd'", "a'bc'd", "abc'd'", "ab'c'd'", "a'bcd", "ab'cd"], ["a'b'cd", "abcd"]))
print(comb_function_expansion(
    ["a'b'c'd'e'f", "a'b'c'de'f'", "a'b'cd'e'f", "a'b'cde'f'", "a'bc'd'e'f", "a'bc'd'ef", "a'bc'de'f'", "a'bc'def",
     "a'bcd'e'f", "a'bcd'ef'", "a'bcd'ef", "a'bcde'f'", "ab'c'd'e'f", "ab'cd'e'f'", "ab'cd'e'f", "ab'cd'ef'",
     "ab'cd'ef", "ab'cde'f'", "ab'cde'f", "ab'cdef'", "ab'cdef", "abc'd'e'f", "abc'de'f", "abcd'e'f"],
    ["a'b'c'd'e'f'", "abc'def'"]))
print(comb_function_expansion(
    ["a'b'cdefgh", "a'b'cdefgh'", "a'b'cdef'gh'", "a'b'cd'e'fgh", "a'bcd'ef'gh'", "a'bcdefgh'", "a'bc'd'e'fg'h",
     "abc'd'e'fg'h", "a'bc'd'efgh'", "abc'd'efgh'", "abc'def'g'h'", "abcdef'g'h'", "abcd'ef'g'h'", "abcd'ef'g'h",
     "ab'c'de'f'g'h'", "ab'c'd'e'f'g'h'"], ["a'bcd'efgh", "a'bcd'efgh'", "abcdef'g'h"]))
#print(comb_function_expansion(
    # ["ab'c'de'fgh'i'j'", "ab'c'de'fgh'ij", "ab'c'de'fgh'ij'", "ab'c'de'fghij", "ab'c'de'fghi'j", "a'b'c'def'gh'i'j'",
    #  "a'b'cdef'gh'i'j'", "a'bcd'ef'g'hij", "abc'd'e'fgh'ij", "abc'de'fgh'ij'"],
    # ["ab'c'de'fgh'i'j", "ab'c'de'fghij'", "ab'c'de'fghi'j'", "abc'de'fgh'ij", "abc'd'e'fgh'ij'"]))
#print(comb_function_expansion(
    # ["abcdefghijklmno", "abcdefghijklm'n'o'", "abcdefghijklmn'o", "abcdefghijklm'n'o", "abcdefghijklm'no'"],
    # ["abcdefghijklm'no", "abcdefghijklmn'o'", "abcdefghijklmno'"]))
