             
.data #Variables
newLine: .asciiz "\n"
  variable0: .float 1.000000
  variable1: .float 2.000000
  variable2: .float 3.000000
  variable7: .float 99.000000
  variable10: .float 88.000000
  variable11: .float 12.000000
  variable12: .float 13.000000

.text #Operaciones
  lwc1 $f0, variable0
  lwc1 $f1, variable1
  lwc1 $f3, variable2
  c.lt.s $f3, $f0
  bc1t etiq0
  c.lt.s $f3, $f1
  bc1t etiq0
  lwc1 $f9, variable7
  li $v0, 2
  mov.s $f12, $f9
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  c.lt.s $f3, $f3
  bc1t etiq0
  lwc1 $f13, variable10
  li $v0, 2
  mov.s $f12, $f13
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
  lwc1 $f17, variable11
  li $v0, 2
  mov.s $f12, $f17
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq1:
  lwc1 $f21, variable12
  li $v0, 2
  mov.s $f12, $f21
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq2:
