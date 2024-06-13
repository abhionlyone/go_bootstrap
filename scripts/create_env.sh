#!/bin/bash

cat <<EOL > .env
DB_HOST=localhost
DB_PORT=5432
DB_USER=$(prompt_for_input "Enter your database user")
DB_PASSWORD=$(prompt_for_input "Enter your database password")
DB_NAME=$(prompt_for_input "Enter your database name")
EOL