
	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

    ; Please write your code below that will implement:
    ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);
	
        push    {r4, r7}
        sub     sp, sp, #32 ;
        add     r7, sp, #0

		; clear r, push parameter to r7
		; *sou2=r7+4 *sou1=r7+8 *res=r7+12
        str     r0, [r7, #12]
        str     r1, [r7, #8]
        str     r2, [r7, #4]

		; precmp 1->col ?= 2->row
        ldr     r3, [r7, #8]
        ldr     r2, [r3, #4]
        ldr     r3, [r7, #4]
        ldr     r3, [r3]

        cmp     r2, r3

		; equal -> l2, o.w -> over
        beq     .L2
        movs    r3, #1
        b       .L3

.L2:
        ; str res->row
		ldr     r3, [r7, #8]
        ldr     r2, [r3]
        ldr     r3, [r7, #12]
        str     r2, [r3]

		; str res->col
        ldr     r3, [r7, #4]
        ldr     r2, [r3, #4]
        ldr     r3, [r7, #12]
        str     r2, [r3, #4]

		; loop1 loc "i" i=r7+28 i just init
        movs    r3, #0
        str     r3, [r7, #28]
        b       .L4
.L9:
		;loop2 loc "j" j=r7+24 refresh j
        movs    r3, #0
        str     r3, [r7, #24]
        b       .L5
.L8:
        ;loop3 loc "k" k=r7+20 refresh k
		movs    r3, #0
        str     r3, [r7, #20]
        b       .L6
.L7:
		;(source1->data+i*source1->column+k)
		ldr     r3, [r7, #8]
        ldr     r2, [r3, #8]
        ldr     r3, [r7, #8]
        ldr     r3, [r3, #4]
        ldr     r1, [r7, #28]
        mul     r3, r1, r3
        mov     r1, r3
        ldr     r3, [r7, #20]
        add     r3, r3, r1
        lsls    r3, r3, #2
        add     r3, r3, r2
        ldr     r3, [r3]

		;(source2->data+k*source2->column+j)
        ldr     r2, [r7, #4]
        ldr     r1, [r2, #8]
        ldr     r2, [r7, #4]
        ldr     r2, [r2, #4]
        ldr     r0, [r7, #20]
        mul     r2, r0, r2
        mov     r0, r2
        ldr     r2, [r7, #24]
        add     r2, r2, r0
        lsls    r2, r2, #2
        add     r2, r2, r1
        ldr     r2, [r2]

		; * str
        mul     r3, r2, r3
        str     r3, [r7, #16]

		;(results->data+i*results->column+j)
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
		
        ldr     r2, [r7, #16]
        add     r2, r2, r1
        str     r2, [r3]
		
		;k++
        ldr     r3, [r7, #20]
        adds    r3, r3, #1
        str     r3, [r7, #20]

.L6:
		;loop3 start ...
        ldr     r3, [r7, #8]
        ldr     r3, [r3, #4]
        ldr     r2, [r7, #20]
        cmp     r2, r3
        blt     .L7

		;j++
        ldr     r3, [r7, #24]
        adds    r3, r3, #1
        str     r3, [r7, #24]
.L5:
        ;loop2 start ...
		;j m2.c
		ldr     r3, [r7, #4]
        ldr     r3, [r3, #4]
        ldr     r2, [r7, #24]
        cmp     r2, r3
        blt     .L8

		;i++
        ldr     r3, [r7, #28]
        adds    r3, r3, #1
        str     r3, [r7, #28]
.L4:
		; loop1 start ...
		; i m1.r
        ldr     r3, [r7, #8]
        ldr     r3, [r3]
        ldr     r2, [r7, #28]
        cmp     r2, r3
        blt     .L9

        movs    r3, #0
.L3:
		; function is over, assign value to r0, pop, bx lr, end
        mov     r0, r3
        adds    r7, r7, #32
        mov     sp, r7
        pop     {r4, r7}
        bx      lr
	END
