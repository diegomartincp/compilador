 
.data #Variables
  variable0: .float 12.000000

.text #Operaciones
  lwc1 $f0, variable0
 
.data #Variables
  variable1: .float 12.000000
  variable2: .float 3.000000

.text #Operaciones
  lwc1 $f1, variable1
  lwc1 $f2, variable2
  add.s $f3, $f1, $f2

.data #Variables
  variable4: .float 10.000000

.text #Operaciones
  lwc1 $f1, variable4
  sub.s $f2, $f3, $f1
  li $v0, 2
  mov.s $f12, $f2
  syscall
