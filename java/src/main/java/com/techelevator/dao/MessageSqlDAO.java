package com.techelevator.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.model.Message;

@Component
public class MessageSqlDAO implements MessageDAO {
	
	private JdbcTemplate jdbc;
	
	public MessageSqlDAO(JdbcTemplate jdbc) {
		this.jdbc = jdbc;
	}

	@Override
	public boolean send(int user, String content) {
		String sql = "INSERT INTO message (user_id, content) VALUES (?, ?)";
		return jdbc.update(sql, user, content) == 1;
	}

	@Override
	public Message[] getList(int user) {
		List<Message> tempResults = new ArrayList<Message>();
		String sql = "SELECT * FROM message WHERE user_id = ?";
		SqlRowSet rowSet = this.jdbc.queryForRowSet(sql, user);
		while(rowSet.next()) {
			tempResults.add(mapToMessage(rowSet));
		}
		return tempResults.toArray(new Message[0]);
	}

	@Override
	public boolean isRead(int id) {
		String sql = "SELECT read FROM message WHERE id = ?";
		return jdbc.queryForObject(sql, Boolean.class, id);
	}

	@Override
	public boolean markRead(int id) {
		String sql = "UPDATE message (read = 1) WHERE id = ?";
		return jdbc.update(sql, id) == 1;
	}

	@Override
	public boolean delete(int id) {
		String sql = "DELETE * FROM message WHERE id = ?";
		return jdbc.update(sql, id) == 1;
	}
	
	private Message mapToMessage(SqlRowSet rowSet) {
		Message result = new Message();
		
		result.setId(rowSet.getInt("id"));
		result.setUser(rowSet.getInt("user_id"));
		result.setIsRead(rowSet.getBoolean("read"));
		result.setContent(rowSet.getString("content"));
		
		return result;
	}

}
