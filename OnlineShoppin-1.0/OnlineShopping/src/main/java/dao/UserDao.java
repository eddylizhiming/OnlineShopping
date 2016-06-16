package dao;

import domain.User;

public interface UserDao {
	
	User findUserByUserId(String userId);

}
