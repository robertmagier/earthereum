
class Person:
    __name=''
    __lastName=''

    def sgetsName (self):
        return self.__name

    def setName (self,name):
        self.__name = name

osoba = Person()
osoba.setName('Wojtek')
print(osoba)
print(osoba.sgetsName())
print(osoba.__name)
