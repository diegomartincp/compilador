                          
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 5.000000
  variable1: .float 10.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  etiq0:
  lwc1 $f2, variable1
  c.lt.s $f0, $f2
  bc1f etiq1
  lwc1 $f-1, variable2
  add.s $f-1, $f0, $f-1
  mov.s $f0, $f-1
  lwc1 $f-1, variable3
  c.le.s $f-1, $f0
  bc1f etiq2
  lwc1 $f-1, variable4
  li $v0, 2
  add.s $f12, $f31, $f-1
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq2:
  j etiq0
etiq1:
  lwc1 $f-1, variable5
  add.s $f-1, $f0, $f-1
  li $v0, 2
  add.s $f12, $f31, $f-1
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
