package com.techelevator.dao;

import java.util.List;

import com.techelevator.model.Answer;

public interface AnswerDAO {
	
	List<Answer> getAnswersByStudentForHomework(int studentID, int assignment);
	boolean createAnswer(Answer answer);
	
}
