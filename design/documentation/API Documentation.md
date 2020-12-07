List of API calls:

Some notes- these are not final. Depending on how the front-end goes it may
make sense to change some of the paths, or how some data is sent back and forth.
This is intended as a baseline set of calls to use as a starting point.

Unless otherwise specified, no additional parameters (other than user information and
any path variables) are needed.

## Calls

| Path | `GET` | `POST` | `PUT` | `DELETE` |
| -------- | ---- | ---- | ---- | ------ |
| `/course` | Y | Y | Y | N |
| `/course/{id}` | Y | Y | Y | Y |
| `/homework` | Y | Y | N | N |
| `/homework/{id}` | Y | Y | Y | Y |
| `/messages` | Y | N | N | Y |
| `/messages/read` | Y | N | Y | N |
| `/users` | Y | N | N | N |
| `/users/{role}` | Y | N | N | N |


### /course

`GET` gives a list of all courses the user is teaching/enrolled in.

`POST` creates a new course.

* requires a course object as the request body

`PUT` adds students/teachers to a course.

* requires a 'course assignment' object as the request body
 * has `user` field containing the id of the user being assigned as a student/teacher
 * has `course` field containing the id of the course being assigned to

### /course/\{id\}

`GET` gives detailed information/curriculum for a particular course on a particular date.

`POST` sets the curriculum for a particular course on a particular date.

* requires a 'curriculum assignment' object as the request body
 * has `curriculum` field containing a curriculum object
 * has `date` field the date the curriculum is assigned for

`PUT` edits the curriculum for a particular course on a particular date.

* requires a 'curriculum assignment' object as the request body
 * has `curriculum` field containing a curriculum object
 * has `date` field the date the curriculum is assigned for

`DELETE` deletes a course.

### /homework

`GET` gives a list of all homework assignments in all courses a user is taking/teaching.

`POST` creates a new homework assignment for a particular course.

* requires a 'homework assignment' object as the request body
 * has `homework` containing an assignment object
 * has `date` field containing the date the work is assigned
 * has `course` field containing the id of the course the work is being assigned to

### /homework/\{id\}

`GET` gives detailed information about a particular homework assignment.

`POST` submits homework for grading.

`PUT` submits answer to a question on the homework from the user.

* requires a 'homework answer' object as the request body
 * has `question` field containing the number of the question being answered
 * has `answer` field containing the answer given

`DELETE` deletes a particular homework assignment.

### /messages

`GET` returns a list of all messages sent to the current user.

`DELETE` removes a message from their list.

* requires the message id as the request body

### /messages/read

`GET` returns 'true' if the given message has been read and false otherwise.

* requires the message id as the request body

`PUT` sets the message status to read.

* requires the message id as the request body

### /users

`GET` returns a list of all users.

### /users\{role\}

`GET` returns a list of all users with the specified role.
