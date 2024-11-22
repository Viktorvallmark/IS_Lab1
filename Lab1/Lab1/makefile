# Author: Alexander Libot
# To assemble and upload code for Lab1 in DA346A

TARGET = out/Lab1.hex
SRCFILE = src/Lab1.asm
HEXFILE = Lab1.hex
INCLUDE = src/keyboard.inc

PART = atmega32u4
PROGRAMMER = stk500v2         # cant use arduino programmer for atmega2560 in Arduino Mega, but stk500v2 works
BAUDRATE = 57600
PORT = /dev/tty.usbmodem14101 # specific for each computer, check with '$ ls /dev'

$(HEXFILE): create_dirs $(SRCFILE) $(INCLUDE)
	@avra -I src -o $(TARGET) $(SRCFILE) # .inc files for processors are automatically included
	@rm -f src/Lab1.eep.hex src/Lab1.obj

clean:
	@rm -f src/Lab1.eep.hex src/Lab1.hex src/Lab1.obj
	@rm -rf out
	@echo 'All binaries removed'

create_dirs:
	@mkdir -p out

upload: $(HEXFILE)
	@avrdude -p $(PART) -c $(PROGRAMMER) -b $(BAUDRATE) -P $(PORT) -U flash:w:$(TARGET):i # :i might not be needed
	@echo 'Program uploaded to $(PART)'
