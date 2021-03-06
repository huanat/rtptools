## Process this file with automake to produce Makefile.in

AUTOMAKE_OPTIONS = foreign

TAR = gtar

bin_PROGRAMS = rtpdump rtpplay rtpsend rtptrans

COMMON = \
        ansi.h \
        host2ip.c \
        hpt.c \
        multimer.c \
        multimer.h \
        notify.c \
        notify.h \
        rtp.h \
        sysdep.h \
        types.h \
        vat.h

rtpdump_SOURCES = $(COMMON) rd.c rtpdump.h rtpdump.c
if DARWIN
rtpplay_SOURCES = $(COMMON) rd.c hsearch.c rtpplay.c
else
rtpplay_SOURCES = $(COMMON) rd.c rtpplay.c
endif
rtpsend_SOURCES = $(COMMON) rtpsend.c
rtptrans_SOURCES= $(COMMON) rtptrans.c

# make rpm_spec
# This will automatically generate rtptools-VERSION.spec file 
# which is required for making Linux's RPM/SRPM package.
rpm_spec: rtptools.spec
	@echo "Generating RPM spec file"
	@echo "# Generated automatically from rtptools.spec"  > rtptools-$(VERSION).spec
	@echo "# DO NOT EDIT THIS FILE"                 >> rtptools-$(VERSION).spec
	@sed s/VERSION/$(VERSION)/g  rtptools.spec >> rtptools-$(VERSION).spec

#rpm: rtptools-$(VERSION).spec $(bin_PROGRAMS)
#	rpm -ba 

EXTRA_DIST = ChangeLog.html COPYRIGHT rtptools.html bark.rtp \
        nt/*.c nt/include/*.h \
        nt/include/arpa/*.h nt/include/netinet/*.h \
        nt/include/rpcsvc/*.h nt/include/sys/*.h \
        nt/include/utilnt/*.h \
        hsearch.h hsearch.c multidump multiplay \
        rtptools.dsw rtpdump.dsp rtpplay.dsp rtpsend.dsp rtptrans.dsp \
        bcb/*.bp? bcb/obj/* rtptools.spec
