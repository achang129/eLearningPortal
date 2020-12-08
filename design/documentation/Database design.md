# Database Design Document

## Tables

### users

| Field | Type | Description |
| --------- | -------- | ----------- |
| `user_id` | int | primary key |
| `username` | varchar(50) | user name |
| `password_hash` | varchar(200) | hash of user password |
| `role` | varchar(50) | user role ('teacher', 'student', 'administrator') |

### teacher

Contains information about which courses are being taught by whom.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `teacher` | int | the teacher of the course (foreign key `user_id` from `users` table) |
| `course` | int | the course being taught (foreign key `id` from `course` table) |

`user` and `course` together are a primary key.

### student

Contains information about which students are currently enrolled in what courses.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `student` | int | the student enrolled in the course (foreign key `user_id` from `users` table) |
| `course` | int | the course they are enrolled in (foreign key `id` from `course` table) |

`student` and `course` together are a primary key.

### course

Contains information about courses.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `id` | int | primary key |
| `name` | varchar(64) | name of the course |
| `description` | varchar(256) | description of the course |
| `difficulty` | varchar(32) | difficulty level of the course |
| `cost` | int | cost of the course in cents |

`cost` has a default value of `0`.

### curriculum

Contains information about the daily curriculum of a course.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `course` | int | the course for which this curriculum is assigned (foreign key `id` from `course` table) |
| `date` | date | the day for which this is the curriculum |
| `lesson` | text | the text description of the day's lesson plan |
| `homework` | int | foreign key `id` from `assignment` table |

`course` and `date` together are a primary key.
`homework` can be null.

### assignment

Contains information about a particular homework assignment.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `id` | int | primary key |
| `due_date` | date | the assignment's due date |
| `questions` | int | the number of questions on the assignment |

`due_date` can be null, indicating an assignment with no fixed due date.

### question

Contains information about a particular question on an assignment.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `assignment` | int | the assignment on which this question appears (foreign key `id` in `assignment` table) |
| `number` | int | the number of this question on the assignment |
| `type` | varchar(4) | the type of question |
| `statement` | varchar(256) | the question statement |

`assignment` and `number` together are a primary key.
`type` is restricted to 'text', 'mc' (multiple-choice), 'mmc' (multiple-choice with multiple selections).

### mcchoice

Contains information on the multiple-choice answers shown for particular questions

| Field | Type | Description |
| --------- | -------- | ----------- |
| `assignment` | int | the assignment on which the question appears (foreign key `id` in `assignment` table) |
| `question` | int | the number of the question (foreign key `number` in `question` table) |
| `choice` | int | an identifier for this choice |
| `answer` | varchar(256) | the text of the answer |
| `correct` | boolean | 'true' if this choice is correct, otherwise 'false' |

`assignment`, `question`, and `choice` together are a primary key.

### answer

Contains information about the answer given by a student to a question.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `student` | int | the student giving the answer (foreign key `user_id` in `users` table) |
| `assignment` | int | the assignment on which the question appears (foreign key `id` in `assignment` table) |
| `question` | int | the number of the question (foreign key `number` in `question` table) |
| `answer` | varchar(256) | the text of the given answer (or the choices selected for multiple-choice questions) |

`student`, `assignment`, and `question` together are a primary key.

### grade

Contains information about the grade a student has received on an assignment.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `student` | int | the student being graded (foreign key `user_id` in `users` table) |
| `assignment` | int | the assignment being graded (foreign key `id` in `assignment` table) |
| `turned_in` | timestamp | the date/time the assignment was submitted |
| `correct` | int | the number of questions answered correctly |
| `grade` | int | the final grade on the assignment |

`student` and `assignment` together are a primary key.
`grade` and `correct` can be null, for assignments that have been submitted but not graded.

### message

Contains information about a notification sent to a user.

| Field | Type | Description |
| --------- | -------- | ----------- |
| `id` | int | primary key |
| `user` | int | the user to whom this message is being sent (foreign key `user_id` in `users` table) |
| `read` | boolean | indicates whether or not this message has been read |
| `content` | varchar(256) | the contents of the message |

`read` has a default value of 'false'.
