#!/bin/bash

cat <<EOL > internal/config/config.go
package config

import (
    "github.com/joho/godotenv"
    "log"
)

func LoadEnv() {
    err := godotenv.Load()
    if err != nil {
        log.Fatalf("Error loading .env file")
    }
}
EOL