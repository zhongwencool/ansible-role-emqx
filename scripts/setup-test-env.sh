#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Setting up test environment..."

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt

# Install required collections
echo -e "\n${YELLOW}Installing required Ansible collections...${NC}"
ansible-galaxy collection install -r meta/requirements.yml

# Run linting checks
echo -e "\n${YELLOW}Running linting checks...${NC}"

# Print tool versions
echo -e "\n${YELLOW}Tool versions:${NC}"
echo -n "yamllint version: "
yamllint --version

echo -n "ansible version: "
ansible --version | head -n1

echo -n "molecule version: "
molecule --version

# Continue with linting checks
echo -n "Running yamllint... "
if yamllint . > /dev/null 2>&1; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
    yamllint .
fi

echo -n "Running ansible-lint... "
if ansible-lint > /dev/null 2>&1; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
    ansible-lint
fi

# Verify molecule installation
echo -n "Checking molecule installation... "
if molecule --version > /dev/null 2>&1; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
    exit 1
fi

echo -e "${GREEN}Test environment setup completed!${NC}" 