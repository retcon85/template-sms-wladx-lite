# Forgive me for I know not what I do.
PROJECTNAME := $(notdir $(CURDIR))
TARGETDIR := ./build/
TARGETEXT := sms
SOURCEEXT := s
TARGET := $(TARGETDIR)$(PROJECTNAME).$(TARGETEXT)
ENTRYPOINT := main

build: $(TARGETDIR)$(PROJECTNAME).$(TARGETEXT)

$(TARGETDIR):
	mkdir -p $(TARGETDIR)

$(TARGET): $(TARGETDIR)$(ENTRYPOINT).o $(TARGETDIR)linkfile-gen
	wlalink -r -i -d -S $(TARGETDIR)linkfile-gen $@

$(TARGETDIR)%.o: src/%.$(SOURCEEXT) $(TARGETDIR)
	wla-z80 -I src -i -o $@ $<

$(TARGETDIR)linkfile-gen: linkfile $(TARGETDIR)$(ENTRYPOINT).o
	cp linkfile $(TARGETDIR)linkfile-gen
	echo "$(TARGETDIR)$(ENTRYPOINT).o" >> $(TARGETDIR)linkfile-gen

$(TARGET_SMS): $(TARGET)
	cp $(TARGET) $(TARGET_SMS)

.PHONY: clean
clean:
	rm -rf build

