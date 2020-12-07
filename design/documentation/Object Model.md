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
| `curriculum` | Map<date, curriculum> | daily curriculum of the course | not null |

### Curriculum

Stores information about the curriculum of a course on a particular day.

| Field | Type | Description | Restrictions |
| --------- | -------- | ----------- | ---------- |
| 



