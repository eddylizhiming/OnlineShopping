package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GoodDao;
import domain.Good;
import tool.Page;

@Service("goodService")
public class GoodServiceImpl implements GoodService{

	@Autowired
	private GoodDao goodDao; 
	
	public Page<Good> getPagedGoodsByType(int pageNo, int pageSize, int typeId) {
		
		return goodDao.getPagedGoodsByType(pageNo, pageSize, typeId);
	}

	public Page<Good> searchGoodsByCondition(int typeId, String goodCondition, int pageNo) {
		return goodDao.searchGoodsByCondition(typeId, goodCondition, pageNo);
	}

	public Good findGoodById(String goodId) {
		return goodDao.findGoodById(goodId);
	}

	public boolean deleteGoodById(String goodId) {
		if (goodDao.findGoodById(goodId) == null) return false;
		return goodDao.deleteGoodById(goodId) > 0;
	}

	public boolean updateGoodInfo(Good good) {
		if (goodDao.findGoodById(good.getGoodId()) == null)
			return false;
		return goodDao.updateGoodInfo(good) > 0;
	}

	public boolean insertGood(Good good) {
		if(goodDao.findGoodById(good.getGoodId()) != null)
			return false;
		return goodDao.insertGood(good) > 0;
	}

}
