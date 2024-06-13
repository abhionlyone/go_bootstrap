#!/bin/bash

PROJECT_NAME=$1

cat <<EOL > cmd/$PROJECT_NAME/main.go
package main

import (
    "log"
    "$PROJECT_NAME/internal/config"
    "$PROJECT_NAME/internal/db"
    "$PROJECT_NAME/internal/routes"
)

func main() {
    config.LoadEnv()
    db.Connect()
    router := routes.SetupRouter()
    log.Fatal(router.Run(":8080"))
}
EOL