package service;

public interface ShoppingCarService {
	
	/***
	 * 将用户选择的商品添加到购物车
	 * @param buyNum 新增或购买的数量
	 * @return 添加成功返回true
	 */
	public boolean addToCar(String userId, String goodId, Integer buyNum);
}
