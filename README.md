# Laravel Dockerfile

This project is designed to set up a Laravel environment using Docker. It leverages the `dunglas/frankenphp` Docker image to provide a PHP runtime, MySQL for the database, and Caddy as the web server. The Docker Compose file defines the
services needed to run the application.

## Background

The goal of this project is to create a simple, isolated environment for developing and running a Laravel application in a Docker container. By using Docker, you can ensure consistency across different environments (e.g., development, testing, production), while avoiding issues related to local machine configurations.

## Project Structure

Here is an overview of the important files in the project:

- **Dockerfile**: Defines the PHP environment, including necessary extensions for Laravel (`pdo_mysql`, `gd`, `intl`, `zip`, `opcache`), and installs Composer.
- **docker-compose.yml**: Configures the necessary services: MySQL for the database, and the application service using the Dockerfile you provided. It also configures volumes for persistence and environment variables.

## Setup Instructions

### Prerequisites

Before starting the project, ensure that you have the following installed:

1. **Docker**: The project uses Docker and Docker Compose. Follow the [Docker installation guide](https://docs.docker.com/get-docker/) for your operating system.
2. **Git**: You'll need Git to clone the repository. Follow the [Git installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) if you don't have it.

### Steps to Set Up

1. **Clone the repository**:
   ```bash
   git clone https://github.com/nielxfb/laravel-dockerfile.git
   cd laravel-dockerfile
   ```

2. **Copy `.env.example` to `.env`**:
   After cloning the repository, you need to copy the `.env.example` file to `.env` and fill in the necessary values, such as database credentials, app settings, etc. You can do this with the following command:

   ```bash
   cp .env.example .env
   ```

   Then, open the `.env` file and configure it according to your environment, especially the database credentials.

3. **Build and start the Docker containers**:
   Using `docker-compose`, you can easily build and start the services defined in `docker-compose.yml`:

   ```bash
   docker compose up --build
   ```

   This command will:

   * Build the `app` service using the `Dockerfile`.
   * Pull the `mysql:8.0-debian` image for the database service.
   * Set up the necessary volumes for data persistence.

4. **Access the Laravel Application**:
   Once the containers are up and running, open your browser and navigate to `http://localhost`. You should see the Laravel welcome page.

5. **Database Configuration**:

   * The MySQL service is accessible via port `3306` on your local machine.
   * The database name is `laravel_dockerfile`, and the root password is set to `root`.
   * In your `.env` file for Laravel, make sure the database connection settings are configured correctly:

     ```env
     DB_CONNECTION=mysql
     DB_HOST=db
     DB_PORT=3306
     DB_DATABASE=laravel_dockerfile
     DB_USERNAME=root
     DB_PASSWORD=root
     ```

6. **Install Composer Dependencies**:
   The `docker-compose.yml` file already runs `composer install` during the container build process, so you shouldn't need to manually install dependencies. However, if you need to install or update dependencies, you can do so by running:

   ```bash
   docker compose exec app composer install
   ```

7. **Access the Application Logs**:
   You can check the application logs using the following command:

   ```bash
   docker compose logs -f app
   ```

8. **Stop the Application**:
   To stop the application and remove the containers, run:

   ```bash
   docker compose down
   ```

### Directory Structure

* `Dockerfile`: Contains the Docker instructions for building the Laravel PHP environment.
* `docker-compose.yml`: Configures the services for the application and database.
* `.env`: Environment variables for the Laravel application.
* `app/`: The Laravel application source code.
* `mysql-data/`: Persistent storage for MySQL data.

## Dockerfile Explanation

The `Dockerfile` provided in the project is used to build the PHP environment for Laravel. Here are the key components:

1. **Base Image**: The project uses `dunglas/frankenphp` as the base image, which provides a PHP runtime optimized for running Laravel applications.
2. **PHP Extensions**: Several PHP extensions are installed using the `install-php-extensions` command:

   * `pdo_mysql`: Required for MySQL database support.
   * `gd`: Image manipulation library used by Laravel.
   * `intl`: Provides internationalization support.
   * `zip`: Allows zip file handling.
   * `opcache`: Improves performance by caching compiled PHP code.
3. **Composer**: Composer is used for managing PHP dependencies. The `composer install` command installs the dependencies as defined in the `composer.json` file.

## Conclusion

This Docker setup provides an isolated and reproducible environment for developing Laravel applications. By using Docker Compose, it's easy to manage the application, database, and web server in a single configuration. This setup ensures that you can develop, test, and deploy your Laravel application without worrying about differences between environments.
