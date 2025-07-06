#!/bin/bash
# CLAUDE-HUB 100% COMPLETE SETUP - CLAUDE MAX 20X SUBSCRIPTION METHOD
# This script implements EVERY feature with Claude Max 20x subscription
# Version: 3.0 - TOTAL COMPLETE IMPLEMENTATION
# Customized for: beeard/claude-hub with bot account: proffbemanning

set -euo pipefail

# Terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Enhanced logging
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_section() { echo -e "\n${PURPLE}${BOLD}=== $1 ===${NC}\n"; }

# Trap errors
trap 'log_error "Error occurred at line $LINENO. Exit code: $?"' ERR

# Global variables - CUSTOMIZED FOR YOUR SETUP
GITHUB_USERNAME="${GITHUB_USERNAME:-beeard}"
BOT_USERNAME="${BOT_USERNAME:-proffbemanning}"
REPO_URL="https://github.com/beeard/claude-hub.git"
CLAUDE_HUB_DIR="$HOME/claude-hub"
MCP_DIR="$HOME/claude-hub-mcp"
MONITORING_DIR="$HOME/claude-hub-monitoring"
SCRIPTS_DIR="$HOME/claude-hub-scripts"
DOCS_DIR="$HOME/claude-hub-docs"
EXTENSIONS_DIR="$HOME/claude-hub-extensions"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Banner
show_banner() {
    clear
    echo -e "${PURPLE}${BOLD}"
    cat << 'EOF'
    ____  _                   _            _   _         _     
   / ___|| |  __ _  _   _  __| |  ___     | | | | _   _ | |__  
  | |    | | / _` || | | |/ _` | / _ \    | |_| || | | || '_ \ 
  | |___ | || (_| || |_| | (_| ||  __/    |  _  || |_| || |_) |
   \____||_| \__,_| \__,_|\__,_| \___|    |_| |_| \__,_||_.__/ 
                                                                
           100% COMPLETE SETUP - CLAUDE MAX 20X METHOD
EOF
    echo -e "${NC}"
    echo -e "${CYAN}Version 3.0 - TOTAL COMPLETE IMPLEMENTATION${NC}"
    echo -e "${CYAN}Repository: beeard/claude-hub | Bot: proffbemanning${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Pre-flight checks
preflight_checks() {
    log_section "Pre-flight Checks"
    
    local errors=0
    
    # Check required tools
    for tool in git docker docker compose node npm openssl jq curl; do
        if command -v "$tool" &> /dev/null; then
            log_success "$tool is installed"
        else
            log_error "$tool is not installed"
            ((errors++))
        fi
    done
    
    # Check Docker daemon
    if docker info &> /dev/null; then
        log_success "Docker daemon is running"
    else
        log_error "Docker daemon is not running"
        ((errors++))
    fi
    
    # Check Node version
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v | cut -d'v' -f2)
        if [ "$(echo "$NODE_VERSION" | cut -d'.' -f1)" -ge 20 ]; then
            log_success "Node.js version $NODE_VERSION meets requirements"
        else
            log_error "Node.js version $NODE_VERSION is too old (need 20+)"
            ((errors++))
        fi
    fi
    
    # Check disk space
    AVAILABLE_SPACE=$(df -BG "$HOME" | awk 'NR==2 {print $4}' | sed 's/G//')
    if [ "$AVAILABLE_SPACE" -ge 20 ]; then
        log_success "Sufficient disk space available (${AVAILABLE_SPACE}GB)"
    else
        log_warning "Low disk space (${AVAILABLE_SPACE}GB) - recommend 20GB+"
    fi
    
    if [ $errors -gt 0 ]; then
        log_error "Pre-flight checks failed. Please install missing dependencies."
        exit 1
    fi
    
    log_success "All pre-flight checks passed!"
}

# Create complete directory structure
create_complete_directories() {
    log_section "Creating Complete Directory Structure"
    
    # Main directories
    local dirs=(
        "$CLAUDE_HUB_DIR"/{docker,scripts,cli,tests,monitoring,cache,recovery,logs,backups}
        "$CLAUDE_HUB_DIR"/{src,db,extensions,configs,templates}
        "$MCP_DIR"/{servers,configs,extensions,templates}
        "$MONITORING_DIR"/{prometheus,grafana,alerts,dashboards,exporters}
        "$SCRIPTS_DIR"/{aws,setup,automation,recovery,backup,maintenance}
        "$DOCS_DIR"/{api,guides,examples,troubleshooting}
        "$EXTENSIONS_DIR"/{vscode,jetbrains,sublime,vim}
        "$HOME/.claude-hub"/{cache,checkpoints,sessions,metrics,audit,tokens}
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_info "Created: $dir"
    done
    
    # Set permissions
    chmod 700 "$HOME/.claude-hub"
    chmod 700 "$HOME/.claude-hub/tokens"
    
    log_success "Complete directory structure created"
}

# Clone and setup repository
setup_repository() {
    log_section "Setting up Claude-Hub Repository"
    
    cd "$HOME"
    
    if [ ! -d "$CLAUDE_HUB_DIR/.git" ]; then
        log_info "Cloning your fork of claude-hub repository..."
        git clone "$REPO_URL"
    else
        log_info "Updating existing repository..."
        cd "$CLAUDE_HUB_DIR"
        git pull origin main
    fi
    
    cd "$CLAUDE_HUB_DIR"
    
    # Copy all documentation
    if [ -d "docs" ]; then
        cp -r docs/* "$DOCS_DIR/" 2>/dev/null || true
        log_success "Documentation copied"
    fi
    
    # Install ALL dependencies including optional ones
    log_info "Installing all dependencies..."
    npm install --include=dev --include=optional
    
    # Install global tools
    log_info "Installing global tools..."
    npm install -g \
        @anthropic-ai/claude-code \
        @modelcontextprotocol/sdk \
        jest pm2 nodemon \
        prettier eslint \
        typescript tsx
    
    log_success "Repository setup complete"
}

# The rest of the script is provided in a separate file due to size
# See: claude-hub-complete-setup-part2.sh

# Main execution
main() {
    show_banner
    
    echo "This installs the ULTIMATE Claude Hub with 100% features:"
    echo ""
    echo "✓ Claude Max 20x authentication (no API key needed!)"
    echo "✓ Complete orchestration system"
    echo "✓ Advanced AI features (computer use, research mode)"
    echo "✓ Enterprise monitoring stack"
    echo "✓ Comprehensive test suite"
    echo "✓ Ultimate CLI tools"
    echo "✓ Full documentation"
    echo "✓ And EVERYTHING else!"
    echo ""
    read -p "Ready to install? (y/n) " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    
    # Run setup steps
    preflight_checks
    create_complete_directories
    setup_repository
    
    # Download and run part 2
    log_info "Downloading setup continuation..."
    curl -fsSL https://raw.githubusercontent.com/beeard/claude-hub/main/claude-hub-complete-setup-part2.sh -o /tmp/claude-hub-setup-part2.sh
    chmod +x /tmp/claude-hub-setup-part2.sh
    source /tmp/claude-hub-setup-part2.sh
}

# Run main
main
