
.data #Variables
  variable0: .float 2.000000
  variable1: .float 2.000000

.text #Operaciones
  lwc1 $f0, variable0
  lwc1 $f1, variable1
  mul.s $f2, $f0, $f1
  li $v0, 2
  mov.s $f12, $f2
  syscall
