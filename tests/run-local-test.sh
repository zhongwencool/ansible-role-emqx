#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Change to the project root directory
cd "$(dirname "$0")/.." || exit 1
echo -e "${YELLOW}Current directory: $(pwd)${NC}"

echo "Starting EMQX role test..."

# List role contents
echo -e "${YELLOW}Role contents:${NC}"
ls -la

# Debug ansible configuration
echo -e "${YELLOW}Ansible playbook check with verbosity:${NC}"
ansible-playbook -i tests/inventory/hosts.yml tests/playbook-test.yml --syntax-check -vvv

# Run playbook with more verbosity
echo -e "${YELLOW}Running playbook with debug information...${NC}"
ansible-playbook -i tests/inventory/hosts.yml tests/playbook-test.yml -vvv

# Check connection to test host
echo -e "${YELLOW}Testing SSH connection:${NC}"
ssh -p 32222 -i ~/.orbstack/ssh/id_ed25519 default@localhost "echo Connection successful"

# Check EMQX service
echo -n "Checking EMQX service... "
ssh -p 32222 -i ~/.orbstack/ssh/id_ed25519 default@localhost "sudo systemctl status emqx" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
    exit 1
fi

echo "Test completed successfully!" 