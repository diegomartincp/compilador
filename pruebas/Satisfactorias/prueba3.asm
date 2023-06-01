       
       
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 3.000000
  variable1: .float 2.000000
  variable2: .float 5.000000
  variable3: .float 6.000000
  variable4: .float 3.000000
  variable5: .float 1.000000
  variable6: .float 3.000000
  variable7: .float 2.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  add.s $f2, $f0, $f1
  lwc1 $f3, variable2
  c.le.s $f3, $f2
  bc1f etiq0
  lwc1 $f6, variable3
  lwc1 $f7, variable4
  div.s $f8, $f6, $f7
  lwc1 $f10, variable5
  lwc1 $f11, variable6
  add.s $f13, $f10, $f11
  lwc1 $f14, variable7
  c.le.s $f14, $f13
  bc1f etiq1
  li $v0, 2
  add.s $f12, $f31, $f8
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq1:
etiq0:
