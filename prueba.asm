.data #Variables
  variable0: .float 1.100000
  variable1: .float 2.200000
  variable2: .float 4.000000

.text #Operaciones
  lwc1 $f0, variable0
  lwc1 $f1, variable1
  lwc1 $f2, variable2
  mul.s $f3, $f1, $f2
  add.s $f4, $f0, $f3
