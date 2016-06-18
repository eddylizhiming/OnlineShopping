package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GoodDao;
import domain.Good;
import tool.Page;

@Service
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

}
