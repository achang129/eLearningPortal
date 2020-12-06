List of API calls:

Some notes- these are not final. Depending on how the front-end goes it may
make sense to change some of the paths, or how some data is sent back and forth.
This is intended as a baseline set of calls to use as a starting point.

Unless otherwise specified, no additional parameters (other than user information and
any path variables) are needed.

## Calls

| ----- | Method: | `GET` | `POST` | `PUT` | `DELETE` |
| Path: | `/course` | Y | Y | Y | N |
| ----- | `/course/{id} | Y | Y | Y | Y |
| ----- | `/homework` | Y | Y | N | N |
| ----- | `/homework/{id} | Y | Y | Y | Y |

### /course

`GET` gives a list of all courses the user is teaching/enrolled in.

`POST` creates a new course.

* requires a course object as an additional parameter.

`PUT` adds students/teachers to a course.

* requires the student/teacher's user id as an additional parameter.

### /course/{id}

`GET` gives detailed information/curriculum for a particular course on a particular date.

`POST` sets the curriculum for a particular course on a particular date.

* requires a date object as an additional parameter
* requires a curriculum object as an additional parameter

`PUT` edits the curriculum for a particular course on a particular date.

* requires a date object as an additional parameter
* requires a curriculum object as an additional parameter

`DELETE` deletes a course.

### /homework

`GET` gives a list of all homework assignments in all courses a user is taking/teaching.

* Not sure the best way to implement it, but would like to have a way to limit returned courses. Optional parameters for course id/date range?

`POST` creates a new homework assignment for a particular course.

* requires a date object as an additional parameter (assignment date)
* requires a homework object as an additional parameter

### /homework/{id}

`GET` gives detailed information about a particular homework assignment.

`POST` submits homework for grading.

`PUT` submits answer to a question on the homework from the user.

* requires question number as an additional parameter
* requires the answer given as an additional parameter

`DELETE` deletes a particular homework assignment.