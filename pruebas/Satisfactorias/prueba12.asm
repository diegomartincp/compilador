                 
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 0.000000
  variable1: .float 100.000000
  variable2: .float 10.000000
  variable3: .float 2.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f2, variable1
  li  $t3, 1
  li  $t4, 5
  etiq0:
  slt $t5, $t4, $t3
  beq $t5, 1, etiq1
  lwc1 $f5, variable2
  add.s $f6, $f0, $f5
  mov.s $f0, $f6
  li  $t0, 1
  li  $t1, 10
  etiq2:
  lwc1 $f8, variable3
  sub.s $f9, $f2, $f8
  mov.s $f2, $f9
  addi $t0, $t0, 3
  slt $t2, $t0, $t1
  beq $t0, $t1, etiq2
  beq $t2, $zero, etiq3
  beq $t2, 1, etiq2
  etiq3:
  addi $t3, $t3, 1
  j etiq0
  etiq1:
  li $v0, 2
  add.s $f12, $f31, $f0
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  li $v0, 2
  add.s $f12, $f31, $f2
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
