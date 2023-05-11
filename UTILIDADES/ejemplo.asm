 
.data #Variables
  variable0: .float 1.000000
  variable1: .float 1.000000

.text #Operaciones
  lwc1 $f0, variable0
  lwc1 $f1, variable1
  add.s $f2, $f0, $f1
 
.data #Variables
  variable3: .float 2.000000

.text #Operaciones
  lwc1 $f0, variable3
  add.s $f1, $f2, $f0
 
.data #Variables

.text #Operaciones

.data #Variables
  variable6: .float 3.000000

.text #Operaciones
  lwc1 $f0, variable6
  add.s $f12, $f1, $f0
  
  li $v0, 2 
  syscall
