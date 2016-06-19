package dao;

import domain.Good;
import tool.Page;

public interface GoodDao {

	public Page<Good> getPagedGoodsByType(int pageNo, int pageSize, int typeId);
	public Page<Good> searchGoodsByCondition(int typeId, String goodCondition, int pageNo);
	public Good findGoodById(String goodId);
	public Integer deleteGoodById(String goodId);
	public Integer updateGoodInfo(Good good);
	public Integer insertGood(Good good);
}
