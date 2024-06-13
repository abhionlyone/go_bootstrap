# go_boostrap

`go_boostrap` is a powerful and modern generator for creating Go-based backend projects. It provides a robust and scalable structure using the MVC architecture, integrates best-in-class tools and libraries, and ensures best practices for stability and maintainability. With `go_boostrap`, you can quickly set up a Go backend project with PostgreSQL, GORM, Gin, Zap logging, and more.

## Features

- **MVC Architecture**: Organizes your project into Model, View, and Controller layers.
- **PostgreSQL Integration**: Uses PostgreSQL as the database.
- **GORM ORM**: Integrates GORM for database operations.
- **Migrations**: Includes a setup for database migrations using `gormigrate`.
- **JSON API**: Serves APIs in JSON format.
- **Logging**: Uses `zap` for structured and high-performance logging.
- **Environment Variables**: Manages configuration using environment variables.
- **Authentication**: Includes basic authentication and CRUD operations for users.

## Installation

To install `go_boostrap` directly from the GitHub repository, run the following command:

```bash
curl -sL https://raw.githubusercontent.com/abhionlyone/go_boostrap/main/setup_go_project.sh | bash
```

This command will download the setup_go_project.sh script from your GitHub repository and execute it using bash. The script will prompt you for necessary inputs and create the project structure.

## Project Structure
The generated project will have the following structure:
```
go_boostrap/
├── cmd/
│   └── go_boostrap/
│       └── main.go
├── internal/
│   ├── config/
│   │   └── config.go
│   ├── controllers/
│   │   └── user_controller.go
│   ├── db/
│   │   └── db.go
│   ├── middleware/
│   │   └── auth.go
│   ├── models/
│   ├── routes/
│   │   └── routes.go
│   ├── utils/
│   │   └── logger.go
│   └── views/
├── migrations/
│   └── migrate.go
├── api/
├── .env
```
## Configuration

The project uses environment variables for configuration. Update the .env file with your database credentials and other settings:
```
DB_HOST=localhost
DB_PORT=5432
DB_USER=youruser
DB_PASSWORD=yourpassword
DB_NAME=yourdbname
```

## Usage
curl -sL https://cdn.jsdelivr.net/gh/abhionlyone/go_bootstrap@main/setup_go_project.sh | bash