# README

# Task Manager API

A simple Task Management API built with Ruby on Rails.

Ruby version - ruby 3.1.4p223
Rails version - Rails 7.2.2.1

## Features

- User authentication (JWT-based) - User model with name, email, password, phone, and status.
	- POST /register: Allow users to register with their details.
	- POST /login: Allow users to login with their email and password. Return a JWT
		token for authentication.

- CRUD operations for tasks - Task model with title, description, status(enum), due_date.
	- POST /tasks: Allow users to create a new task.
	- GET /tasks: Allow users to retrieve all tasks.
	- GET /tasks/:id: Allow users to retrieve a specific task.
	- PATCH /tasks/:id: Allow users to update a specific task.
	- DELETE /tasks/:id: Allow users to delete a specific task.
- Task status tracking (`pending`, `in_progress`, `completed`)
