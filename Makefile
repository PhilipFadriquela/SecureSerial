# /* ***************************************************************************
#  * Copyright (c) 2023 Philip Fadriquela
#  * pjfadriquela@gmail.com
#  * All rights reserved.
#  * **************************************************************************/


ROOT_DIR=$(shell pwd)

INCLUDES := -Iinclude
CXXFLAGS = ${INCLUDES} -std=c++17 -Wall -fPIC -DHAVE_CONFIG_H -Weffc++ -DPIC -fno-use-cxa-atexit
LDFLAGS = -L. -lsecureserial -lserial
VERSION_MAJOR=0
VERSION_MINOR=1
VERSION_PATCH=1
SONAME = libsecureserial.so.${VERSION_MAJOR}
TARGET = libsecureserial.so.${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}

TARGET_SYM = libsecureserial.so
TARGET_PY_WRAP = libsecureserial_wrap.cxx libsecureserial_wrap.h libsecureserial.py
TARGET_PY_O = libsecureserial_wrap.o 
TARGET_PY = _libsecureserial.so

SOURCES=$(wildcard src/*.cpp) 
EXAMPLE_SOURCES=$(wildcard examples/*.cpp)
OBJS=$(patsubst %.cpp,%.o,$(SOURCES))
EXAMPLE_OBJS=$(patsubst %.cpp,%.o,$(EXAMPLE_SOURCES))
EXAMPLES=$(patsubst %.cpp,%,$(EXAMPLE_SOURCES))

.PHONY : clean all install

all: $(TARGET_SYM) ${EXAMPLES} ${TARGET_PY}

${TARGET}: ${OBJS}
	$(CXX) -shared -Wl,-soname,${SONAME} -o $@ $^
	ln -s $@ libsecureserial.so.${VERSION_MAJOR}.${VERSION_MINOR}
	ln -s $@ libsecureserial.so.${VERSION_MAJOR}

${TARGET_SYM}: ${TARGET}
	ln -sf $< $@

${EXAMPLES}: ${TARGET_SYM} ${EXAMPLE_OBJS}

%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) -MD $< -o $@

${EXAMPLES}: %: %.o
	$(CXX) $< -o $@ ${LDFLAGS} 

${TARGET_PY_WRAP}: libsecureserial.i
	swig -python -c++ libsecureserial.i

${TARGET_PY}: ${TARGET_PY_WRAP}
	$(CXX) -fPIC -std=c++17 -c libsecureserial_wrap.cxx $(shell python3-config --cflags)
	$(CXX) -shared libsecureserial_wrap.o $(shell python3-config --ldflags) -L. -lsecureserial -o ${TARGET_PY}

clean:
	@rm -rf ${TARGET} ${OBJS} ${EXAMPLE_OBJS} ${EXAMPLES} ${TARGET_SYM}* src/*.d examples/*.d ${TARGET_PY_WRAP} ${TARGET_PY_O} ${TARGET_PY}

#install: ${TARGET_SYM}
#	install -D ${TARGET} ${DESTDIR}/usr/lib/${DEB_HOST_MULTIARCH}/${TARGET}
#	install ${TARGET_SYM} ${DESTDIR}/usr/lib/${DEB_HOST_MULTIARCH}/
#	install -d ${DESTDIR}/usr/include/libsecureserial	
#	install include/* ${DESTDIR}/usr/include/libsecureserial
