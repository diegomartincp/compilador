     
.data #Variables
newLine: .asciiz "\n"
  variable0: .float 0.000000
  variable2: .float 3.000000
  variable5: .float 1.000000

.text #Operaciones
  lwc1 $f0, variable0
  etiq0:
  lwc1 $f1, variable2
  c.lt.s $f0, $f1
  bc1f etiq1
  li $v0, 2
  mov.s $f12, $f0
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  lwc1 $f5, variable5
  add.s $f6, $f0, $f5
  j etiq0
etiq1:
