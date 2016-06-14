package service;

import domain.LoginingUser;
import domain.User;

public interface UserService {

	/***
	 * 测试用户是否存在，若插入成功返回True，不存在则返回False
	 * @param userId 要进行判断的用户名
	 */
	boolean isUserExist(String userId);
	/***
	 * 插入用户，存在返回1，不存在返回0
	 * @param user 要插入的用户
	 */
	boolean insertUser(User user);
	boolean hasMatchUser(String userId, String password);
	/***
	 * 发送一封关于绑定邮箱的验证码的邮件到用户的邮箱
	 * @param receiveAddress 用户指定的邮箱地址
	 * @param emailCaptcha 要发送的邮件验证码
	 * @return 发送成功返回true，否则返回false
	 */
	boolean sendVerifyEmail(String receiveAddress, String emailCaptcha);
	/**
	 * 绑定用户的邮箱
	 * @param userId 用户的Id
	 * @param emailAddress 用户要进行绑定的邮箱地址
	 * @return 绑定成功返回True，否则返回False
	 */
	boolean bindEmail(String userId, String emailAddress);
	
	/***
	 * 更新用户信息
	 * @param user 要更新的User实例
	 * @return 更新成功返回True
	 */
	boolean updateUserInfo(User user); 
	
}
