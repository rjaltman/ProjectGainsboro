  BITS 16

; Ideally should define some call vectors here
; The first writing is really more of just a 'Hello, world'
; of sorts at this point, however.

one:
  ; Used to define where we are
  ; Again, very similar code to MikeOS starter
  ; It's simple to grasp, plus it makes for a quick
  ; start and commit here
  mov ax, 07c0h
  add ax, 288
  mov ss, ax
  mov sp, 4096

  mov ax, 07C0h
  mov ds, ax


get_ready_to_print:
  mov si, greeting
  call print_msg

  mov si, greetingA
  call print_msg

  jmp $   ; endless money? (infinite loop due to jump)


greeting: db 'Project Gainsboro', 0
greetingA: db 'Authored by @rjaltman of IndigoBox Studios on January 28, 2016', 0

print_msg:
; Rather straightforward implementation:
; My first source when trying to connect the dots
; between x86 Assembly and previous-known non-x86 assembly
; was a helpful guide written by the author of MikeOS.
; This code might look quite similar as a result.
  lodsb
  cmp al, 0   ; Is 0-terminated? We defined this above
  je .done    ; Evaluate flags based on cmp operation
  int 10h     ; Essentially a BIOS 'OUT', prints char based on register info
  jmp print_msg  ; All night long (All night)

.done:
  ; Pls
  ret         ; This thing is everywhere; returns are great, also could do jmp

; The rest of this is left over for completion.
; To make things easy, I just took the trail of
; the MikeOS example for signature and sector values

  times 510-($-$$) db 0
  dw 0xAA55
