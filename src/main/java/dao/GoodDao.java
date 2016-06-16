package dao;

import domain.Good;
import tool.Page;

public interface GoodDao {

	public Page<Good> getPagedGoodsByType(int pageNo, int pageSize, int typeId);
}
