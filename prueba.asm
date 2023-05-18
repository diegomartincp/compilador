
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 9.100000
  variable1: .float 10.100000
  variable2: .float 5.000000
  variable3: .float 99.900002
  variable4: .float 100.500000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f2, variable1
  mov.s $f0, $f2
  lwc1 $f5, variable2
  add.s $f6, $f5, $f0
  mov.s $f0, $f6
  lwc1 $f9, variable3
  c.lt.s $f0, $f9
  bc1f etiq0
  lwc1 $f13, variable4
  mul.s $f14, $f0, $f13
  li $v0, 2
  add.s $f12, $f31, $f14
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
