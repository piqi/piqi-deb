# upstream version
VERSION = 0.6.6
COMMIT = ded745779a8216b838302e1e1ae4e5f5adacd3b0


all: download deb


download: piqi-$(VERSION).tar.gz


piqi-$(VERSION).tar.gz:
	./download-upstream-tarball $(VERSION) $(COMMIT)


deb: download
	dpkg-checkbuilddeps
	cp piqi-$(VERSION).tar.gz piqi_$(VERSION).orig.tar.gz
	tar -xzf piqi-$(VERSION).tar.gz
	mkdir piqi-$(VERSION)/debian && cp -a debian/* piqi-$(VERSION)/debian/
	cd piqi-$(VERSION) && dpkg-buildpackage -us -uc


clean: clean-deb
	rm -rf piqi-*.tar.gz


clean-deb:
	rm -f piqi_*.changes piqi_*.deb piqi_*.debian.tar.gz piqi_*.dsc piqi_*.orig.tar.gz
	rm -rf piqi-$(VERSION)


.PHONY: all download deb clean clean-deb
