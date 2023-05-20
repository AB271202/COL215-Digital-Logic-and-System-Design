from K_map_gui_tk import *


def is_legal_region(kmap_function, term):
    """

    determines whether the specified region is LEGAL for the K-map function
    Arguments:
    kmap_function: n * m list containing the kmap function
    for 2-input kmap this will 2*2
    3-input kmap this will 2*4
    4-input kmap this will 4*4
    term: a list of size k, where k is the number of inputs in function (2,3 or 4)
    (term[i] = 0 or 1 or None, corresponding to the i-th variable)
    Return:
    three-tuple: (top-left coordinate, bottom right coordinate, boolean value)
    each coordinate is represented as a 2-tuple

    """

    if len(kmap_function) == 2 and len(kmap_function[0]) == 2:
        topleft = [0, 0]
        bottomright = [0, 0]
        term.reverse()
        if term[0] is not None:
            topleft[0] = bottomright[0] = term[0]
        else:
            topleft[0] = 0
            bottomright[0] = 1
        if term[1] is not None:
            topleft[1] = bottomright[1] = term[1]
        else:
            topleft[1] = 0
            bottomright[1] = 1
        boo = True
        for i in range(topleft[0], bottomright[0] + 1):
            for j in range(topleft[1], bottomright[1] + 1):
                if kmap_function[i][j] == 0:
                    boo=False
                    break
        return (tuple(topleft), tuple(bottomright), boo)

    if len(kmap_function) == 4:
        LU = 0
        RU = 0
        LL = 0
        RL = 0
        if (term[0] == 0):
            if (term[1] == 1):
                LU = 1
                RU = 1
            elif (term[1] == 0):
                LU = 0
                RU = 0
            elif (term[1] == None):
                LU = 0
                RU = 1
        elif (term[0] == 1):
            if (term[1] == 1):
                LU = 2
                RU = 2
            elif (term[1] == 0):
                LU = 3
                RU = 3
            elif (term[1] == None):
                LU = 2
                RU = 3
        elif (term[0] == None):
            if term[1] == None:
                LU = 0
                RU = 3
            elif (term[1] == 1):
                LU = 1
                RU = 2
            elif (term[1] == 0):
                LU = 3
                RU = 0
        if (term[2] == 0):
            if (term[3] == 1):
                LL = 1
                RL = 1
            elif (term[3] == 0):
                LL = 0
                RL = 0
            elif (term[3] == None):
                LL = 0
                RL = 1
        elif (term[2] == 1):
            if (term[3] == 1):
                LL = 2
                RL = 2
            elif (term[3] == 0):
                LL = 3
                RL = 3
            elif (term[3] == None):
                LL = 2
                RL = 3
        elif (term[2] == None):
            if term[3] == None:
                LL = 0
                RL = 3
            elif term[3] == 0:
                LL = 3
                RL = 0
            elif term[3] == 1:
                LL = 1
                RL = 2

        list = []
        for i in range(4):
            a = 0
            b = 0
            if i == 0:
                a = 0
                b = 0
            elif i == 1:
                a = 0
                b = 1
            elif i == 2:
                a = 1
                b = 1
            elif i == 3:
                a = 1
                b = 0
            for j in range(4):
                c = 0
                d = 0
                if j == 0:
                    c = 0
                    d = 0
                elif j == 1:
                    c = 0
                    d = 1
                elif j == 2:
                    c = 1
                    d = 1
                elif j == 3:
                    c = 1
                    d = 0
                if ((term[0] == c or term[0] == None) and (term[1] == d or term[1] == None) and (
                        term[2] == a or term[2] == None) and (term[3] == b or term[3] == None)):
                    list.append(kmap_function[i][j])

        for i in list:
            if i == 0:
                return ((LL,LU),(RL,RU),False)

        return ((LL,LU),(RL,RU),True)

    if len(kmap_function) == 2 and len(kmap_function[0]) == 4:
        LU = 0
        RU = 0
        LL = 0
        RL = 0
        if (term[0] == 0):
            if (term[1] == 1):
                LU = 1
                RU = 1
            elif (term[1] == 0):
                LU = 0
                RU = 0
            elif (term[1] == None):
                LU = 0
                RU = 1
        elif (term[0] == 1):
            if (term[1] == 1):
                LU = 2
                RU = 2
            elif (term[1] == 0):
                LU = 3
                RU = 3
            elif (term[1] == None):
                LU = 2
                RU = 3
        elif (term[0] == None):
            if term[1] == None:
                LU = 0
                RU = 3
            elif (term[1] == 1):
                LU = 1
                RU = 2
            elif (term[1] == 0):
                LU = 3
                RU = 0
        if (term[2] == 0):
            LL = 0
            RL = 0
        elif (term[2] == 1):
            LL = 1
            RL = 1
        elif (term[2] == None):
            LL = 0
            RL = 1

        list = []
        for i in range(2):
            a = 0
            if i == 0:
                a = 0
            elif i == 1:
                a = 1
            for j in range(4):
                c = 0
                d = 0
                if j == 0:
                    c = 0
                    d = 0
                elif j == 1:
                    c = 0
                    d = 1
                elif j == 2:
                    c = 1
                    d = 1
                elif j == 3:
                    c = 1
                    d = 0
                if ((term[0] == c or term[0] == None) and (term[1] == d or term[1] == None) and (
                        term[2] == a or term[2] == None)):
                    list.append(kmap_function[i][j])

        for i in list:
            if i == 0:
                return ((LL,LU),(RL,RU),False)

        return ((LL,LU),(RL,RU),True)

'''
if __name__ == '__main__':
    kmp = [[0,1,1,0], ['x',1,'x',0], [1,0,0,0], [1,'x',0,0]]
    term = [1,0,None,0]
    (x1, y1), (x2, y2), boo = is_legal_region(kmp, term)
    if boo:
        color = 'green'
    else:
        color = 'red'
    kmp = kmap(kmp)
    kmp.draw_region(x1, y1, x2, y2, color)
    kmp.mainloop()
'''
