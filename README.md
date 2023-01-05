# Rails Svelte Demo Project

## Introduction
This is a demo project to show how to integrate Svelte into a Rails project.  The project is based on the following tutorial to get rails and postgres running in a docker container:
https://stackslabs.blogspot.com/2023/01/running-ruby-on-rails-with-postgres-in.html

And the following tutorial to get Svelte and Tailwind working with Rails By Deanin on youtube:
https://www.youtube.com/watch?v=xetyDD4I8G4&t=2s

## Prerequisites
You will need to have the following installed on your machine:
- Docker
- Docker Compose
- Code Editor (I use VS Code)
- Git

## Create Project Directory
```
mkdir rails_svelte_demo
cd rails_svelte_demo
git init
git commit -am"Intial Commit"
git branch -M main
```


## Set up your repository
Create a repository on Github and then in your working diretory add your github repo as the origin with
```
  git remote add origin https://github.come/YOUR-USER-NAME/YOUR-REPO-NAME.git

  git push -u origin main
```

## Setup files to initiate your Docekr container
You are going to need a Dockerfile and a docker-compose.yml file to get your container up and running, and a Gemfile to intialize your rails project.

You can either clone the following repo and copy the files out of it or create the files yourself following the tutorial found here:
https://stackslabs.blogspot.com/2023/01/running-ruby-on-rails-with-postgres-in.html 
```
git clone https://github.com/jpickett76/rails_postgres_docker_demo.git
```
Now you will need to add the following to your Dockerfile above the WORKDIR line since we will be using svelte and esbuild to compile our svelte components.
```
RUN yarn add svelte esbuild-svelte
``` 
## Initialize your Rails App and Docker Container
We are going to initiate the rails app without the before building the docker container. 

```
docker-compose run --no-deps web rails new . --force --database=postgresql -j esbuild -c tailwind
docker-compose build
docker-compose up
```
Once the container is up and running you can go to localhost:3000 and you should see an error about the database. 

## Database Setup
### Create your database.yml file
You will need to setup your config/database.yml file and it should look like the following, and feel free to change the names of the databases:
```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: <%= ENV.fetch('DB_HOST', 'localhost') %>
  username: <%= ENV['DB_USERNAME'] %>
  password: <%= ENV['DB_PASSWORD'] %>

development:
  <<: *default
  database: app_development
test:
  <<: *default
  database: app_test

production:
  <<: *default
  database: app_production
  username: app
  password: <%= ENV["APP_DATABASE_PASSWORD"] %>
```
### Create your database
Now we need to open up a terminal window from our Docker app on the container named web (in this tutorial I am using the Docker Desktop app).  Once you have a terminal window open you can run the following commands to create your database and migrate your schema.
```
rake db:create
rake db:migrate
```




