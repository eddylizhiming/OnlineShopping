package dao;

import org.springframework.mail.SimpleMailMessage;

import domain.User;

public interface UserDao {
	
	User findUserByUserId(String userId);
	int insertUser(User user);
	int updateUserInfo(User user);
	SimpleMailMessage sendVerifyEmail(String receiveAddress, String emailCaptcha);
}
