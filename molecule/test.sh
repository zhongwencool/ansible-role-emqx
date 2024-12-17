#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to run tests
run_test() {
    local distro=$1
    echo -e "${YELLOW}Testing on $distro${NC}"
    
    MOLECULE_DISTRO=$distro molecule test
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Tests passed on $distro${NC}"
    else
        echo -e "${RED}Tests failed on $distro${NC}"
        exit 1
    fi
}

# Main test sequence
echo "Starting EMQX role tests..."

# Test on different distributions
run_test "ubuntu2004"
run_test "ubuntu2204"
run_test "debian11"
run_test "debian12"

echo -e "${GREEN}All tests completed successfully!${NC}" 