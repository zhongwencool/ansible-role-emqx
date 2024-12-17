#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define supported distributions
DEBIAN_DISTROS=(
    "debian11"
    "debian12"
    "ubuntu2004"
    "ubuntu2204"
)

RHEL_DISTROS=(
    "rockylinux8"
    "rockylinux9"
)

AWS_DISTROS=(
    "amazonlinux2"
    "amazonlinux2023"
)

# Function to run tests for a specific distro
run_test() {
    local distro=$1
    local test_type=${2:-"test"} # Default to full test

    echo -e "${YELLOW}Testing on ${distro}...${NC}"
    
    MOLECULE_DISTRO="${distro}" molecule "${test_type}"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Tests passed for ${distro}${NC}"
        return 0
    else
        echo -e "${RED}✗ Tests failed for ${distro}${NC}"
        return 1
    fi
}

# Function to display usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -h, --help        Show this help message"
    echo "  -d, --distro      Test specific distribution (e.g., debian11, amazonlinux2)"
    echo "  -f, --family      Test specific family (debian, rhel, or aws)"
    echo "  -c, --converge    Run only molecule converge instead of full test"
    echo "  -a, --all         Test all supported distributions"
    echo ""
    echo "Supported distributions:"
    echo "Debian family: ${DEBIAN_DISTROS[*]}"
    echo "RHEL family: ${RHEL_DISTROS[*]}"
    echo "AWS family: ${AWS_DISTROS[*]}"
}

# Initialize variables
SPECIFIC_DISTRO=""
FAMILY=""
TEST_TYPE="test"
TEST_ALL=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -d|--distro)
            SPECIFIC_DISTRO="$2"
            shift 2
            ;;
        -f|--family)
            FAMILY="$2"
            shift 2
            ;;
        -c|--converge)
            TEST_TYPE="converge"
            shift
            ;;
        -a|--all)
            TEST_ALL=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Track failures
FAILED_DISTROS=()

# Run tests based on arguments
if [ -n "$SPECIFIC_DISTRO" ]; then
    run_test "$SPECIFIC_DISTRO" "$TEST_TYPE" || FAILED_DISTROS+=("$SPECIFIC_DISTRO")
elif [ -n "$FAMILY" ]; then
    case $FAMILY in
        debian)
            for distro in "${DEBIAN_DISTROS[@]}"; do
                run_test "$distro" "$TEST_TYPE" || FAILED_DISTROS+=("$distro")
            done
            ;;
        rhel)
            for distro in "${RHEL_DISTROS[@]}"; do
                run_test "$distro" "$TEST_TYPE" || FAILED_DISTROS+=("$distro")
            done
            ;;
        aws)
            for distro in "${AWS_DISTROS[@]}"; do
                run_test "$distro" "$TEST_TYPE" || FAILED_DISTROS+=("$distro")
            done
            ;;
        *)
            echo "Invalid family. Use 'debian', 'rhel', or 'aws'"
            exit 1
            ;;
    esac
elif [ "$TEST_ALL" = true ]; then
    for distro in "${DEBIAN_DISTROS[@]}" "${RHEL_DISTROS[@]}" "${AWS_DISTROS[@]}"; do
        run_test "$distro" "$TEST_TYPE" || FAILED_DISTROS+=("$distro")
    done
else
    usage
    exit 1
fi

# Report results
if [ ${#FAILED_DISTROS[@]} -eq 0 ]; then
    echo -e "${GREEN}All tests completed successfully!${NC}"
    exit 0
else
    echo -e "${RED}Tests failed for the following distributions:${NC}"
    printf '%s\n' "${FAILED_DISTROS[@]}"
    exit 1
fi
