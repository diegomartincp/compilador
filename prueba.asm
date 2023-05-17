   
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 3.000000
  variable1: .float 2.000000
  variable2: .float 5.000000
  variable3: .float 55.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  add.s $f2, $f0, $f1
  lwc1 $f3, variable2
  c.eq.s $f2, $f3
  mov.s $f4, $f2
  bc1f etiq0
  lwc1 $f6, variable3
  li $v0, 2
  add.s $f12, $f31, $f6
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
