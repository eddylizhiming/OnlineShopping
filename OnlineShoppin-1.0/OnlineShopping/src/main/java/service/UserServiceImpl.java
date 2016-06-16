package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import domain.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	public boolean isUserExist(String userId, String password) {
		
		User user = userDao.findUserByUserId(userId);
		return user != null && user.getPassword().equals(password);
	}

}
