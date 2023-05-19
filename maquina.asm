
.data #Variables
  newLine: .asciiz "\n"
  zero_f: .float 0.0
  variable0: .float 9.000000
  variable1: .float 2.000000
  variable2: .float 9.000000
  variable3: .float 2.000000

.text #Operaciones
  lwc1 $f31, zero_f

  lwc1 $f0, variable0
  lwc1 $f1, variable1
  div.s $f2, $f0, $f1
  li $v0, 2
  add.s $f12, $f31, $f2
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
  lwc1 $f5, variable3
  lwc1 $f4, variable2
  cvt.w.s $f6, $f4
  cvt.w.s $f7, $f5
  mfc1 $t6, $f6
  mfc1 $t7, $f7
  div $t6, $t7
  mfhi $t6
  mtc1 $t6, $f6
  cvt.s.w $f6, $f6
  li $v0, 2
  add.s $f12, $f31, $f6
  syscall
  li $v0, 4
  la $a0, newLine
  syscall
