#!/bin/bash

# 🚀 C++ Performance Benchmark Script
# Usage: ./cpp-benchmark.sh [cpp-file] [input-file] [iterations]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Default values
CPP_FILE=${1:-"$(find . -name "*.cpp" | head -1)"}
INPUT_FILE=${2:-"input.txt"}
ITERATIONS=${3:-10}

if [ -z "$CPP_FILE" ]; then
    echo -e "${RED}❌ No C++ file found!${NC}"
    echo "Usage: $0 [cpp-file] [input-file] [iterations]"
    exit 1
fi

if [ ! -f "$CPP_FILE" ]; then
    echo -e "${RED}❌ File $CPP_FILE not found!${NC}"
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}❌ Input file $INPUT_FILE not found!${NC}"
    exit 1
fi

BASENAME=$(basename "$CPP_FILE" .cpp)
EXECUTABLE="${BASENAME}_bench"

echo -e "${BLUE}🚀 C++ Performance Benchmark${NC}"
echo -e "${CYAN}File: $CPP_FILE${NC}"
echo -e "${CYAN}Input: $INPUT_FILE${NC}"
echo -e "${CYAN}Iterations: $ITERATIONS${NC}"
echo ""

# Compilation flags for different optimization levels
declare -A COMPILE_FLAGS=(
    ["O0"]="g++ -std=c++17 -O0 -Wall -Wextra"
    ["O1"]="g++ -std=c++17 -O1 -Wall -Wextra"
    ["O2"]="g++ -std=c++17 -O2 -Wall -Wextra"
    ["O3"]="g++ -std=c++17 -O3 -Wall -Wextra"
    ["Ofast"]="g++ -std=c++17 -Ofast -Wall -Wextra"
    ["Contest"]="g++ -std=c++17 -O2 -Wall -Wextra -DONLINE_JUDGE"
)

echo -e "${YELLOW}🔨 Compilation Results:${NC}"
echo "| Optimization | Compile Time | Executable Size | Status |"
echo "|--------------|--------------|-----------------|--------|"

# Store successful compilations
declare -a SUCCESSFUL_BUILDS=()

for opt in "${!COMPILE_FLAGS[@]}"; do
    start_time=$(date +%s.%N)
    
    if ${COMPILE_FLAGS[$opt]} -o "${EXECUTABLE}_${opt}" "$CPP_FILE" 2>/dev/null; then
        end_time=$(date +%s.%N)
        compile_time=$(echo "$end_time - $start_time" | bc)
        file_size=$(stat -c%s "${EXECUTABLE}_${opt}")
        file_size_kb=$(echo "scale=1; $file_size / 1024" | bc)
        
        printf "| %-12s | %8.3fs | %10.1f KB | ✅ OK   |\n" "$opt" "$compile_time" "$file_size_kb"
        SUCCESSFUL_BUILDS+=("$opt")
    else
        printf "| %-12s | %8s | %13s | ❌ FAIL |\n" "$opt" "N/A" "N/A"
    fi
done

echo ""

if [ ${#SUCCESSFUL_BUILDS[@]} -eq 0 ]; then
    echo -e "${RED}❌ No successful compilations!${NC}"
    exit 1
fi

echo -e "${YELLOW}⚡ Runtime Performance:${NC}"
echo "| Optimization | Avg Time | Min Time | Max Time | Memory | Status |"
echo "|--------------|----------|----------|----------|--------|--------|"

for opt in "${SUCCESSFUL_BUILDS[@]}"; do
    executable="${EXECUTABLE}_${opt}"
    
    if [ ! -f "$executable" ]; then
        continue
    fi
    
    # Array to store execution times
    declare -a times=()
    max_memory=0
    failed_runs=0
    
    for ((i=1; i<=ITERATIONS; i++)); do
        # Use /usr/bin/time for more detailed stats
        if command -v /usr/bin/time >/dev/null 2>&1; then
            # Use GNU time if available
            time_output=$(timeout 10s /usr/bin/time -f "%e %M" ./"$executable" < "$INPUT_FILE" 2>&1 >/dev/null)
            if [ $? -eq 0 ]; then
                runtime=$(echo "$time_output" | awk '{print $1}')
                memory=$(echo "$time_output" | awk '{print $2}')
                times+=("$runtime")
                if (( $(echo "$memory > $max_memory" | bc -l) )); then
                    max_memory=$memory
                fi
            else
                ((failed_runs++))
            fi
        else
            # Fallback to bash time
            start_time=$(date +%s.%N)
            if timeout 10s ./"$executable" < "$INPUT_FILE" >/dev/null 2>&1; then
                end_time=$(date +%s.%N)
                runtime=$(echo "$end_time - $start_time" | bc)
                times+=("$runtime")
            else
                ((failed_runs++))
            fi
        fi
    done
    
    if [ ${#times[@]} -gt 0 ]; then
        # Calculate statistics
        total_time=0
        min_time=${times[0]}
        max_time=${times[0]}
        
        for time in "${times[@]}"; do
            total_time=$(echo "$total_time + $time" | bc)
            if (( $(echo "$time < $min_time" | bc -l) )); then
                min_time=$time
            fi
            if (( $(echo "$time > $max_time" | bc -l) )); then
                max_time=$time
            fi
        done
        
        avg_time=$(echo "scale=6; $total_time / ${#times[@]}" | bc)
        
        # Format memory
        if [ "$max_memory" -gt 0 ]; then
            memory_mb=$(echo "scale=1; $max_memory / 1024" | bc)
            memory_str="${memory_mb} MB"
        else
            memory_str="N/A"
        fi
        
        # Status
        if [ $failed_runs -gt 0 ]; then
            status="⚠️  ${failed_runs}F"
        else
            status="✅ OK"
        fi
        
        printf "| %-12s | %7.4fs | %7.4fs | %7.4fs | %6s | %6s |\n" \
               "$opt" "$avg_time" "$min_time" "$max_time" "$memory_str" "$status"
    else
        printf "| %-12s | %8s | %8s | %8s | %6s | %6s |\n" \
               "$opt" "TIMEOUT" "TIMEOUT" "TIMEOUT" "N/A" "❌ FAIL"
    fi
done

echo ""

# Find the best performing optimization
echo -e "${YELLOW}🏆 Performance Analysis:${NC}"

# Check if hyperfine is available for more detailed benchmarking
if command -v hyperfine >/dev/null 2>&1; then
    echo -e "${CYAN}Running detailed benchmark with hyperfine...${NC}"
    
    # Build hyperfine command
    hyperfine_cmd="hyperfine --warmup 3 --min-runs $ITERATIONS"
    
    for opt in "${SUCCESSFUL_BUILDS[@]}"; do
        executable="${EXECUTABLE}_${opt}"
        if [ -f "$executable" ]; then
            hyperfine_cmd="$hyperfine_cmd './$executable < $INPUT_FILE'"
        fi
    done
    
    # Run hyperfine
    eval "$hyperfine_cmd"
else
    echo -e "${YELLOW}💡 Install 'hyperfine' for more detailed benchmarking:${NC}"
    echo "   nix-shell -p hyperfine"
fi

echo ""
echo -e "${GREEN}🧹 Cleaning up temporary files...${NC}"
for opt in "${!COMPILE_FLAGS[@]}"; do
    rm -f "${EXECUTABLE}_${opt}"
done

echo -e "${GREEN}✅ Benchmark complete!${NC}"

# Recommendations
echo ""
echo -e "${BLUE}💡 Recommendations:${NC}"
echo "• For contests: Use -O2 (good balance of speed and compile time)"
echo "• For maximum performance: Use -O3 or -Ofast"
echo "• For debugging: Use -O0 with -g flag"
echo "• Always test with contest-like time limits (1-2 seconds)" 