       
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 3.000000
  variable1: .float 2.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  add.s $f2, $f0, $f1
  lwc1 $f-1, variable2
  c.le.s $f-1, $f2
  bc1f etiq0
  lwc1 $f-1, variable4
  lwc1 $f-1, variable3
  div.s $f-1, $f-1, $f-1
  lwc1 $f-1, variable5
  lwc1 $f-1, variable6
  add.s $f-1, $f-1, $f-1
  lwc1 $f-1, variable7
  c.le.s $f-1, $f-1
  bc1f etiq1
  li $v0, 2
  add.s $f12, $f31, $f-1
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq1:
etiq0:
