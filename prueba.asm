         
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 1.000000
  variable1: .float 1.000000
  variable2: .float 3.000000
  variable3: .float 99.000000
  variable4: .float 2.000000
  variable5: .float 88.000000
  variable6: .float 1.000000
  variable7: .float 1.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f2, variable1
  lwc1 $f5, variable2
  c.lt.s $f0, $f5
  bc1f etiq0
  lwc1 $f8, variable3
  li $v0, 2
  add.s $f12, $f31, $f8
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  lwc1 $f10, variable4
  c.lt.s $f2, $f10
  bc1f etiq1
  lwc1 $f13, variable5
  li $v0, 2
  add.s $f12, $f31, $f13
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  lwc1 $f15, variable6
  add.s $f16, $f2, $f15
  mov.s $f2, $f16
etiq1:
  lwc1 $f21, variable7
  add.s $f22, $f0, $f21
  mov.s $f0, $f22
etiq0:
