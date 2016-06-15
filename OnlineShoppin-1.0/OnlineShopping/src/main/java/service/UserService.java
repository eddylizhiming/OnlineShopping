package service;

import domain.LoginingUser;

public interface UserService {

	/***
	 * 测试用户是否存在，存在返回True，不存在返回False
	 * @param userId 要进行判断的用户名
	 * @param password 要进行判断的密码
	 */
	boolean isUserExist(String userId, String password);
}
