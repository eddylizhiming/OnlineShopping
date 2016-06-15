package domain;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
public class User implements Serializable{

	/**
	 * 生成的版本UID
	 */
	private static final long serialVersionUID = -5334980797651496255L;

	private String userId;
	private String userName;
	private String password;
	private double balance;
	private String authority;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}

}
