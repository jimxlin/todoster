# Todoster

To-do list app utilizing a fluid user interface through Javascript and AJAX, allowing users to rapidly add dynamic content.

![home page](screenshots/screenshot1.png 'home page')

### Adding Tasks
When a user submits a task, and AJAX post request is fired. The request callback then appends a new task element to the list. To display the tasks in a consistent order when reloading the page, the server returns tasks ordered by their primary key id.

### Task Completion
An event listener detects when a task has been clicked, and sends an AJAX request to update the tasks status in the database. The request callback will then alter the appearance of the task element to reflect its status.

### Removing Tasks
When there are tasks marked as completed, a button will appear that lets users remove those tasks. Clicking on the button creates an array that contains the ids of all completed tasks, and sends an AJAX delete request as well as removing the completed task elements.
