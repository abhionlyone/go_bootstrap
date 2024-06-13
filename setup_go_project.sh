#!/bin/bash

echo "Welcome to the Go project bootstrap script!"

# Ask for project name
read -p "Enter your project name: " project_name

# Create project directory
mkdir $project_name
cd $project_name

# Initialize Go module
go mod init $project_name

# Install dependencies
echo "Installing dependencies..."
go get -u gorm.io/gorm
go get -u gorm.io/driver/postgres
go get -u github.com/go-gormigrate/gormigrate/v2
go get -u github.com/gin-gonic/gin
go get -u github.com/uber-go/zap

# Create folder structure
echo "Creating folder structure..."
mkdir -p cmd/$project_name config controllers models migrations serializers services utils routes

# Create config/config.go
cat <<EOL > config/config.go
package config

import (
	"fmt"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"log"
)

var DB *gorm.DB

func InitDB() {
	dsn := "host=localhost user=youruser password=yourpassword dbname=yourdb port=5432 sslmode=disable"
	var err error
	DB, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("Could not connect to the database: %v", err)
	}
	fmt.Println("Database connected successfully")
}
EOL

# Create models/user.go
cat <<EOL > models/user.go
package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	Name  string \`json:"name"\`
	Email string \`json:"email"\`
}
EOL

# Create migrations/migrations.go
cat <<EOL > migrations/migrations.go
package migrations

import (
	"log"
	"fmt"
	"$project_name/config"
	"$project_name/models"
	"github.com/go-gormigrate/gormigrate/v2"
	"gorm.io/gorm"
)

func Migrate() {
	m := gormigrate.New(config.DB, gormigrate.DefaultOptions, []*gormigrate.Migration{
		{
			ID: "2023061301",
			Migrate: func(tx *gorm.DB) error {
				return tx.AutoMigrate(&models.User{})
			},
			Rollback: func(tx *gorm.DB) error {
				return tx.Migrator().DropTable("users")
			},
		},
	})

	if err := m.Migrate(); err != nil {
		log.Fatalf("Could not migrate: %v", err)
	}
	fmt.Println("Migration did run successfully")
}
EOL

# Create controllers/user_controller.go
cat <<EOL > controllers/user_controller.go
package controllers

import (
	"$project_name/config"
	"$project_name/models"
	"$project_name/serializers"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetUsers(c *gin.Context) {
	var users []models.User
	if err := config.DB.Find(&users).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, serializers.SerializeUsers(users))
}
EOL

# Create serializers/user_serializer.go
cat <<EOL > serializers/user_serializer.go
package serializers

import "$project_name/models"

type UserSerializer struct {
	ID    uint   \`json:"id"\`
	Name  string \`json:"name"\`
	Email string \`json:"email"\`
}

func SerializeUser(user models.User) UserSerializer {
	return UserSerializer{
		ID:    user.ID,
		Name:  user.Name,
		Email: user.Email,
	}
}

func SerializeUsers(users []models.User) []UserSerializer {
	serializedUsers := make([]UserSerializer, len(users))
	for i, user := range users {
		serializedUsers[i] = SerializeUser(user)
	}
	return serializedUsers
}
EOL

# Create routes/routes.go
cat <<EOL > routes/routes.go
package routes

import (
	"$project_name/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()
	r.GET("/users", controllers.GetUsers)
	return r
}
EOL

# Create utils/logger.go
cat <<EOL > utils/logger.go
package utils

import (
	"go.uber.org/zap"
)

var Logger *zap.Logger

func InitLogger() {
	var err error
	Logger, err = zap.NewProduction()
	if err != nil {
		panic(err)
	}
	defer Logger.Sync()
}
EOL

# Create cmd/$project_name/main.go
cat <<EOL > cmd/$project_name/main.go
package main

import (
	"$project_name/config"
	"$project_name/migrations"
	"$project_name/routes"
	"$project_name/utils"
)

func main() {
	utils.InitLogger()
	config.InitDB()
	migrations.Migrate()

	r := routes.SetupRouter()
	r.Run(":8080")
}
EOL

echo "Project $project_name has been created successfully!"
echo "To run your project, use: go run cmd/$project_name/main.go"