#!/bin/bash

PROJECT_NAME=$1

cat <<EOL > migrations/migrate.go
package main

import (
    "log"
    "$PROJECT_NAME/internal/db"
    "github.com/go-gormigrate/gormigrate/v2"
    "gorm.io/gorm"
)

func main() {
    db.Connect()
    m := gormigrate.New(db.DB, gormigrate.DefaultOptions, []*gormigrate.Migration{
        {
            ID: "2023061301",
            Migrate: func(tx *gorm.DB) error {
                // Migration logic
                return nil
            },
            Rollback: func(tx *gorm.DB) error {
                // Rollback logic
                return nil
            },
        },
    })

    if err := m.Migrate(); err != nil {
        log.Fatalf("Could not migrate: %v", err)
    }
    log.Printf("Migration did run successfully")
}
EOL