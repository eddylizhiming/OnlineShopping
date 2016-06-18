package service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import dao.ShoppingCarDao;
import dao.UserDaoImpl;

@Service
public class ShoppingCarServiceImpl implements ShoppingCarService{

	//日志记录器
	private static Logger logger = Logger.getLogger(UserDaoImpl.class);
		
	@Autowired
	private ShoppingCarDao shoppingCarDao;
	
	@Transactional
	public boolean addToCar(String userId, String goodId, Integer buyNum) {
		try{
			//如果用户还没有购买该商品
			if (shoppingCarDao.getUserBoughtGood(userId, goodId) == null)
			{
				//直接添加记录
				shoppingCarDao.addToCar(userId, goodId, buyNum);
			}
			else
			{				
				//更新用户已购买该商品的数量
				shoppingCarDao.updateGoodsBoughtNum(userId, goodId, buyNum);
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

}
