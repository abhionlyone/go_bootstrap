#!/bin/bash

# Function to prompt for user input
prompt_for_input() {
    read -p "$1: " input
    echo $input
}

# Prompt for project name
PROJECT_NAME=$(prompt_for_input "Enter your project name")

# Create project directory
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Initialize Go module
go mod init $PROJECT_NAME

# Create folder structure
mkdir -p cmd/$PROJECT_NAME
mkdir -p internal/{controllers,models,views,config,db,middleware,utils}
mkdir -p migrations
mkdir -p api

# Run sub-scripts
./scripts/create_main.sh $PROJECT_NAME
./scripts/create_env.sh
./scripts/create_config.sh
./scripts/create_db.sh $PROJECT_NAME
./scripts/create_routes.sh $PROJECT_NAME
./scripts/create_controllers.sh $PROJECT_NAME
./scripts/create_middleware.sh
./scripts/create_utils.sh
./scripts/create_migrations.sh $PROJECT_NAME

# Install dependencies
go get github.com/gin-gonic/gin
go get github.com/joho/godotenv
go get gorm.io/gorm
go get gorm.io/driver/postgres
go get github.com/go-gormigrate/gormigrate/v2
go get go.uber.org/zap

echo "Project setup complete!"