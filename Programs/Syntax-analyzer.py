EOT = chr(0)
ch = EOT
pos = -1
NO_ERROR = -666
errPos = NO_ERROR
s = ''

def resetText():
    global s, pos, errPos
    s = input("Запишите отношение: ")
    print(s)
    pos = -1
    errPos = NO_ERROR
    nextCh()

def error(msg):
    global errPos
    if errPos == NO_ERROR:
        print(' ' * pos, end='')
        print('^')
        print(msg)
        errPos = pos

def nextCh():
    global pos, ch, s
    while True:
        if pos + 1 < len(s):
            pos += 1
            ch = s[pos]
        else:
            pos += 1
            ch = EOT
        if ch != ' ':
            break

def Name():
    if ('a' <= ch <= 'z') or ('A' <= ch <= 'Z'):
        nextCh()
    else:
        error('Ожидается буква')
    while (('a' <= ch <= 'z') or ('A' <= ch <= 'Z')) or ('0' <= ch <= '9'):
        nextCh()

def Number():
    if '0' <= ch <= '9':
        nextCh()
    else:
        error('Ожидается цифра')
    while '0' <= ch <= '9':
        nextCh()

def Operand():
    if ('a' <= ch <= 'z') or ('A' <= ch <= 'Z'):
        Name()
    elif '0' <= ch <= '9':
        Number()
    else:
        error('Ожидается операнд')

def Sign():
    if ch == '>':
        nextCh()
        if ch == '=':
            nextCh
    elif ch == '<':
        nextCh()
        if ch == '>' or ch == '=':
            nextCh()
    elif ch == '=':
        nextCh()
    else:
        error('Ожидается знак сравнения')

def Relation():
    Operand()
    Sign()
    Operand()

while True:
    resetText()
    Relation()
    if ch == EOT and errPos == NO_ERROR:
        print('Правильно')
    else:
        error('Ожидается конец текста')
