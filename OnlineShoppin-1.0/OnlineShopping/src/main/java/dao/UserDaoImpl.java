package dao;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import static cons.ConDataBase.*;
import domain.User;

@Repository
public class UserDaoImpl implements UserDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	public User findUserByUserId(String userId) {
		String sql = SELECT_USER_SQL + " WHERE userId = ?";
		Object args[] = {userId};
		return oneOrNull(jdbcTemplate.query(sql, args, new BeanPropertyRowMapper(User.class)));
	}


	private <T> T oneOrNull(List<T> list) {
		if (list == null || list.size() == 0) {
			return null;
		} else {	
			return list.get(0);
		}
	}
}
