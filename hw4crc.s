/* Zainub Siddiqui, CS205, Assignment 4
Write assembly code for the crcInit() and crcFast() functions. Utilize the cmov instruction. */

.global crcInit
.global crcFast

.local crcTable

.text 

	crcInit: 
			# remainder in %r10b, dividend in %r11, bit in %r12b
			movq $0, %r11     # dividend = 0
			movq $0, %r10     # remainder = 0
			movq $0, %r12     # bit = 0
			movq $0, %rax     
			movq $0, %rbx
			jmp .check_dividend

	.compute_forloop:
			movb %r11b, %r10b   # char remainder = dividend
			movb $8, %r12b      # char bit = 8
			jmp .check_bit

	.bit_forloop:
			movb %r10b, %al        # original remainder into al
			movb %r10b, %bl		   # extra copy for else case
			salb $1, %r10b
			xor (POLYNOMIAL), %r10b
			salb $1, %bl
			testb $(0x80), %al     # if (remainder & 0x80)
			cmovz %rbx, %r10
			decb  %r12b

	.check_bit:
			cmpb $0, %r12b              # bit > 0
			jg   .bit_forloop
		    movq $(crcTable), %r13      # load address of crcTable at %r13
			movb %r10b, (%r13, %r11, 1) # move remainder into crcTable[dividend]
			inc %r11                    # increment dividend
				

	.check_dividend:
			cmpq $256, %r11	       # dividend < 256			
			jl   .compute_forloop
			jmp .end

	.end:
			ret
			

	crcFast:
			# message is %rdi, nBytes is %rsi, remainder is %rax (%al)
			# byte is %r8, char data is %r9b, crcTable address at %rdx
			movq $0, %rax  # remainder = 0
			movq $0, %r8   # byte = 0
			movq $0, %r9   # data = 0

	.check_loop:
			cmpq %rsi, %r8            # byte < nBytes
			jge .done
			movb (%rdi, %r8, 1), %r9b # load address of message in data 
			xor  %al, %r9b            # xor message[byte] with remainder
			movq $(crcTable), %rdx    # load address at %rdx
			movb (%rdx, %r9, 1), %al  # remainder = crcTable[data]
			inc  %r8 				  # increment byte
			jmp  .check_loop

	.done:
			ret 


.data

	.comm crcTable, 256
	POLYNOMIAL: .byte 0xD5

