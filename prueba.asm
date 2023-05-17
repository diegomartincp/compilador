                              
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 5.000000
  variable1: .float 10.000000
  variable2: .float 1.000000
  variable3: .float 7.000000
  variable4: .float 80.000000
  variable5: .float 10.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  etiq0:
  lwc1 $f2, variable1
  c.lt.s $f0, $f2
  bc1f etiq1
  lwc1 $f5, variable2
  add.s $f6, $f0, $f5
  mov.s $f0, $f6
  lwc1 $f8, variable3
  c.le.s $f8, $f0
  bc1f etiq2
  lwc1 $f11, variable4
  li $v0, 2
  add.s $f12, $f31, $f11
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq2:
  j etiq0
etiq1:
  lwc1 $f17, variable5
  add.s $f18, $f0, $f17
  li $v0, 2
  add.s $f12, $f31, $f18
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
