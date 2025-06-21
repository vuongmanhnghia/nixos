#!/bin/bash

# 🚀 C++ Competitive Programming Setup Script
# Usage: ./cpp-setup.sh [problem-name]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
PROBLEM_NAME=${1:-"problem"}
TEMPLATE_PATH="$HOME/.config/nvim/templates/competitive.cpp"
CURRENT_DIR=$(pwd)

echo -e "${BLUE}🚀 Setting up C++ competitive programming environment...${NC}"

# Create problem directory if it doesn't exist
if [ ! -d "$PROBLEM_NAME" ]; then
    mkdir -p "$PROBLEM_NAME"
    echo -e "${GREEN}✅ Created directory: $PROBLEM_NAME${NC}"
fi

cd "$PROBLEM_NAME"

# Create main C++ file
if [ ! -f "$PROBLEM_NAME.cpp" ]; then
    if [ -f "$TEMPLATE_PATH" ]; then
        cp "$TEMPLATE_PATH" "$PROBLEM_NAME.cpp"
        echo -e "${GREEN}✅ Created $PROBLEM_NAME.cpp from template${NC}"
    else
        # Fallback template if file doesn't exist
        cat > "$PROBLEM_NAME.cpp" << 'EOF'
#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define vi vector<int>
#define all(x) x.begin(), x.end()

void solve() {
    // Your solution here
    
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    
    int t = 1;
    // cin >> t;
    
    while (t--) {
        solve();
    }
    
    return 0;
}
EOF
        echo -e "${YELLOW}⚠️  Used fallback template (template file not found)${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  $PROBLEM_NAME.cpp already exists${NC}"
fi

# Create input.txt
if [ ! -f "input.txt" ]; then
    cat > "input.txt" << 'EOF'
5
1 2 3 4 5
EOF
    echo -e "${GREEN}✅ Created input.txt with sample data${NC}"
else
    echo -e "${YELLOW}⚠️  input.txt already exists${NC}"
fi

# Create output.txt (empty)
if [ ! -f "output.txt" ]; then
    touch "output.txt"
    echo -e "${GREEN}✅ Created output.txt${NC}"
else
    echo -e "${YELLOW}⚠️  output.txt already exists${NC}"
fi

# Create test cases directory
if [ ! -d "tests" ]; then
    mkdir -p "tests"
    
    # Sample test case
    cat > "tests/test1.txt" << 'EOF'
3
1 2 3
EOF
    
    cat > "tests/expected1.txt" << 'EOF'
6
EOF
    
    echo -e "${GREEN}✅ Created tests directory with sample test case${NC}"
fi

# Create Makefile for easy compilation
if [ ! -f "Makefile" ]; then
    cat > "Makefile" << EOF
CXX = g++
CXXFLAGS = -std=c++17 -O2 -Wall -Wextra -pedantic
DEBUG_FLAGS = -std=c++17 -g -Wall -Wextra -pedantic -DDEBUG
TARGET = $PROBLEM_NAME

all: \$(TARGET)

\$(TARGET): \$(TARGET).cpp
	\$(CXX) \$(CXXFLAGS) -o \$(TARGET) \$(TARGET).cpp

debug: \$(TARGET).cpp
	\$(CXX) \$(DEBUG_FLAGS) -o \$(TARGET)_debug \$(TARGET).cpp

run: \$(TARGET)
	./\$(TARGET)

test: \$(TARGET)
	./\$(TARGET) < input.txt

clean:
	rm -f \$(TARGET) \$(TARGET)_debug

.PHONY: all debug run test clean
EOF
    echo -e "${GREEN}✅ Created Makefile${NC}"
fi

# Create a simple test runner script
if [ ! -f "test.sh" ]; then
    cat > "test.sh" << 'EOF'
#!/bin/bash

# Compile the program
echo "🔨 Compiling..."
if ! make; then
    echo "❌ Compilation failed!"
    exit 1
fi

echo "✅ Compilation successful!"
echo ""

# Run tests
echo "🧪 Running tests..."
for test_file in tests/test*.txt; do
    if [ -f "$test_file" ]; then
        test_num=$(basename "$test_file" .txt | sed 's/test//')
        expected_file="tests/expected${test_num}.txt"
        
        echo "Running test $test_num..."
        
        if [ -f "$expected_file" ]; then
            # Run and compare with expected output
            if ./problem < "$test_file" | diff - "$expected_file" > /dev/null; then
                echo "✅ Test $test_num passed"
            else
                echo "❌ Test $test_num failed"
                echo "Expected:"
                cat "$expected_file"
                echo "Got:"
                ./problem < "$test_file"
                echo ""
            fi
        else
            echo "⚠️  No expected output for test $test_num, showing result:"
            ./problem < "$test_file"
            echo ""
        fi
    fi
done
EOF
    chmod +x "test.sh"
    echo -e "${GREEN}✅ Created test.sh script${NC}"
fi

echo ""
echo -e "${BLUE}🎯 Setup complete! Here's what you can do:${NC}"
echo -e "${GREEN}📝 Edit code:${NC} nvim $PROBLEM_NAME.cpp"
echo -e "${GREEN}🔨 Compile:${NC} make"
echo -e "${GREEN}🚀 Run:${NC} make run"
echo -e "${GREEN}🧪 Test:${NC} make test"
echo -e "${GREEN}🧪 Run all tests:${NC} ./test.sh"
echo -e "${GREEN}🐛 Debug:${NC} make debug && gdb ./${PROBLEM_NAME}_debug"
echo -e "${GREEN}🧹 Clean:${NC} make clean"
echo ""
echo -e "${YELLOW}💡 Pro tip: Use F5 in Neovim to compile and run directly!${NC}"

# Open in Neovim if available
if command -v nvim &> /dev/null; then
    echo -e "${BLUE}🚀 Opening in Neovim...${NC}"
    nvim "$PROBLEM_NAME.cpp"
fi 