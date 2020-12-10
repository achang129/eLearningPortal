package com.techelevator.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.techelevator.model.User;

@Service
public class UserSqlDAO implements UserDAO {

    private JdbcTemplate jdbcTemplate;

    public UserSqlDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public int findIdByUsername(String username) {
        return jdbcTemplate.queryForObject("select user_id from users where username = ?", int.class, username);
    }

	@Override
	public User getUserById(Long userId) {
		String sql = "SELECT * FROM users WHERE user_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, userId);
		if(results.next()) {
			return mapRowToUser(results);
		} else {
			throw new RuntimeException("userId "+userId+" was not found.");
		}
	}

    @Override
    public User[] findAll() {
        List<User> users = new ArrayList<>();
        String sql = "select * from users";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
        while(results.next()) {
            User user = mapRowToUser(results);
            users.add(user);
        }

        return users.toArray(new User[0]);
    }

    @Override
    public User findByUsername(String username) throws UsernameNotFoundException {
        for (User user : this.findAll()) {
            if( user.getUsername().toLowerCase().equals(username.toLowerCase())) {
                return user;
            }
        }
        throw new UsernameNotFoundException("User " + username + " was not found.");
    }

    @Override
    public boolean create(String username, String password, String role) {
        boolean userCreated = false;

        // create user
        String insertUser = "insert into users (username,password_hash,role) values(?,?,?)";
        String password_hash = new BCryptPasswordEncoder().encode(password);
        String ssRole = "ROLE_" + role.toUpperCase();

        GeneratedKeyHolder keyHolder = new GeneratedKeyHolder();
        String id_column = "user_id";
        userCreated = jdbcTemplate.update(con -> {
                    PreparedStatement ps = con.prepareStatement(insertUser, new String[]{id_column});
                    ps.setString(1, username);
                    ps.setString(2, password_hash);
                    ps.setString(3, ssRole);
                    return ps;
                }
                , keyHolder) == 1;
        //int newUserId = (int) keyHolder.getKeys().get(id_column);

        return userCreated;
    }
    
    
    @Override
	public User[] findAllTeachers() {//this select statement may need tweaking
		List<User> results = new ArrayList<User>();
		String sql = "SELECT * FROM users WHERE role = 'Teacher'";
		
		SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);
		
		while(rowSet.next()) {
			results.add(mapRowToUser(rowSet));
		}

        return results.toArray(new User[0]);
	}

	@Override
	public User[] findAllStudents() {
		List<User> results = new ArrayList<User>();
		String sql = "SELECT * FROM users WHERE role = 'Students'";
		
		SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);
		
		while(rowSet.next()) {
			results.add(mapRowToUser(rowSet));
		}

        return results.toArray(new User[0]);
	}

	@Override
	public String getRoleByUsername(String username) {
		String result = "";
		String sql = "SELECT role FROM users WHERE username = ?";
		
		SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, username);
		
		if(rowSet.next()) {
			result = rowSet.getString("role");
		}
		
		return result;
	}

	@Override
	public String getRoleById(Long userId) {
		String result = "";
		String sql = "SELECT role FROM users WHERE user_id = ?";
		
		SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userId);
		
		if(rowSet.next()) {
			result = rowSet.getString("role");
		}
		
		return result;
	}
    
    
    private User mapRowToUser(SqlRowSet rs) {
        User user = new User();
        user.setId(rs.getLong("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password_hash"));
        user.setAuthorities(rs.getString("role"));
        user.setActivated(true);
        return user;
    }

	
}
