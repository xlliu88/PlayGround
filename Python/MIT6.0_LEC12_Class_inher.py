# -*- coding: utf-8 -*-
"""
Created on Mon Feb  6 21:42:56 2017

@author: xunliangliu
"""

class Person(object):
    from datetime import datetime as dt
    def __init__(self, name):
        self.name = name
        try:
            firstblank = name.rindex(' ')
            self.lastname = name[firstblank+1:]
        except:
            self.lastname = name
        self.birthday = None
    def getName(self):
        return self.name
    def setBirthday(self, bd):
        assert type(bd) == dt
        self.birthday = bd
    def getAge(self):
        if not self.birthday == None:
            return (dt.today() - self.birthday).days//365
        else:
            return None
    def __lt__(self,other):
        assert type(other) == Person
        if self.lastname == other.lastname:
            return self.name < other.name
        return self.lastname < other.lastname
    def __str__(self):
        return self.name
    
class MITperson(Person): # a sub class of Person
    nextIDnum = 0
    def __init__(self,name):
        Person.__init__(self,name)     # why?
        self.IDnum = self.nextIDnum + 1
        MITperson.nextIDnum += 1
    def getID(self):
        return self.IDnum
    def isStudent(self):
        return type(self) == UnderGrad or type(self) == Grad

class UnderGrad(MITperson):
    def __init__(self,name):
        MITperson.__init__(self,name)
        self.year = None
    def setYear(self,year):
        if year > 5:
            raise OverflowError ("Too many years")
        self.year = year
class Grad(MITperson):
    pass # can use a pass statment as a place holder

          
class Course(object):
    def __init__(self, number):
        self.number = number
        self.students = []
    def addStudent(self, who):
        if not who.isStudent():
            raise TypeError ("%s is not a student"%who)
        if who in self.students:
            raise ValueError ("%s is in the list" % who)
        self.students.append(who)
    def rmStudent(self,who):
        if not who in self.students:
            raise ValueError ("%s is not in the list" % who)
        self.students.remove(who)
    def allStudents(self):
        for s in self.students:
            yield s
    def ugStudents(self):
        for s in self.students:
            if type(s) == UnderGrad:
                yield s

            
if __name__ == "__main__":    
    import datetime.datetime as dt      
    m1 = MITperson('Barbara Beaver')            
    ug1 = UnderGrad('Jane Doe')
    ug1.getBirthday = dt.strptime("1983-11-15","%Y-%m-%d")
    ug2 = UnderGrad('John Doe')
    ug2.getBirthday = dt.strptime("1983-7-15","%Y-%m-%d")
    g1 = Grad('Mitch Peabody')
    g2 = Grad('Ryan Jackson')
    g3 = Grad('Sarina Canelake')
    MIT600 = Course('6.00')
    MIT600.addStudent(ug1)
    MIT600.addStudent(g1)
    MIT600.addStudent(ug2)
    try:
        MIT600.addStudent(m1)
    except:
        print ('Whoops')
    print (MIT600) #Perhaps not what one expected
    for st in MIT600.students:
        print (st)