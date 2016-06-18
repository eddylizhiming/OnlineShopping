package domain;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
public class ShoppingCar implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String goodId;
	private int amount;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGoodId() {
		return goodId;
	}
	public void setGoodId(String goodId) {
		this.goodId = goodId;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}