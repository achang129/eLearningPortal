BEGIN TRANSACTION;

DELETE FROM  mcchoice;
DELETE FROM  grade;
DELETE FROM  message;
DELETE FROM  question;
DELETE FROM  curriculum;
DELETE FROM  teacher;
DELETE FROM  student;
DELETE FROM  answer;
DELETE FROM  assignment;
DELETE FROM  course;
DELETE FROM  users;



COMMIT TRANSACTION;