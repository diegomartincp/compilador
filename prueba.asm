 
.data #Variables
  variable0: .float 3.000000
  variable1: .float 2.000000

.text #Operaciones
  lwc1 $f0, variable0
  lwc1 $f1, variable1
  sgt $f2, $f0, $f1
 
.data #Variables
  variable2: .float 1.000000

.text #Operaciones
  lwc1 $f0, variable2
  li $v0, 2
  mov.s $f12, $f0
  syscall
   beq $f2, 0, etiq0
etiq0:
 
.data #Variables
  variable3: .float 2.000000

.text #Operaciones
  lwc1 $f1, variable3
  li $v0, 2
  mov.s $f12, $f1
  syscall
