            
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 10.000000
  variable1: .float 15.000000
  variable2: .float 2.000000
  variable3: .float 5.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f2, variable1
  etiq0:
  c.lt.s $f0, $f2
  bc1f etiq1
  lwc1 $f7, variable2
  li  $t0, 0
  li  $t1, 10
  etiq2:
  slt $t2, $t1, $t0
  beq $t2, 1, etiq3
  lwc1 $f9, variable3
  add.s $f10, $f7, $f9
  mov.s $f7, $f10
  addi $t0, $t0, 1
  j etiq2
  etiq3:
  mov.s $f0, $f7
  j etiq0
etiq1:
  li $v0, 2
  add.s $f12, $f31, $f0
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
