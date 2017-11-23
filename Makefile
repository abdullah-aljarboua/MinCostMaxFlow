default_target: all

CXX=g++
CFLAGS=-Wall -Wextra -O3 -Wno-unused-local-typedef -Wno-unused-command-line-argument
LEMONFLAG=-lemon

DEPS = 
OBJ = cycle_canceling.o
# FILE_NAME = 'data/example_input.ini'
FILE_NAME = 'data/256_2048.ini'

%.o: %.cc $(DEPS)
	$(CXX) -c -o $@ $< $(CFLAGS) $(LEMONFLAG)

all: $(OBJ)
	$(CXX) -o a.out $^ $(CFLAGS) $(LEMONFLAG)

run:
	./a.out $(FILE_NAME)

clean:
	rm -f *.o *.out
