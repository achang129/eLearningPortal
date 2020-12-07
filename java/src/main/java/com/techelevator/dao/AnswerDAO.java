package com.techelevator.dao;

import java.util.List;

import com.techelevator.model.Answer;

public interface AnswerDAO {
	
	Answer getAnswerByStudent(int studentID);
	List<Answer> getAnswersByClass(int classID);
	boolean createAnswer(Answer answer);
	
}
