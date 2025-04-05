CC = gcc
CFLAGS = -m32 -Wall -std=gnu89 -O3 -DNDEBUG -DOPENGL1X -DNFS_CPP
CXXFLAGS = -m32 -std=c++14 -O3 -DNDEBUG -Wno-narrowing -Wextra -fno-rtti -fno-exceptions -flto
LDFLAGS = -m32 -flto
LIBS = -lSDL2 -lGL -lm

SRC_DIR = src
TARGET = Need\ For\ Speed\ II\ SE/nfs2se
CPP_SRC = $(SRC_DIR)/Cpp/NFS2SE.cpp
C_SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(CPP_SRC:.cpp=.o) $(C_SRC:.c=.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ)
	@echo "Linking..."
	$(CC) $(LDFLAGS) -o "$@" $^ $(LIBS)
	@echo "Stripping..."
	strip "$@"
	@echo "Build completed successfully!"

$(SRC_DIR)/%.o: $(SRC_DIR)/%.cpp
	@echo "Compiling $<..."
	$(CC) $(CXXFLAGS) -c $< -o $@

$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) "$(TARGET)"
