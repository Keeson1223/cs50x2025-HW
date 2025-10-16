CC = clang

LDLIBS = -lcs50

TARGET = hello

all: $(TARGET)

$(TARGET): $(TARGET).c
	$(CC) $(TARGET).c -o $(TARGET) $(LDLIBS)

clean:
	rm -f $(TARGET)