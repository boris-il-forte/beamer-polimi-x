#installer makefile

root_dir = /usr/local/share/texmf
style_dir = tex/latex
package_name = beamer-polimi-x

style_files = $(wildcard *.sty)
image_dir = style_img
all: directory copy

install: directory copy hash

directory:
	@echo "Creating directory..."
	@mkdir -p $(root_dir)/$(style_dir)/$(package_name)
	
copy: copystyle copyimg
	
copystyle: $(style_files)
	@echo "Moving style files..."
	@cp $^ $(root_dir)/$(style_dir)/$(package_name)

copyimg: $(image_dir)
	@cp -r  $(image_dir) $(root_dir)/$(style_dir)/$(package_name)/

hash:
	@echo "rebuilding texlive hash"
	@texhash
	
deb_name = --pkgname beamer-polimi-x
deb_version = --pkgversion 1.0.0
deb_relase = --pkgrelease 1
deb_architecture = -A all
deb_license = --pkglicense GPL
deb_mantainer = --maintainer "Davide Tateo"
deb_provides = --provides beamer-polimi-x
#deb_requires 

deb_config = $(deb_name) $(deb_version) $(deb_relase) $(deb_architecture) $(deb_license) $(deb_mantainer) $(deb_provides)

deb: 
	@checkinstall -D --fstrans=no --install=no --nodoc -y $(deb_config)
