.include "memory_map.inc"

.smstag				; automatically adds the TMR SEGA header so real consoles recognize it

.define RAM_TOP         = $dff8
.define MEM_CTL_PORT    = $3e
.define IO_CTL_PORT     = $3f
.define JS_PORT_A       = $dc
.define JS_PORT_B       = $dd
.define VDP_CMD   	= $bf
.define VDP_DATA  	= $be

.ramsection "port_3e_status" slot "RAM_SLOT" org 0 force
        port_3e_status  db	; set by BIOS on cartridge boot
.ends

.ramsection "pause_vars" slot "RAM_SLOT"
        paused    	db
.ends

.ramsection "user_vars" slot "RAM_SLOT"
	; put your user variables here
.ends

.orga 0

di
im 1
ld sp, RAM_TOP
jp init

.orga $0038
	in a, (VDP_CMD)
	reti

.orga $0066
	ld a, (paused)
	xor 1
	ld (paused), a
	retn

init:
	xor a
	ld (paused), a
	; do some initialization here
@loop:
	ei
	halt			; wait for interrupt
	; check pause status and do nothing if set
	ld a, (paused)
	or a
	jr nz, @loop
	; do some game logic here
	jr @loop
