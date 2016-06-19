package service;

public interface ShoppingCarService {
	
	/***
	 * 将用户选择的商品添加到购物车
	 * @param buyNum 新增或购买的数量
	 * @return 添加成功返回true
	 */
	public boolean addToCar(String userId, String goodId, Integer buyNum);
	/***
	 * 从购物车中删除购买的商品
	 * @param userId
	 * @param goodId
	 * @return 移除成功返回true，否则返回false
	 */
	public boolean removeGoodFromCar(String userId, String goodId);
	/**
	 * 修改购物车中商品的数量
	 * @param userId
	 * @param goodId 商品的Id
	 * @param buyNum
	 * @return 修改成功返回true
	 */
	public boolean addGoodsBoughtNum(String userId, String goodId, int buyNum);
	/**
	 * 修改用户已购买某商品的数量
	 * @param userId
	 * @param goodId
	 * @param buyNum
	 * @return
	 */
	public boolean alterGoodsBoughtNum(String userId, String goodId, int buyNum);
	
}
