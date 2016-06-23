package service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import dao.ShoppingCarDao;
import dao.UserDaoImpl;
import domain.Good;
import domain.ShoppingCar;

@Service("shoppingCarService")
public class ShoppingCarServiceImpl implements ShoppingCarService{

	//日志记录器
	private static Logger logger = Logger.getLogger(UserDaoImpl.class);
	
	@Autowired
	private GoodService goodService;
	@Autowired
	private ShoppingCarDao shoppingCarDao;
	
	@Transactional
	public boolean addToCar(String userId, String goodId, Integer buyNum) {
		//如果用户购买的商品数量大于库存
		if (goodService.findGoodById(goodId).getAmount() < buyNum){
			return false;
		}
		try{
			//如果用户还没有购买该商品
			if (shoppingCarDao.getUserBoughtGood(userId, goodId) == null){
				//直接添加记录
				shoppingCarDao.addToCar(userId, goodId, buyNum);
			}
			else{				
				//更新用户已购买该商品的数量
				shoppingCarDao.addGoodsBoughtNum(userId, goodId, buyNum);
			}
		}
		catch(Exception exception)
		{
			logger.error(userId + "的用户,商品Id"+ goodId + "，添加到购物车失败");
			logger.error(exception.getMessage());
			return false;
		}
		return true;
	}

	public boolean removeGoodFromCar(String userId, String goodId) {
		//如果用户没有买商品，就直接return
		if(shoppingCarDao.getUserBoughtGood(userId, goodId) == null)
			return false;
		return shoppingCarDao.removeGoodFromCar(userId, goodId) > 0;
	}

	public boolean addGoodsBoughtNum(String userId, String goodId, int buyNum) {
		if(shoppingCarDao.getUserBoughtGood(userId, goodId) == null) return false;
		
		return shoppingCarDao.addGoodsBoughtNum(userId, goodId, buyNum) > 0;
	}

	public boolean alterGoodsBoughtNum(String userId, String goodId, int buyNum) {
		if(shoppingCarDao.getUserBoughtGood(userId, goodId) == null) return false;
		return shoppingCarDao.alterGoodsBoughtNum(userId, goodId, buyNum) > 0;
	}

	public List<ShoppingCar> getUserShoppingCar(String userId) {
		// TODO Auto-generated method stub
		return shoppingCarDao.getUserShoppingCar(userId);
	}

}
