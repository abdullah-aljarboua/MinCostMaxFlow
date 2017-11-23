default_target: all

CC=g++
CFLAGS=-Wall -Wextra
LEMONFLAG=-lemon

DEPS = 
OBJ = cycle_canceling.o

%.o: %.cc $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) $(LEMONFLAG)

all: $(OBJ)
	$(CC) -o a.out $^ $(CFLAGS) $(LEMONFLAG)

run:
	./a.out $(FILE_NAME)

clean:
	rm -f *.o *.out
