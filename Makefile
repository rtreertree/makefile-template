# Define the directories
SRC_DIR := src
BUILD_DIR := build

# Define the compiler and flags
CC := g++
CFLAGS := -Wall -Wextra -I$(SRC_DIR) -g
LDFLAGS :=

# Find all source files (.c, .cpp) in the SRC_DIR
SRCS := $(shell find $(SRC_DIR) -type f \( -name '*.c' -o -name '*.cpp' \))

# Convert source file paths to object file paths in BUILD_DIR, preserving directory structure
OBJS := $(SRCS:$(SRC_DIR)/%=$(BUILD_DIR)/%)
OBJS := $(OBJS:.c=.o)
OBJS := $(OBJS:.cpp=.o)

# Define the target executable
TARGET := app

# Default rule: build the target
.PHONY: all
all: $(TARGET)

# Link the object files into the target executable
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

# Compile .c source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Compile .cpp source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build files
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(TARGET)

# Run the application
.PHONY: run
run: all
	@./$(TARGET)