package domain;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
//实现序列化接口
public class Good implements Serializable{

	private static final long serialVersionUID = -7919614453002034958L;
	private String goodId;
	private String goodName;
	private String goodType;
	private String pictureSrc;
	private int amount;
	
	public String getGoodId() {
		return goodId;
	}
	public void setGoodId(String goodId) {
		this.goodId = goodId;
	}
	public String getGoodName() {
		return goodName;
	}
	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}
	public String getGoodType() {
		return goodType;
	}
	public void setGoodType(String goodType) {
		this.goodType = goodType;
	}
	public String getPictureSrc() {
		return pictureSrc;
	}
	public void setPictureSrc(String pictureSrc) {
		this.pictureSrc = pictureSrc;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
}
