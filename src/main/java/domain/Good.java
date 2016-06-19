package domain;

import java.io.Serializable;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Min;

import org.springframework.stereotype.Component;

@Component
//实现序列化接口
public class Good implements Serializable{

	private static final long serialVersionUID = -7919614453002034958L;
	private String goodId;
	private String goodName;
	private String goodType;
	private String pictureSrc;
	@Min(0)
	private int amount;
	@DecimalMin(value="0.1")
	private double unitPrice;
	
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
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	@Override
	public String toString() {
		return "Good [goodId=" + goodId + ", goodName=" + goodName + ", goodType=" + goodType + ", pictureSrc="
				+ pictureSrc + ", amount=" + amount + ", unitPrice=" + unitPrice + "]";
	}
	
	
}
