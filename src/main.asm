  BITS 16

; Ideally should define some call vectors here
; The first writing is really more of just a 'Hello, world'
; of sorts at this point, however.

org 0x7c00    ; Too cute; it's an origin!
              ; Secretly may have forgotten this on the last push
              ; Which possibly explains nothing happening


one:
  ; Used to define where we are
  ; Again, very similar code to MikeOS starter
  ; It's simple to grasp, plus it makes for a quick
  ; start and commit here
  
  and ax, 0
  mov ds, ax
  mov es, ax    ; Brings the nulled values to the masses 


get_ready_to_print:
  mov si, greeting
  call print_msg

  mov si, greetingA
  call print_msg

  cli
  hlt     ; I didn't care for the previous implementation...
          ; Research digs up using halt. I've learned in the past to always use halt. Let's use halt.
          ; By the way, new approach inspired by BrokenThorn's tutorials (thanks, BrokenThorn!)


greeting: db 'Project Gainsboro', 0
greetingA: db 'Authored by @rjaltman of IndigoBox Studios on January 28, 2016', 0

print_msg:
; Rather straightforward implementation:
; My first source when trying to connect the dots
; between x86 Assembly and previous-known non-x86 assembly
; was a helpful guide written by the author of MikeOS.
; This code might look quite similar as a result.

; Review: Robert this is how you print strings just go with it (we think)
  lodsb
  cmp al, 0   ; Is 0-terminated? We defined this above
  je doneHere    ; Evaluate flags based on cmp operation
  int 10h     ; Essentially a BIOS 'OUT', prints char based on register info
  jmp print_msg  ; All night long (All night)

doneHere:
  ; Pls
  ret         ; This thing is everywhere; returns are great, also could do jmp

; Since we are done here, and our bootloader needs to be 512 bytes...let's fill the rest with 0s.

  times 510-($-$$) db 0   ; The rest is still...well, actually, written, as this writes all 0s.
  dw 0xAA55 ; Why, this is the silliest thing I've seen to boot! (Puns will decrease, I promise)
