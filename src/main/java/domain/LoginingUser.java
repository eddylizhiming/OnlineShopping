package domain;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

public class LoginingUser implements Serializable{

	private static final long serialVersionUID = -6269209046186068618L;

	@Pattern(regexp = "\\w{6,30}")
	private String userId;
	@Pattern(regexp = "\\S{6,30}")
	private String password;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}


}
