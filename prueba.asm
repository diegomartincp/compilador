
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 9.000000
  variable1: .float 10.000000
  variable2: .float 99.000000
  variable3: .float 88.000000
  variable4: .float 22.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  c.lt.s $f0, $f1
  bc1f etiq0
  lwc1 $f4, variable2
  li $v0, 2
  add.s $f12, $f31, $f4
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  j etiq1
etiq0:
  lwc1 $f6, variable3
  li $v0, 2
  add.s $f12, $f31, $f6
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq1:
  lwc1 $f9, variable4
  li $v0, 2
  add.s $f12, $f31, $f9
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
