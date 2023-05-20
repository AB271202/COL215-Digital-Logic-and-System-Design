import time


def term_to_array(term):
    """Converts abcd to [1,1,1,1]"""
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
    """Converts [1,1,1,1] to abcd"""
    s = ""
    for i in range(len(array)):
        if array[i] == 0:
            s += chr(97 + i) + "'"
        elif array[i] == 1:
            s += chr(97 + i)
        else:
            pass
    return s


def array_to_term2(array):
    s = ""
    for i in range(len(array)):
        if i == len(array) - 1:
            if array[i] == 0:
                s += "( not " + chr(97 + i) + ")"
            elif array[i] == 1:
                s += chr(97 + i)
            else:
                pass
        else:
            if array[i] == 0:
                s += "( not " + chr(97 + i) + ") and "
            elif array[i] == 1:
                s += chr(97 + i) + " and "
            else:
                pass
    return "("+s+")"


# Order of both the above functions is O(k) where k is the number of variables

l = []


def sort_ans(e):
    numx = e.count('x')
    return numx


def getmin(term, min_list):
    """Get the minterms making up a term"""
    if term.count('x') == 0:
        min_list.append(tuple(term))
    else:
        for i in range(len(term)):
            if term[i] == 'x':
                if i != len(term) - 1:
                    getmin(term[0:i] + [1] + term[i + 1:], min_list)
                    getmin(term[0:i] + [0] + term[i + 1:], min_list)
                    break
                else:
                    getmin(term[0:i] + [1], min_list)
                    getmin(term[0:i] + [0], min_list)


# ml=[]
# getmin(['x',1,1,'x'],ml)
# print(ml)

def contains(term, minterm):
    for i in range(len(term)):
        if term[i] == 'x':
            continue
        elif term[i] != minterm[i]:
            return False
    return True


def find_neighbors(i):
    l = i
    neighbors = []
    n = len(l)
    for j in range(len(l)):
        if l[j] == 'x':
            continue
        else:
            l1 = []
            if l[j] == 0:
                if j != n - 1:
                    l1 = l[0:j] + [1] + l[j + 1:n]
                else:
                    l1 = l[0:j] + [1]
            if l[j] == 1:
                if j != n - 1:
                    l1 = l[0:j] + [0] + l[j + 1:n]
                else:
                    l1 = l[0:j] + [0]
            neighbors.append(tuple(l1))
    return neighbors


def MarkRegion(Array):
    s1 = Array

    Array = []
    A = list(s1)
    for i in A:
        Array.append(list(i))

    s = set()
    for i in Array:
        s.add(tuple(i))
    m = set()
    n = len(Array[0])
    for i in Array:
        neighbors = find_neighbors(i)
        count = 0
        for k in neighbors:
            if tuple(k) in s:
                o = []
                for b in range(n):

                    if i[b] == k[b]:

                        o.append(i[b])
                    else:
                        o.append('x')

                m.add(tuple(o))
                count = 1
        # if count==1:
        # s.remove(tuple(i))
        if (count == 0):
            l.append(i)
        # if (count == 1):
        # s.discard(tuple(i))
    if (len(m) != 0):
        MarkRegion(list(m))


def opt_function_reduce(func_TRUE, func_DC):
    """
    determines the minimum number of sum of product terms for the given K-map function
    Arguments:
    func_TRUE: list containing the terms for which the output is '1'
    func_DC: list containing the terms for which the output is 'x'
    Return:
    a list of minimum size containing terms: terms in form of boolean literals
    """
    func_TRUE = [term_to_array(i) for i in func_TRUE]
    func_DC = [term_to_array(i) for i in func_DC]
    MarkRegion(func_TRUE + func_DC)

    s = set()
    for i in l:
        s.add(tuple(i))
    l.clear()
    l.extend(list(i) for i in s)
    l.sort(key=sort_ans)
    k = [array_to_term(i) for i in l]
    if demo == 'Y': print("The initial list l is: ", k)

    s = set(tuple(i) for i in func_TRUE)
    answer = []
    d = dict()
    for j in s:
        d[j] = 0

    for i in l:
        m = []
        getmin(i, m)
        for j in m:
            if j in s:
                d[j] += 1

    for i in l:
        m = []
        getmin(i, m)
        need = 0
        for j in m:
            try:
                if d[j] == 1:
                    need = 1

                    break

            except KeyError:
                pass

        if need:
            if demo == 'Y':
                print("Minterms: ")
                for each in m:
                    if each in d.keys():
                        print("\t", array_to_term(each))
                print(f"are already contained in {array_to_term(i)}")
                print()

            answer.append(array_to_term2(i))
        else:
            for jh in m:
                try:
                    d[jh] -= 1
                except KeyError:
                    pass

    l.clear()
    if answer == ['']:
        return [None]
    return answer


demo = 0


# t = time.time()
# func_TRUE = ["a'bc'd'", "abc'd'", "a'b'c'd", "a'bc'd", "a'b'cd"]
# func_DC = ["abc'd"]
# print(opt_function_reduce(func_TRUE, func_DC))
#
# func_TRUE = ["a'b'c'd", "a'b'cd", "a'bc'd", "abc'd", "abc'd'", "ab'c'd'", "ab'cd"]
# func_DC = ["a'bc'd'", "a'bcd", "ab'c'd"]
# print(opt_function_reduce(func_TRUE, func_DC))
#
# func_TRUE = ["a'b'c", "a'bc", "a'bc'", "ab'c'"]
# func_DC = ["abc'"]
# print(opt_function_reduce(func_TRUE, func_DC))
#
# func_TRUE = ["a'b'c'd'e'", "a'bc'd'e'", "abc'd'e'", "ab'c'd'e'", "abc'de'", "abcde'",
#               "a'bcde'", "a'bcd'e'", "abcd'e'", "a'bc'de", "abc'de", "abcde",
#              "a'bcde", "a'bcd'e", "abcd'e", "a'b'cd'e", "ab'cd'e"]
# func_DC = []
# print(opt_function_reduce(func_TRUE, func_DC))
#
# func_TRUE = ["ab", "ab'", "a'b", "a'b'"]
# func_DC = []
# print(opt_function_reduce(func_TRUE, func_DC))
#
# func_TRUE = ["a'b'c'd'", "a'b'cd", "a'bc'd", "a'bcd'", "abc'd'", "abcd", "ab'c'd", "ab'cd'"]
# func_DC = []
# print(opt_function_reduce(func_TRUE, func_DC))
#
# func_TRUE = []
# getmin(['x'] * 11, func_TRUE)
#
# func_TRUE = [array_to_term(i) for i in func_TRUE]
#
# func_DC = []
# print(opt_function_reduce(func_TRUE, func_DC))
def binary(i):
    s = []
    while i != 0:
        s.append(i % 2)
        i = i // 2
    s.reverse()
    if len(s) != 4:
        s = [0] * (4 - len(s)) + s
    return s


# func_TRUE=["a'b'c'd","a'bcd","abc'd'","a'bc'd","a'bcd'","abc'd","abcd","ab'cd"]
# func_DC=[]
# print(opt_function_reduce(func_TRUE, func_DC))
# print("Time:", time.time() - t)
L = [[0, 0, 0, 0, 0, 0, 1], [1, 0, 0, 1, 1, 1, 1], [0, 0, 1, 0, 0, 1, 0], [0, 0, 0, 0, 1, 1, 0], [1, 0, 0, 1, 1, 0, 0],
     [0, 1, 0, 0, 1, 0, 0], [0, 1, 0, 0, 0, 0, 0], [0, 0, 0, 1, 1, 1, 1], [0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0],
     [0, 0, 0, 0, 0, 1, 0], [1, 1, 0, 0, 0, 0, 0], [0, 1, 1, 0, 0, 0, 1], [1, 0, 0, 0, 0, 1, 0], [0, 1, 1, 0, 0, 0, 0],
     [0, 1, 1, 1, 0, 0, 0]]
for i in range(len(L[0])):
    func_TRUE = []
    for j in range(len(L)):
        if L[j][i] == 1:
            func_TRUE.append(array_to_term(binary(j)))
    # print(opt_function_reduce(func_TRUE, []))
    S = opt_function_reduce(func_TRUE, [])
    print(f"o{i + 1} <= " + " or ".join(S) + ";")
