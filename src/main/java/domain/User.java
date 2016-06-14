package domain;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.springframework.stereotype.Component;

@Component
public class User implements Serializable{

	/**
	 * 生成的版本UID
	 */
	private static final long serialVersionUID = -5334980797651496255L;
	
	@Pattern(regexp = "\\w{6,30}")
	private String userId;
	private String userName;
	@Pattern(regexp = "\\S{6,30}")
	private String password;
	private double balance;
	//默认为普通用户
	private String authority = "ordinary";
	@Email
	private String email;
	private String headScul;
	
	public User() {
		//email初始化为空
		this.email = "";
	}
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHeadScul() {
		return headScul;
	}
	public void setHeadScul(String headScul) {
		this.headScul = headScul;
	}

}
