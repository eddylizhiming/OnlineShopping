package dao;

import domain.Good;

public interface ShoppingCarDao {

	public Integer addToCar(String userId, String goodId, int buyNum);
	public int addGoodsBoughtNum(String userId, String goodId, int buyNum);
	public int alterGoodsBoughtNum(String userId, String goodId, int buyNum);
	public Good getUserBoughtGood(String userId, String goodId);
	public Integer removeGoodFromCar(String userId, String goodId);
}
