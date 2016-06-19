package dao;

import static cons.ConDataBase.*;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import domain.Good;
import tool.Page;

@Repository
public class GoodDaoImpl implements GoodDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	public Page<Good> getPagedGoodsByType(int pageNo, int pageSize, int typeId) {
		//获取该类型下的商品总数
		long totalCount = jdbcTemplate.queryForLong(SELECT_GOODS_COUNT_BYTYPE_SQL, new Object[]{typeId});
		
		if(totalCount <= 0){
			return new Page<Good>();
		}
		
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		//将商品类型的编号作为参数插入SQL
		List<Good> data = jdbcTemplate.query(SELECT_PAGEGOODS_BYTYPE_SQL, 
				new Object[]{typeId, startIndex, pageSize}, new BeanPropertyRowMapper<Good>(Good.class));

		return new Page<Good>(startIndex, totalCount, pageSize, data);
	}
	
	private <T> T oneOrNull(List<T> list) {
		if (list == null || list.size() == 0) {
			return null;
		} else {	
			return list.get(0);
		}
	}

	public Page<Good> searchGoodsByCondition(int typeId, String goodCondition, int pageNo) {
		//条件搜索的商品总数，貌似解决不了占位符并条件搜索的问题。。
		String select_search_goods_sql = "SELECT goodId, goodName, goodType, pictureSrc, unitPrice, amount  FROM tb_goods ";
		select_search_goods_sql += " WHERE goodType = ? ";
		select_search_goods_sql += " AND (goodId like '%"+ goodCondition +"%' ";
		select_search_goods_sql += " OR goodName like '%" + goodCondition + "%') ";
		
		String select_search_goods_count_sql =  "SELECT count(*) FROM tb_goods";
		select_search_goods_count_sql += " WHERE goodType = ? ";
		select_search_goods_count_sql += " AND (goodId like '%"+ goodCondition +"%' ";
		select_search_goods_count_sql += " OR goodName like '%" + goodCondition + "%') ";
		
		long totalCount = 0L;
		//获取该条件下的商品总数，先测试有无商品，不然执行queryForLong会抛出异常。。
		if ( jdbcTemplate.query(select_search_goods_sql, new Object[]{typeId} , new BeanPropertyRowMapper<Good>(Good.class)).size() != 0)
		{
			totalCount = jdbcTemplate.queryForLong(select_search_goods_count_sql, new Object[]{typeId} );
		}
		else
			return new Page<Good>();

		//搜索的结果从第一页展示，采用默认大小
		int startIndex = Page.getStartOfPage(pageNo, Page.DEFAULT_PAGE_SIZE);
		
		select_search_goods_sql += " LIMIT ?, ?";
		//limit从0开始
		List<Good> data = jdbcTemplate.query(select_search_goods_sql, 
				new Object[]{typeId, startIndex, Page.DEFAULT_PAGE_SIZE}, new BeanPropertyRowMapper<Good>(Good.class));

		return new Page<Good>(startIndex, totalCount, Page.DEFAULT_PAGE_SIZE, data);
	}

	public Good findGoodById(String goodId) {
		String sql = SELECT_GOOD_BY_ID_SQL ;
		Object args[] = { goodId };

		return oneOrNull(jdbcTemplate.query(sql, args, new BeanPropertyRowMapper<Good>(Good.class)));
	}

	public Integer deleteGoodById(String goodId) {
		
		Object args[] = {goodId};
		
		return jdbcTemplate.update(DELETE_GOOD_BY_ID_SQL, args);
	}

	public Integer updateGoodInfo(Good good) {
		SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(good);
		return namedParameterJdbcTemplate.update(UPDATE_GOOD_SQL, sqlParameterSource);
	}

	public Integer insertGood(Good good) {
		SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(good);
		return namedParameterJdbcTemplate.update(INSERT_GOOD_SQL, sqlParameterSource);
	}

}
