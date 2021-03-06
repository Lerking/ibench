#define INSTR stp
#define NINST 12
#define N x0

.globl ninst
.data
ninst:
.long NINST
.text
.globl latency
.type latency, @function
.align 2
latency:

        # push callee-save registers onto stack
        sub            sp, sp, #64
        st1            {v8.2d, v9.2d, v10.2d, v11.2d}, [sp]
        sub            sp, sp, #64
        st1            {v12.2d, v13.2d, v14.2d, v15.2d}, [sp]

        mov     x4, N

        fmov    v0.2d, #1.00000000
        fmov    v1.2d, #1.00000000
        fmov    v2.2d, #1.00000000
loop:
        subs      x4, x4, #1
        INSTR    x24, x1, [sp, #-256] 
        INSTR    x2,  x3, [sp, #-256] 
        INSTR    x25, x5, [sp, #-256]  
        INSTR    x6,  x7, [sp, #-256]  
        INSTR    x8,  x9, [sp, #-256]  
        INSTR    x10, x11, [sp, #-256]  
        INSTR    x12, x13, [sp, #-256]  
        INSTR    x14, x15, [sp, #-256]  
        INSTR    x16, x17, [sp, #-256]  
        INSTR    x18, x19, [sp, #-256]  
        INSTR    x20, x21, [sp, #-256]  
        INSTR    x22, x23, [sp, #-256]  
        bne       loop
done:

        # pop callee-save registers from stack
        ld1            {v12.2d, v13.2d, v14.2d, v15.2d}, [sp]
        add            sp, sp, #64
        ld1            {v8.2d, v9.2d, v10.2d, v11.2d}, [sp]
        add            sp, sp, #64
        
        ret

.size latency, .-latency
