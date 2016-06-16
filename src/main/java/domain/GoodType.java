package domain;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component
public class GoodType implements Serializable{

	private static final long serialVersionUID = 1L;
	private int typeId;
	private String typeName;
	
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
}
