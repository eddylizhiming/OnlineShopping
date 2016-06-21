package domain;

import java.io.Serializable;
import org.joda.time.DateTime;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Component;

@Component
public class Order implements Serializable{

	private static final long serialVersionUID = 1L;

	private String orderId;
	private String userId;
	private String goodIds;
	private String amounts;
	private double total;
	@DateTimeFormat(iso=ISO.DATE_TIME)
	private DateTime generateTime;
	private String status;
	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGoodIds() {
		return goodIds;
	}
	public void setGoodIds(String goodIds) {
		this.goodIds = goodIds;
	}
	public String getAmounts() {
		return amounts;
	}
	public void setAmounts(String amounts) {
		this.amounts = amounts;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public DateTime getGenerateTime() {
		return generateTime;
	}
	public void setGenerateTime(DateTime generateTime) {
		this.generateTime = generateTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
