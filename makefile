show:
	echo 'Run "make install" as root to install program!'
	
run:
	python lanscan.py
install:
	sudo cp lanscan.py /usr/bin/lanscan
	sudo chmod +x /usr/bin/lanscan
uninstall:
	sudo rm /usr/bin/lanscan
installed-size:
	du -sx --exclude DEBIAN ./debian/
build: 
	sudo make build-deb;
build-deb:
	mkdir -p debian;
	mkdir -p debian/DEBIAN;
	mkdir -p debian/usr;
	mkdir -p debian/usr/bin;
	# make post and pre install scripts have the correct permissions
	chmod 775 debdata/*
	# copy over the binary
	cp -vf lanscan.py ./debian/usr/bin/lanscan
	# make the program executable
	chmod +x ./debian/usr/bin/lanscan
	# start the md5sums file
	md5sum ./debian/usr/bin/lanscan > ./debian/DEBIAN/md5sums
	# create md5 sums for all the config files transfered over
	sed -i.bak 's/\.\/debian\///g' ./debian/DEBIAN/md5sums
	rm -v ./debian/DEBIAN/md5sums.bak
	cp -rv debdata/. debian/DEBIAN/
	dpkg-deb --build debian
	cp -v debian.deb lanscan.deb
	rm -v debian.deb
	rm -rv debian
