package dao;

import static cons.ConDataBase.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import domain.Good;
import domain.ShoppingCar;

@Repository
public class ShoppingCarDaoImpl extends BaseDaoImpl implements ShoppingCarDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
	public Integer addToCar(String userId, String goodId, int buyNum) {

		String sql = INSERT_SHOPPING_CAR_SQL;

		ShoppingCar shoppingCar = new ShoppingCar();
		shoppingCar.setUserId(userId);
		shoppingCar.setGoodId(goodId);
		shoppingCar.setAmount(buyNum);
		
		SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(shoppingCar);
		return namedParameterJdbcTemplate.update(sql, sqlParameterSource);
	}
	
	public Good getUserBoughtGood(String userId, String goodId) {
		String sql = SELECT_USER_HAS_BUY_GOOD_SQL;
		Object args[] = {userId, goodId};
		
		return oneOrNull(jdbcTemplate.query(sql, args, new BeanPropertyRowMapper<Good>(Good.class)));
	}
	
	public int addGoodsBoughtNum(String userId, String goodId, int buyNum){
		String sql = ADD_USER_BOUGHT_GOODSNUM_SQL;
		Object args[] = {buyNum, userId, goodId};
		
		return jdbcTemplate.update(sql, args);
	}

	public Integer removeGoodFromCar(String userId, String goodId) {
		String sql = REMOVE_GOOD_FROM_CAR_SQL;
		Object args[] = { userId, goodId};
		return jdbcTemplate.update(sql, args);
	}

	public int alterGoodsBoughtNum(String userId, String goodId, int buyNum) {
		String sql = ALTER_USER_BOUGHT_GOODS_NUM_SQL;
		Object args[] = {buyNum, userId, goodId};
		
		return jdbcTemplate.update(sql, args);
	}
}
