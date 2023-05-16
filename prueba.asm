     
.data #Variables
newLine: .asciiz "\n"
zero_f: .float 0.0
  variable0: .float 3.000000
  variable1: .float 2.000000
  variable2: .float 5.000000
  variable3: .float 3.000000
  variable4: .float 3.000000
  variable5: .float 3.000000
  variable6: .float 3.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  add.s $f2, $f0, $f1
  lwc1 $f3, variable2
  c.le.s $f3, $f2
  bc1f etiq0
  lwc1 $f7, variable4
  lwc1 $f6, variable3
  cvt.w.s $f8, $f6
  cvt.w.s $f9, $f7
  mfc1 $t8, $f8
  mfc1 $t9, $f9
  div $t8, $t9
  mfhi $t8
  mtc1 $t8, $f8
  cvt.s.w $f8, $f8
  lwc1 $f11, variable6
  lwc1 $f10, variable5
  div.s $f12, $f10, $f11
  add.s $f15, $f8, $f12
  li $v0, 2
  add.s $f12, $f31, $f15
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
etiq0:
