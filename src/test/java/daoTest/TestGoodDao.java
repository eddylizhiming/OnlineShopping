package daoTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import dao.GoodDao;
import domain.Good;
import junit.framework.Assert;
import service.UserService;

import static junit.framework.Assert.*;

@Transactional
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/daoContext.xml"}) 
public class TestGoodDao {

	@Autowired
	private GoodDao goodDao;
	@Test
	public void testPagedGoods()
	{
		assertEquals(goodDao.getPagedGoodsByType(1, 4, 1).getResult().size(), 3);
	}
	
	@Test
	public void searchGoodsByCondition()
	{
		for (Good good : goodDao.searchGoodsByCondition(1, "2", 1).getResult())
		{
			System.out.println(good.getGoodName());
		}
		assertEquals(3, goodDao.searchGoodsByCondition(1, "2", 1).getResult().size());
	}
	
	@Test
	public void testFindGoodById()
	{
		assertEquals("周黑鸭",goodDao.findGoodById("44").getGoodName());
	}
	
	@Test
	public void updateGoodInfo()
	{
		Good good = new Good();
		good.setGoodId("525");
		good.setGoodName("奥尔良鸡腿堡");
		good.setGoodType("2");
		good.setAmount(10);
		good.setPictureSrc("aoErLiang.jpg");
		Assert.assertTrue(  goodDao.updateGoodInfo(good) == 1);
	}
	
	@Test
	public void testInsertGood()
	{
		Good good = new Good();
		good.setGoodId("55");
		good.setGoodName("奥尔良鸡腿堡");
		good.setGoodType("2");
		good.setAmount(10);
		good.setPictureSrc("aoErLiang.jpg");
		Assert.assertTrue(  goodDao.insertGood(good) == 1);
	}
}
