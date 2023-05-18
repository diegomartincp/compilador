
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 9.100000
  variable1: .float 2.000000
  variable2: .float 9.000000
  variable3: .float 2.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  li $v0, 2
  add.s $f12, $f31, $f0
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  lwc1 $f3, variable2
  lwc1 $f4, variable3
  div.s $f5, $f3, $f4
  li $v0, 2
  add.s $f12, $f31, $f5
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
