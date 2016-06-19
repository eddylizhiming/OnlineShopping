package dao;

import org.springframework.mail.SimpleMailMessage;

import domain.User;

public interface UserDao {
	
	User findUserByUserId(String userId);
	Integer insertUser(User user);
	Integer updateUserInfo(User user);
	SimpleMailMessage sendVerifyEmail(String receiveAddress, String emailCaptcha);
}
