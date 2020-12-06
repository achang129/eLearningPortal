BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS curriculum;
DROP TABLE IF EXISTS assignment;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS mcchoice;
DROP TABLE IF EXISTS answer;
DROP TABLE IF EXISTS grade;
DROP TABLE IF EXISTS message;
DROP SEQUENCE IF EXISTS seq_user_id;
DROP SEQUENCE IF EXISTS seq_course_id;
DROP SEQUENCE IF EXISTS seq_assignment_id;
DROP SEQUENCE IF EXISTS seq_message_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_course_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_assignment_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_message_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

CREATE TABLE teacher (
	teacher int NOT NULL,
	course int NOT NULL,
	CONSTRAINT PK_teacher PRIMARY KEY (teacher, course),
	CONSTRAINT FK_teacher_teacher FOREIGN KEY (teacher) REFERENCES users(user_id),
	CONSTRAINT FK_teacher_course  FOREIGN KEY (course)  REFERENCES course(id)
);

CREATE TABLE student (
	student int NOT NULL,
	course int NOT NULL,
	CONSTRAINT PK_student PRIMARY KEY (student, course),
	CONSTRAINT FK_student_student FOREIGN KEY (student) REFERENCES users(user_id),
	CONSTRAINT FK_student_course  FOREIGN KEY (course)  REFERENCES course(id)
);

CREATE TABLE course (
	id int DEFAULT nextval('seq_course_id'::regclass) NOT NULL,
	name varchar(64) NOT NULL,
	description varchar(256) NOT NULL,
	difficulty varchar(32) NOT NULL,
	cost int DEFAULT 0 NOT NULL,
	CONSTRAINT PK_course PRIMARY KEY (id)
);

CREATE TABLE curriculum (
	course int NOT NULL,
	date date NOT NULL,
	lesson text NOT NULL,
	homework int,
	CONSTRAINT PK_curriculum PRIMARY KEY (course, date),
	CONSTRAINT FK_curriculum_course FOREIGN KEY (course) REFERENCES course(id)
);

CREATE TABLE assignment (
	id int DEFAULT nextval('seq_assignment_id'::regclass) NOT NULL,
	due_date date,
	questions int NOT NULL,
	CONSTRAINT PK_assignment PRIMARY KEY (id)
);

CREATE TABLE question (
	assignment int NOT NULL,
	number int NOT NULL,
	type varchar(4) NOT NULL,
	statement varchar(256) NOT NULL,
	CONSTRAINT PK_question PRIMARY KEY (assignment, number),
	CONSTRAINT FK_question_assignment FOREIGN KEY (assignment) REFERENCES assignment(id)
);

CREATE TABLE mcchoice (
	assignment int NOT NULL,
	question int NOT NULL,
	choice int NOT NULL,
	answer varchar(256) NOT NULL,
	correct boolean NOT NULL,
	CONSTRAINT PK_mcchoice PRIMARY KEY (assignment, question, choice),
	CONSTRAINT FK_mcchoice_assignment FOREIGN KEY (assignment) REFERENCES assignment(id),
	CONSTRAINT FK_mcchoice_question FOREIGN KEY (question) REFERENCES question(number)
);

CREATE TABLE answer (
	student int NOT NULL,
	assignment int NOT NULL,
	question int NOT NULL,
	answer varchar(256) NOT NULL,
	CONSTRAINT PK_answer PRIMARY KEY (student, assignment, question),
	CONSTRAINT FK_answer_student FOREIGN KEY (student) REFERENCES users(user_id),
	CONSTRAINT FK_answer_assignment FOREIGN KEY (assignment) REFERENCES assignment(id),
	CONSTRAINT FK_answer_question FOREIGN KEY (question) REFERENCES question(number)
);

CREATE TABLE grade (
	student int NOT NULL,
	assignment int NOT NULL,
	turned_in timestamp NOT NULL,
	correct int,
	grade int,
	CONSTRAINT PK_grade PRIMARY KEY (student, assignment),
	CONSTRAINT FK_grade_student FOREIGN KEY (student) REFERENCES users(user_id),
	CONSTRAINT FK_grade_assignment FOREIGN KEY (assignment) REFERENCES assignment(id),
);

CREATE TABLE message (
	id int DEFAULT nextval('seq_message_id'::regclass) NOT NULL,
	user int NOT NULL,
	read boolean NOT NULL,
	content varchar(256) NOT NULL,
	CONSTRAINT PK_message PRIMARY KEY (id),
	CONSTRAINT FK_message_user FOREIGN KEY (user) REFERENCES users(user_id)
);

COMMIT TRANSACTION;
