// Define a variable to store the list of todos
let todos = [];

// Function to render the list of todos
function renderTodos() {
  const todoList = document.getElementById('todoList');
  // Clear existing todos
  todoList.innerHTML = '';
  // Loop through todos and add them to the list
  todos.forEach(todo => {
    const todoItem = document.createElement('div');
    todoItem.textContent = todo.title;
    todoList.appendChild(todoItem);
  });
}

// Function to fetch todos from backend API
function fetchTodos() {
  fetch('http://localhost:3000/todos')
    .then(response => response.json())
    .then(data => {
      // Update todos with fetched data
      todos = data;
      // Render the updated list of todos
      renderTodos();
    })
    .catch(error => {
      console.error('Error fetching todos:', error);
    });
}

// Function to add a new todo
function addTodo() {
  const todoInput = document.getElementById('todoInput');
  const title = todoInput.value.trim();
  if (title) {
    const newTodo = { id: todos.length + 1, title };
    todos.push(newTodo);
    renderTodos();
    // Clear input field
    todoInput.value = '';
  }
}

// Add event listener to form submission
const todoForm = document.getElementById('todoForm');
todoForm.addEventListener('submit', function(event) {
  event.preventDefault();
  addTodo();
});

// Fetch todos when the page loads
fetchTodos();

