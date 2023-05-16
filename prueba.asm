          
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 80.000000
  variable1: .float 70.000000
  variable2: .float 5.000000
  variable3: .float 10.000000
  variable4: .float 10.000000
  variable5: .float 1.000000
  variable6: .float 10.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  c.le.s $f1, $f0
  bc1f etiq0
  lwc1 $f4, variable2
  lwc1 $f6, variable3
  lwc1 $f7, variable4
  seq $f8, $f6, $f7
  bc1f etiq1
  lwc1 $f10, variable5
  add.s $f11, $f4, $f10
  mov.s $f4, $f11
etiq1:
  lwc1 $f15, variable6
  add.s $f16, $f4, $f15
  li $v0, 2
  add.s $f12, $f31, $f16
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
