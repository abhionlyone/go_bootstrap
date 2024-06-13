#!/bin/bash

cat <<EOL > internal/middleware/auth.go
package middleware

import (
    "net/http"
    "github.com/gin-gonic/gin"
)

func AuthMiddleware() gin.HandlerFunc {
    return func(c *gin.Context) {
        // Authentication logic
        c.Next()
    }
}
EOL