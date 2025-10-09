#!/bin/bash

# Fineract Core Banking Setup Script
# This script helps users set up the Fineract application quickly

set -e  # Exit on any error

echo "🏦 Fineract Core Banking Setup Script"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check Java
    if ! command -v java &> /dev/null; then
        print_error "Java is not installed. Please install Java 17+"
        exit 1
    fi
    
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    if [ "$JAVA_VERSION" -lt 17 ]; then
        print_error "Java version $JAVA_VERSION is too old. Please install Java 17+"
        exit 1
    fi
    print_success "Java $JAVA_VERSION found"
    
    # Check MySQL
    if ! command -v mysql &> /dev/null; then
        print_error "MySQL is not installed. Please install MySQL 8.0+"
        exit 1
    fi
    print_success "MySQL found"
    
    # Check Node.js (for frontend)
    if ! command -v node &> /dev/null; then
        print_warning "Node.js is not installed. Frontend setup will be skipped."
        FRONTEND_SKIP=true
    else
        NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$NODE_VERSION" -lt 18 ]; then
            print_warning "Node.js version $NODE_VERSION is too old. Please install Node.js 18+"
            FRONTEND_SKIP=true
        else
            print_success "Node.js $NODE_VERSION found"
            FRONTEND_SKIP=false
        fi
    fi
}

# Setup database
setup_database() {
    print_status "Setting up database..."
    
    echo "Please enter your MySQL root password (press Enter if no password):"
    read -s MYSQL_PASSWORD
    
    if [ -z "$MYSQL_PASSWORD" ]; then
        MYSQL_CMD="mysql -u root"
    else
        MYSQL_CMD="mysql -u root -p$MYSQL_PASSWORD"
    fi
    
    # Create databases
    $MYSQL_CMD -e "CREATE DATABASE IF NOT EXISTS fineract_tenants;"
    $MYSQL_CMD -e "CREATE DATABASE IF NOT EXISTS fineract_default;"
    
    print_success "Databases created successfully"
}

# Setup backend
setup_backend() {
    print_status "Setting up backend..."
    
    cd fineract
    
    # Set permissions
    print_status "Setting permissions..."
    sudo chmod -R 777 .
    
    # Generate SSL certificate
    print_status "Generating SSL certificate..."
    if [ ! -f "fineract-provider/src/main/resources/keystore.jks" ]; then
        keytool -genkey -alias fineract -keyalg RSA -keystore fineract-provider/src/main/resources/keystore.jks -keysize 2048 -storepass openmf -keypass openmf -dname "CN=localhost, OU=Development, O=Fineract, L=City, ST=State, C=US"
        print_success "SSL certificate generated"
    else
        print_success "SSL certificate already exists"
    fi
    
    # Build application
    print_status "Building application..."
    ./gradlew clean bootJar
    
    print_success "Backend setup completed!"
    print_status "JAR file location: fineract-provider/build/libs/fineract-provider.jar"
}

# Setup frontend
setup_frontend() {
    if [ "$FRONTEND_SKIP" = true ]; then
        print_warning "Skipping frontend setup (Node.js not available)"
        return
    fi
    
    print_status "Setting up frontend..."
    
    cd ../fineract-frontend
    
    # Install dependencies
    print_status "Installing frontend dependencies..."
    npm install
    
    # Install Angular CLI
    print_status "Installing Angular CLI..."
    npm install -g @angular/cli@15.2.11
    
    # Create environment file
    print_status "Creating environment configuration..."
    if [ ! -f "src/assets/env.js" ]; then
        cp src/assets/env.template.js src/assets/env.js
        print_success "Environment file created"
    else
        print_success "Environment file already exists"
    fi
    
    print_success "Frontend setup completed!"
}

# Main setup function
main() {
    echo
    print_status "Starting Fineract Core Banking Setup..."
    echo
    
    check_prerequisites
    echo
    
    setup_database
    echo
    
    setup_backend
    echo
    
    setup_frontend
    echo
    
    print_success "🎉 Setup completed successfully!"
    echo
    echo "📋 Next steps:"
    echo "1. Start backend: cd fineract && java -jar fineract-provider/build/libs/fineract-provider.jar"
    echo "2. Start frontend: cd fineract-frontend && ng serve --proxy-config proxy.conf.js --open"
    echo "3. Access application: http://localhost:4200"
    echo "4. Login: mifos / password"
    echo
    echo "📖 For detailed instructions, see readme.md"
}

# Run main function
main "$@"
