package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.techelevator.model.Message;

public class MessageSqlDAO implements MessageDAO {
	
	private JdbcTemplate jdbc = new JdbcTemplate();
	
	

	@Override
	public boolean send(int user, String content) {
		String sql = "INSERT INTO message (user_id, read, content) " +
					 "VALUES (?, 0, ?)";
		
		int worked = jdbc.update(sql, user, content);
		
		if(worked > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public List<Message> getList(int user) {
		List<Message> results = new ArrayList<Message>();
		String sql = "SELECT * FROM message WHERE user = ?";
		
		SqlRowSet rowSet = this.jdbc.queryForRowSet(sql, user);
		
		while(rowSet.next()) {
			results.add(mapToMessage(rowSet));
		}
		
		
		return results;
	}

	@Override
	public boolean isRead(int id) {
		boolean result = false;
		String sql = "SELECT read FROM message WHERE id = ?";
		
		SqlRowSet rowSet = jdbc.queryForRowSet(sql, id);
		result = rowSet.getBoolean("id");
		
		return result;
	}

	@Override
	public boolean markRead(int id) {
		String sql = "UPDATE message (read = 1) WHERE id = ?";
		
		int worked = jdbc.update(sql, id);
		
		if(worked > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean delete(int id) {
		String sql = "DELETE * FROM message WHERE id = ?";
		
		int worked = jdbc.update(sql, id);
		
		if(worked > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	private Message mapToMessage(SqlRowSet rowSet) {
		Message result = new Message();
		
		result.setMessageID(rowSet.getInt("id"));
		result.setUserID(rowSet.getInt("user_id"));
		result.setRead(rowSet.getBoolean("read"));
		result.setContent(rowSet.getString("content"));
		
		return result;
	}

}
