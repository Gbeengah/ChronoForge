const express = require('express');
const cors = require('cors'); // Import cors middleware
const app = express();
const port = 3000;

// Enable CORS
app.use(cors());

// Set up middleware for parsing request bodies
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Sample data - Todo list
let todos = [];

// Routes
app.get('/', (req, res) => {
  res.send('Welcome to the Todo list application!');
});

// Get all todos
app.get('/todos', (req, res) => {
  res.json(todos);
});

// Create a new todo
app.post('/todos', (req, res) => {
  const { title } = req.body;
  const newTodo = { id: todos.length + 1, title };
  todos.push(newTodo);
  res.status(201).json(newTodo);
});

// Start the server
app.listen(port, () => {
  console.log(`Todo app listening at http://localhost:${port}`);
});

