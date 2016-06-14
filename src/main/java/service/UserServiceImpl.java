package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import domain.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	public boolean isUserExist(String userId) {
		
		User user = userDao.findUserByUserId(userId);
		return user != null;
	}
	public boolean insertUser(User user) {
		
		return userDao.insertUser(user) > 0 ? true : false;
	}
	public boolean hasMatchUser(String userId, String password) {
		User user = userDao.findUserByUserId(userId);
		return user != null && user.getPassword().equals(password);
	}
	public boolean sendVerifyEmail(String receiveAddress, String emailCaptcha) {
		
		return userDao.sendVerifyEmail(receiveAddress,  emailCaptcha) != null ? true : false;
	}
	public boolean bindEmail(String userId, String emailAddress) {
		User user = userDao.findUserByUserId(userId);
		if (user == null) return false;
		user.setEmail(emailAddress);
		return this.updateUserInfo(user);
	}
	public boolean updateUserInfo(User user) {
		
		return userDao.updateUserInfo(user) > 0 ?  true : false;
	}
	public User findUserByUserId(String userId) {
		
		return userDao.findUserByUserId(userId);
	}
	public boolean updateHeadscul(String userId, String fileName) {
		
		User user = userDao.findUserByUserId(userId);
		if (user == null) return false;
		user.setHeadScul(fileName);
		return this.updateUserInfo(user);
	}

}
