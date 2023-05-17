                          
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 5.000000
  variable1: .float 10.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  add.s $f2, $f0, $f1
  lwc1 $f3, variable2
  c.eq.s $f2, $f3
  mov.s $f4, $f2
  bc1f etiq0
  lwc1 $f4, variable2
  lwc1 $f6, variable3
  lwc1 $f7, variable4
  seq $f8, $f6, $f7
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
  add.s $f12, $f31, $f18
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
