       
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 3.000000
  variable1: .float 5.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  li  $t0, 0
  li  $t1, 10
  etiq0:
  slt $t2, $t1, $t0
  beq $t2, 1, etiq1
  lwc1 $f2, variable1
  add.s $f3, $f0, $f2
  mov.s $f0, $f3
  li $v0, 2
  add.s $f12, $f31, $f0
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  addi $t0, $t0, 1
  j etiq0
  etiq1:
