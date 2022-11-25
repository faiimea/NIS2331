
	.section program, "ax"
matrix_mul:
	.global	matrix_mul

    // Please write your code below that will implement:
    //       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);

	; BX		LR
	; .end
	matrix_mul(Matrix*, Matrix const*, Matrix const*):
        push    {r4, r7}
        sub     sp, sp, #32
        add     r7, sp, #0
        str     r0, [r7, #12]
        str     r1, [r7, #8]
        str     r2, [r7, #4]
        ldr     r3, [r7, #8]
        ldr     r2, [r3, #4]
        ldr     r3, [r7, #4]
        ldr     r3, [r3]
        cmp     r2, r3
        beq     .L2
        movs    r3, #1
        b       .L3
.L2:
        ldr     r3, [r7, #8]
        ldr     r2, [r3]
        ldr     r3, [r7, #12]
        str     r2, [r3]
        ldr     r3, [r7, #4]
        ldr     r2, [r3, #4]
        ldr     r3, [r7, #12]
        str     r2, [r3, #4]
        movs    r3, #0
        str     r3, [r7, #28]
        b       .L4
.L9:
        movs    r3, #0
        str     r3, [r7, #24]
        b       .L5
.L8:
        movs    r3, #0
        str     r3, [r7, #20]
        b       .L6
.L7:
        ldr     r3, [r7, #12]
        ldr     r2, [r3, #8]
        ldr     r3, [r7, #12]
        ldr     r3, [r3, #4]
        ldr     r1, [r7, #28]
        mul     r3, r1, r3
        mov     r1, r3
        ldr     r3, [r7, #24]
        add     r3, r3, r1
        lsls    r3, r3, #2
        add     r3, r3, r2
        ldr     r1, [r3]
        ldr     r3, [r7, #8]
        ldr     r2, [r3, #8]
        ldr     r3, [r7, #8]
        ldr     r3, [r3, #4]
        ldr     r0, [r7, #28]
        mul     r3, r0, r3
        mov     r0, r3
        ldr     r3, [r7, #20]
        add     r3, r3, r0
        lsls    r3, r3, #2
        add     r3, r3, r2
        ldr     r3, [r3]
        ldr     r2, [r7, #4]
        ldr     r0, [r2, #8]
        ldr     r2, [r7, #4]
        ldr     r2, [r2, #4]
        ldr     r4, [r7, #20]
        mul     r2, r4, r2
        mov     r4, r2
        ldr     r2, [r7, #24]
        add     r2, r2, r4
        lsls    r2, r2, #2
        add     r2, r2, r0
        ldr     r2, [r2]
        mul     r2, r3, r2
        ldr     r3, [r7, #12]
        ldr     r0, [r3, #8]
        ldr     r3, [r7, #12]
        ldr     r3, [r3, #4]
        ldr     r4, [r7, #28]
        mul     r3, r4, r3
        mov     r4, r3
        ldr     r3, [r7, #24]
        add     r3, r3, r4
        lsls    r3, r3, #2
        add     r3, r3, r0
        add     r2, r2, r1
        str     r2, [r3]
        ldr     r3, [r7, #20]
        adds    r3, r3, #1
        str     r3, [r7, #20]
.L6:
        ldr     r3, [r7, #8]
        ldr     r3, [r3, #4]
        ldr     r2, [r7, #20]
        cmp     r2, r3
        blt     .L7
        ldr     r3, [r7, #24]
        adds    r3, r3, #1
        str     r3, [r7, #24]
.L5:
        ldr     r3, [r7, #4]
        ldr     r3, [r3, #4]
        ldr     r2, [r7, #24]
        cmp     r2, r3
        blt     .L8
        ldr     r3, [r7, #28]
        adds    r3, r3, #1
        str     r3, [r7, #28]
.L4:
        ldr     r3, [r7, #8]
        ldr     r3, [r3]
        ldr     r2, [r7, #28]
        cmp     r2, r3
        blt     .L9
        movs    r3, #0
.L3:
        mov     r0, r3
        adds    r7, r7, #32
        mov     sp, r7
        pop     {r4, r7}
        bx      lr
