# Task Management

The Task Management application is a web-based platform designed to help users manage their tasks efficiently.

## Features

- **Task Creation and Editing**: Easily create new tasks with detailed descriptions, statuses and due dates. Update tasks as their status changes.

- **Assigning Tasks**: Assign tasks to team members or collaborators. Track task assignments and responsibilities.

- **Status Tracking**: Monitor task progress with customizable status options (Draft, Open, Pending, In Progress, Completed).

- **Filtering and Sorting**: Efficiently manage tasks with filtering by status and sorting by due date or status.

- **User Authentication**: Secure user authentication system. Users can sign up, sign in, and manage their accounts.

## Technologies Used

- **Ruby on Rails** (v7.1): Backend framework for building robust web applications

- **HTML/CSS**: Frontend design and styling.

- **Bootstrap**: Responsive frontend framework for UI components and layout.

- **PostgreSQL** (v13): Relational database management system for data storage

- **Docker Compose**: Containerization tool used for easy setup that is consistent across all machines.

Note: If you have Docker Compose, you don't need any of the other technologies installed locally

## Setup Instructions

To run the Task Management Application locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/EmailsGmails/task-management.git
   cd task-management

2. **Copy Environment variables**:
  Copy the .env.example file to .env:
    ```bash
    cp .env.example .env

  Modify .env file to configure database and other environment variables as needed.

3. **Build and Start Docker Containers**:
    ```bash
    docker-compose build
    docker-compose up -d

4. **Set Up the Database**:
  Once the containers are running, set up the database:
    ```bash
    docker-compose run web rails db:create
    docker-compose run web rails db:migrate
    docker-compose run web rails db:seed

5. **Access the Application**:
  Open your web browser and go to http://localhost:3000 to view the application.

6. **Sign Up and Start Managing Tasks**:
  Create a new account or sign in with existing credentials to start managing your tasks.

## Dependencies
The application relies on the following main dependencies:

- Devise: Handles user authentication, including registration, login/logout, and password management.
- Pundit: Manages authorization by defining user permissions and enforcing access policies.
- Bootstrap: Used for frontend styling and UI components, ensuring a responsive and consistent design.
- Haml: Templating language that simplifies HTML markup, enhancing code readability and reducing verbosity.

## Architecture and Design Decisions
### Architecture
The application follows the Model-View-Controller (MVC) architecture provided by Ruby on Rails:

- Models: Represent data structures and database interactions. Examples include Task, User, and associated relationships.
- Views: Render HTML templates using Haml for cleaner syntax and better readability.
- Controllers: Handle user requests, process data from models, and render appropriate views.

### Design Decisions
- RESTful APIs: Adheres to RESTful principles, mapping HTTP methods to CRUD operations for clarity and consistency.
- Service and Query Objects: Utilizes service objects for encapsulating complex business logic and query objects for handling database queries, promoting code reusability and maintainability.
- Authorization: Uses Pundit for role-based access control (RBAC) to ensure only authorized users can perform specific actions.
- Database Management: PostgreSQL is employed as the database system due to its robust features, performance, and compatibility with Rails.

## License
This project is licensed under the MIT License.

