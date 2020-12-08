# Object Model

This document describes the object model for the application.
It compiles information for both the front- and back-end models.

Note: The in-memory object model is different from the one used in the database;
It doesn't make use of bridge tables of course, and collections are used where appropriate.

### User

Stores information about a user of the portal.

| Field | Type | Description | Restrictions |
| --------- | -------- | ----------- | ---------- |
| `id` | int | unique identifier for each user | greater than 0 |
| `username` | String | name of user | not null or empty |
| `password` | String | password used to log user in | not null or empty |
| `role` | String | the role the user has within the system | either 'student', 'teacher', or 'admin' |

### Course

Stores information about a particular course.

| Field | Type | Description | Restrictions |
| --------- | -------- | ----------- | ---------- |
| `id` | int | unique identifier for each course | greater than 0 |
| `name` | String | name of the course | not null or empty |
| `description` | String | description of the course | not null |
| `difficulty` | String | difficulty level of the course | not null, allowed values TBD |
| `curriculum` | Map(Date, Curriculum) | the daily curriculum of the course | not null |

### Curriculum

Stores information about the curriculum of a course on a particular day.

| Field | Type | Description | Restrictions |
| --------- | -------- | ----------- | ---------- |
| `lesson` | String | text description of the day's lesson plan | not null |
| `homework` | int | ID of the homework assignment (if any) on that day | none |

A null value for `homework` is used when there is no homework assignment on a particular day.

### Assignment

Stores information about a particular homework assignment.

| Field | Type | Description | Restrictions |
| --------- | -------- | ----------- | ---------- |
| `id` | int | unique identifier for each course | greater than 0 |
| `dueDate` | Date | date on which the assignment is due | none |
| `question` | List<Question> | list of questions on the assignment | not null |

A null value for `dueDate` is used when the assignment does not have a set date.

### Question

Stores information about a particular homework question (WORK IN PROGRESS).

| Field | Type | Description | Restrictions |
| --------- | -------- | ----------- | ---------- |
| text | String | the text displayed as the question statement | not null |
| type | String | the type of question | must be 'mc', 'mmc', or 'text' |
| answers | List<String> | the list of choices for multiple-choice questions | none |
| correct | String | the correct answer to the question | not null |

'mc' is used for multiple-choice questions with a single answer, 'mmc' for those with multiple answers, and 'text' for short-answer questions.
`correct` contains the text of the correct answer for 'text' questions and the list of correct answers separated by commas for multiple-choice questions.


#Still Needed

The following objects need either more testing of the existing project or more input from Justin before being designed:

### Grade

Stores information about a particular student's grade on an assignment.

### CourseGrade?

Stores information about a particular student's overall grade in a course?
