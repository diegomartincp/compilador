
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 9.000000
  variable1: .float 9.000000
  variable2: .float 10.000000
  variable3: .float 10.000000
  variable4: .float 11.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f2, variable1
  lwc1 $f3, variable2
  c.lt.s $f2, $f3
  bc1f etiq0
  lwc1 $f6, variable3
  li $v0, 2
  add.s $f12, $f31, $f6
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
  lwc1 $f10, variable4
  li $v0, 2
  add.s $f12, $f31, $f10
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
