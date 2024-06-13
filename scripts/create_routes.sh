#!/bin/bash

PROJECT_NAME=$1

cat <<EOL > internal/routes/routes.go
package routes

import (
    "github.com/gin-gonic/gin"
    "$PROJECT_NAME/internal/controllers"
)

func SetupRouter() *gin.Engine {
    router := gin.Default()
    router.POST("/login", controllers.Login)
    router.POST("/register", controllers.Register)
    return router
}
EOL