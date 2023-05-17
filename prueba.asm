          
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 80.000000
  variable1: .float 70.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  c.le.s $f1, $f0
  bc1f etiq0
  lwc1 $f-1, variable2
  lwc1 $f-1, variable3
  lwc1 $f-1, variable4
  seq $f-1, $f-1, $f-1
  bc1f etiq1
  lwc1 $f-1, variable5
  add.s $f-1, $f-1, $f-1
  mov.s $f-1, $f-1
etiq1:
  lwc1 $f-1, variable6
  add.s $f-1, $f-1, $f-1
  li $v0, 2
  add.s $f12, $f31, $f-1
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
