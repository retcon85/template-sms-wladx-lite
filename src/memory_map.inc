; very simple memory map with 48k of ROM and 16k of RAM
.rombanksize $c000
.rombanks 1

.memorymap
	defaultslot 0
	slotsize $c000
	slot 0 $0000 "ROM_SLOT"
	slotsize $4000
	slot 1 $c000 "RAM_SLOT"
.endme

; set default bank 0 slot 0
.bank 0 slot "ROM_SLOT"
