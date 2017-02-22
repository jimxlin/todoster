$(function() {
  // Creates an <li> element out of JSON data for Tasks
  function taskHtml(task) {
    var checkedStatus = task.done ? "checked" : ""
    var liElement = '<li><div class="view"><input class="toggle" type="checkbox"' +
      " data-id='" + task.id + "'" +
      checkedStatus +
      '><label>' +
      task.title +
      '</label></div></li>';

    return liElement;
  }

  // takes in HTML of Task fired by .change()
  // and updates DB with value of 'done' field with AJAX
  function toggleTask(e) {
    var itemId = $(e.target).data("id");
    var doneValue = Boolean($(e.target).is(':checked'));

    $.post("/tasks/" + itemId, {
      _method: "PUT",
      task: {
        done: doneValue
      }
    });
  }

  $.get("/tasks").success(function(data) {
    var htmlString = "";
    data.forEach(function(task, i) {
      htmlString += taskHtml(task);
    });
    var ulTodos = $('.todo-list')
    ulTodos.html(htmlString)

    $('.toggle').change(toggleTask);
  });

  $('#new-form').submit(function(event){
    event.preventDefault();
    var textbox = $('.new-todo');
    var payload = {
      task: {
        title: textbox.val()
      }
    }
    $.post("/tasks", payload).success(function(data){
      var htmlString = taskHtml(data);
      var ulTodos = $('.todo-list');
      ulTodos.append(htmlString);
      $('.toggle').change(toggleTask);
    });
  });

});
