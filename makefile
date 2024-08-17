PROG:=link-test

ODIR:=obj
BDIR:=bin

ASM:=rgbasm
AFLAGS:=-Wall
CC:=sdcc
CFLAGS:=-c -msm83
LINK:=rgblink
LFLAGS:=-p 0xff
FIX:=rgbfix
FFLAGS:=-cv -p 0xff -t "LINK TEST"

ASRCS:=$(wildcard *.z80)
CSRCS:=$(wildcard *.c)

OBJS:=$(patsubst %.z80,$(ODIR)/%.o,$(ASRCS))
RELS:=$(patsubst %.c,$(ODIR)/%.rel,$(CSRCS))

OUT:=$(BDIR)/$(PROG).gb

all: $(ODIR) $(BDIR) $(OUT)

$(OUT): $(OBJS) $(RELS) sdcc.lkr
	$(LINK) $(LFLAGS) -l sdcc.lkr -n $(BDIR)/$(PROG).sym -o $@ $(OBJS) $(RELS)
	$(FIX) $(FFLAGS) $@

$(ODIR)/%.o: %.z80 makefile
	$(ASM) $(AFLAGS) -o $@ $<

$(ODIR)/%.rel: %.c
	$(CC) $(CFLAGS) -o $@ $^

$(ODIR) $(BDIR):
	mkdir -p $@

.PHONY: all clean

clean:
	-test -d "$(ODIR)" && rm -f ./$(ODIR)/* && rmdir ./$(ODIR)
	-test -d "$(BDIR)" && rm -f ./$(BDIR)/* && rmdir ./$(BDIR)
