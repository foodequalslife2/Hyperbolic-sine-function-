.globl main #Chua Edric Jarvis S14

.macro end
    li a7, 10
    ecall
.end_macro

.macro newline
    li a7, 11
    addi a0, x0, 10
    ecall
.end_macro

.macro io (%x)
    li a7, 2
    fmv.s fa0, %x
    ecall
.end_macro

.macro print_float(%x)
    li a7, 60
    la a0, result
    fmv.s fa1, %x
    ecall
.end_macro

.macro print
    li a7, 55
    addi a1, x0, 1
    la a0, name
    ecall
.end_macro

.data

num:    .float 9.424778
name:   .asciz "Hyperbolic Sine Function "
result: .asciz "The answer is "

.text
main:
print  #dialogue what function im using 

la t6, num
addi x3, x0, 2
addi x4, x0, 0 #n
addi x5, x0, 5 #max of n
addi x9, x0 ,1
addi x11, x0, 0 
addi x14, x0, 0 
addi x16, x0 ,0
addi x19, x0, -1
addi x20, x0 ,1

fcvt.s.w f13, x0 
fcvt.s.w f14, x0   
fcvt.s.w f15, x0  
fcvt.s.w f16, x16  
fcvt.s.w f17, x0   
fcvt.s.w f19, x19  

loop:

mul x6, x3, x4 #2n
addi x7, x6 ,1 #2n+1
addi x8, x7 ,0
fcvt.s.w f8, x8  
fcvt.s.w f9, x9  


facloop:
beqz x8, loop2
fmul.s f9, f9, f8   #2n+1! 1*x7 which is the max then minus one until zero
fadd.s f8, f8, f19  #counter
addi x8, x8 -1
j facloop


loop2:
flw f12, (t6)
fadd.s f14, f12, f13
fcvt.s.w f18, x20   
addi x11, x7 ,0     


innerloop:
fmul.s f18, f18, f14 #power
addi x11, x11, -1
bnez x11, innerloop

fdiv.s f15, f18, f9  
fadd.s f16, f16, f15 #answer

io(f15)
beq x4, x5, stop 
addi x4, x4, 1




newline #newline#
j loop

stop:
print_float(f16)
end
