List of API calls:

Some notes- these are not final. Depending on how the front-end goes it may
make sense to change some of the paths, or how some data is sent back and forth.
This is intended as a baseline set of calls to use as a starting point.

Unless otherwise specified, no additional parameters (other than user information and
any path variables) are needed.

## Calls

| Path | `GET` | `POST` | `PUT` | `DELETE` |
| -------- | ---- | ---- | ---- | ------ |
| `/courses` | Y | Y | Y | N |
| `/courses/{id}` | Y | Y | Y | Y |
| `/courses/grade/{id}` | Y | N | N | N |
| `/grades/` | Y | N | N | N |
| `/grades/{id}` | Y | N | Y | N |
| `/homework` | Y | Y | N | N |
| `/homework/{id}` | Y | Y | Y | Y |
| `/messages` | Y | N | N | Y |
| `/messages/read` | Y | N | Y | N |
| `/student/` | Y | N | N | N |
| `/users` | Y | N | N | N |
| `/users/{role}` | Y | N | N | N |


### /courses

`GET` gives a list of all courses the user is teaching/enrolled in.

`POST` creates a new course.

* `GET` and `POST` use a 'CourseDTO' object
 * has `name` field containing the name of the course
 * has `description` field containing the description of the course
 * has `difficulty` field containing the difficulty of the course
 * has `cost` field containing the cost of the course

`PUT` adds students/teachers to a course.

* requires a 'CourseAssignmentDTO' object as the request body
 * has `user` field containing the id of the user being assigned as a student/teacher
 * has `course` field containing the id of the course being assigned to

### /courses/grade/{id}

`GET` returns a list of grades for all users in a particular course.

* uses a 'CourseGradeDTO' object
 * has `course` field containing the name of the course
 * has `student` field containing the name of the student whose grade it is
 * has `grade` field containing the grade


### /courses/\{id\}

`GET` gives detailed information/curriculum for a particular course on a particular date.

* returns a 'CourseDetailsDTO' object
 * has `name` field containing the name of the course
 * has `description` field containing the description of the course
 * has `difficulty` field containing the difficulty of the course
 * has `cost` field containing the cost of the course
 * has `dates` field containing a list of dates on which curricula have been assigned
 * has `curricula` field containing a list of curriculum objects corresponding to the dates in the above field
  * curricula have `lesson` field containing the daily lesson plan
  * curricula have `homework` field containing the id of the homework assigned on that day (or zero if there isn't any)

`POST` sets the curriculum for a particular course on a particular date.

`PUT` edits the curriculum for a particular course on a particular date.

* `POST`/`PUT` use a 'CurriculumDTO' object
 * has `lesson` field containing the daily lesson plan for the curriculum
 * has `homework` field containing the id of the homework assigned on that date, or 0 if there is no homework
 * has `date` field the date the curriculum is assigned for

`DELETE` deletes a course.

### /grades/

`GET` gives a list of grades for courses the user is enrolled in, or for students enrolled in the user's courses if user is a teacher.

* uses a 'CourseGradeDTO' object
 * has `course` field containing the name of the course
 * has `student` field containing the name of the student whose grade it is
 * has `grade` field containing the grade

### /grades/\{id\}

`GET` gives the user's grade on a particular assignment if they are a student, or gives all students' grades on a particular assignment if the user is a teacher.

`PUT` submits a grade for a particular assignment.

* uses a 'GradeDTO' object
 * has `assignment` field containing the name of the assignment
 * has `student` field containing the name of the student who submitted the assignment
 * has `status` field containing the status of the assignment ('unsubmitted', 'submitted', or 'graded')
 * has `submitted` field containing the timestamp of when the assignment was submitted
 * has `rawGrade` field containing the grade automatically calculated for the assignment
 * has `grade` field containing the grade of the assignment
 * has `comment` field containing any comments made about the grade/assignment

### /homework

`GET` gives a list of all homework assignments in all courses a user is taking/teaching.

`POST` creates a new homework assignment for a particular course.

* both use an 'AssignmentDTO' object
 * has `name` field containing the assignment name
 * has `description` field containing the assignment description
 * has `date` field containing the date the work is assigned
 * has `dueDate` field containing the date the work is due
 * has `course` field containing the id of the course the work is being assigned to
 * has `questions` field containing a list of the questions making up the assignment
 * questions have `type` field containing 'text' (for short-answer questions), 'mc' (for multiple-choice questions), or 'mmc' (for multiple-choice questions that let you select multiple answers)
 * questions have `statement` field containing the text of the question statement
 * questions have `answers` field containing a list of the selectable answers to the question or a list of accepted answers for text questions
 * questions have `correct` field containing a list of true/false values indicating which of the selectable answers is correct (ignored for text questions)
 * questions have `weight` field indicating how many points the question is worth

### /homework/\{id\}

`GET` gives detailed information about a particular homework assignment.

* returns an 'AssignmentDTO' object
 * has `name` field containing the assignment name
 * has `date` field containing the date the work is assigned
 * has `dueDate` field containing the date the work is due
 * has `course` field containing the id of the course the work is being assigned to
 * has `questions` field containing a list of the questions making up the assignment
 * questions have `type` field containing 'text' (for short-answer questions), 'mc' (for multiple-choice questions), or 'mmc' (for multiple-choice questions that let you select multiple answers)
 * questions have `statement` field containing the text of the question statement
 * questions have `answers` field containing a list of the selectable answers to the question or a list of accepted answers for text questions
 * questions have `correct` field containing a list of true/false values indicating which of the selectable answers is correct (ignored for text questions)

`POST` submits homework for grading.

`PUT` submits answer to a question on the homework from the user.

* requires an 'AnswerDTO' object as the request body
 * has `assignment` field containing the id of the assignment
 * has `question` field containing the number of the question being answered
 * has `answer` field containing the answer given

`DELETE` deletes a particular homework assignment.

### /messages

`GET` returns a list of all messages sent to the current user.

`DELETE` removes a message from their list.

* requires the message id as the request body

### /messages/read

`GET` returns 'true' if the given message has been read and false otherwise.

`PUT` sets the message status to read.

* both require the message id as the request body

### /student

`GET` returns a list of GPAs for all students.

* uses a GTADTO object
 * has `student` field containing the name of the student in question
 * has `gpa` field containing their gpa

### /users

`GET` returns a list of all users.

### /users\{role\}

`GET` returns a list of all users with the specified role.
