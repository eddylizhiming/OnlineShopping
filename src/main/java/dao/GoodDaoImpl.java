package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import static cons.ConDataBase.*;
import domain.Good;
import tool.Page;

@Repository
public class GoodDaoImpl implements GoodDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Page<Good> getPagedGoodsByType(int pageNo, int pageSize, int typeId) {
		//获取该类型下的商品总数
		long totalCount = jdbcTemplate.queryForLong(SELECT_GOODS_COUNT_SQL, new Object[]{typeId});
		
		if(totalCount <= 0){
			return new Page<Good>();
		}
		
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		//将商品类型的编号作为参数插入SQL
		List<Good> data = jdbcTemplate.query(SELECT_PAGEGOODS_BYTYPE_SQL, 
				new Object[]{typeId, startIndex, pageSize}, new BeanPropertyRowMapper<Good>(Good.class));

		return new Page<Good>(startIndex, totalCount, pageSize, data);
	}

}
