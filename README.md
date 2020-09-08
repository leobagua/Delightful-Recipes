# Delightful Recipes - A simple Sinatra + Contentful app

## Environment

Ruby version: 2.7.1

Sinatra version: 2.0.8.1

### Instructions

#### Running with Docker Compose

- Set the Contentful credentials at the `docker-compose.yml`:
  - 1.1 `CONTENTFUL_ACCESS_TOKEN`
  - 1.2 `CONTENTFUL_SPACE`
  
- After declaring the credentials, just run:
  - ```bash
    docker-compose up --build // to build and run
    ```
    or
  - ```bash
    docker-compose up // to run
    ```

- The app will be available at: `localhost:3000`

- To open the console (like rails console), just run:
  ```bash
  docker-compose exec kgs rake console
  ```
  or
  ```bash
  docker-compose exec kgs rake c 
  ```

#### Running without Docker

- Install the dependencies, run:
  ```bash
  cd recipes
  bundle
  ```

- Make a copy of the `.env.example` file
  ```bash
  cp .env.example .env
  ```

- Set the Contentful credentials at the `.env`
  - 1.1 `CONTENTFUL_ACCESS_TOKEN`
  - 1.2 `CONTENTFUL_SPACE`
  
- Run:
  ```bash
  bundle exec rackup
  ```

- The app will be available at: `localhost:3000`

- To open the console (like rails console), just run:
  ```bash
  rake console
  ```
  or
  ```bash
  rake c  
  ```

