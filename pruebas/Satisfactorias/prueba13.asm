          
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 1.000000
  variable1: .float 3.000000
  variable2: .float 2.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f2, variable1
  c.lt.s $f0, $f2
  bc1f etiq0
  li  $t0, 1
  li  $t1, 10
  etiq1:
  lwc1 $f7, variable2
  add.s $f8, $f0, $f7
  mov.s $f0, $f8
  addi $t0, $t0, 1
  bne $t0, $t1, etiq1
  etiq2:
etiq0:
  li $v0, 2
  add.s $f12, $f31, $f0
  syscall
  li $v0, 4
  la $a0, newLine
  syscall