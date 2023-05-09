.data #Variables
  variable0: .float 2.200000
  variable1: .float 3.300000
  variable2: .float 4.400000
  variable4: .float 5.500000

.text #Operaciones
  lwc1 $f0, variable0
  lwc1 $f1, variable1
  lwc1 $f2, variable2
  mul.s $f3, $f1, $f2
  lwc1 $f4, variable4
  div.s $f5, $f3, $f4
  add.s $f6, $f0, $f5
