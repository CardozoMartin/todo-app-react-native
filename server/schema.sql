CREATE DATABASE todo_app;

USE todo_app;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255)
);

CREATE TABLE todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    complete BOOLEAN DEFAULT false,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE shared_todos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    todo_id INT,
    user_id INT,
    shared_with_id INT,
    FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
);

--creando usuarios
INSERT INTO users (name, email, password) VALUES ("martin","martin@gmail.com","123456789");
INSERT INTO users (name, email, password) VALUES ("bianca","bianca@gmail.com","123456789");

--creando todos
INSERT INTO todos (title, user_id) VALUE ("IR A COMER PIZZA",1),
("IR AL GYM",1),("JUGAR LOLCITO",1);

-- compartar todos
INSERT INTO shared_todos(todo_id,user_id,shared_with_id) VALUES (1,1,2)

-- Obtener todos incluyendo los todos-los-compartidos por id
SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todo_id = shared_todos.todo_id
WHERE todos.user_id = [user_id] OR shared_todos.shared_with_id = [user_id]

SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = 2 OR shared_todos.shared_with_id = 2;
