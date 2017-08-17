def fib(n):
    a,b = 0,1
    while a < n:
        print(a)
        a,b=b,a+b

fib(60)

a,b=0,1
print(a, b)
while a<60:
    print('a: %d' % (a))
    a,b=b,a+b
    