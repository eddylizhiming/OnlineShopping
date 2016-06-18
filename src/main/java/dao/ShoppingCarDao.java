package dao;

import domain.Good;

public interface ShoppingCarDao {

	public Integer addToCar(String userId, String goodId, int buyNum);
	public int updateGoodsBoughtNum(String userId, String goodId, int buyNum);
	public Good getUserBoughtGood(String userId, String goodId);
}
