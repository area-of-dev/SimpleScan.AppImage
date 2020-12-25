# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	apprepo --destination=$(PWD)/build appdir boilerplate simple-scan libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libreadline8 libwebp6

	echo "exec \$${APPDIR}/bin/simple-scan \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.png | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg | true	

	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir 		| true	

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/SimpleScan.AppImage
	@echo "done: SimpleScan.AppImage"
	make clean


clean:
	rm -rf ${PWD}/build
