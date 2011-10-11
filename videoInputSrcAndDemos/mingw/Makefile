DIR = ../libs/videoInput
SRCS = $(DIR)/videoInput.cpp $(DIR)/videoInput.h
INCLUDE = -I../libs/DShow/Include
OBJS = videoInput.o
CXXFLAGS = -Wall -Wno-multichar
TARGET = libvideoinput.a

all: $(TARGET)

libvideoinput.a: $(OBJS)

videoInput.o: $(SRCS)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $<
