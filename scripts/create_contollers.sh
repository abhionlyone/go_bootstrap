#!/bin/bash

PROJECT_NAME=$1

cat <<EOL > internal/controllers/user_controller.go
package controllers

import (
    "net/http"
    "github.com/gin-gonic/gin"
)

func Register(c *gin.Context) {
    // Registration logic
    c.JSON(http.StatusOK, gin.H{"message": "User registered successfully"})
}

func Login(c *gin.Context) {
    // Login logic
    c.JSON(http.StatusOK, gin.H{"message": "User logged in successfully"})
}
EOL