package dao;

import static cons.ConDataBase.ADD_USER_BOUGHT_GOODSNUM_SQL;
import static cons.ConDataBase.ALTER_USER_BOUGHT_GOODS_NUM_SQL;
import static cons.ConDataBase.INSERT_SHOPPING_CAR_SQL;
import static cons.ConDataBase.REMOVE_GOOD_FROM_CAR_SQL;
import static cons.ConDataBase.SELECT_USER_HAS_BUY_GOOD_SQL;
import static cons.ConDataBase.SELECT_USER_SHOPPINGCAR_SQL;

import java.util.List;

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


		ShoppingCar shoppingCar = new ShoppingCar();
		shoppingCar.setUserId(userId);
		shoppingCar.setGoodId(goodId);
		shoppingCar.setAmount(buyNum);
		
		SqlParameterSource sqlParameterSource = new BeanPropertySqlParameterSource(shoppingCar);
		return namedParameterJdbcTemplate.update(INSERT_SHOPPING_CAR_SQL, sqlParameterSource);
	}
	
	public Good getUserBoughtGood(String userId, String goodId) {
		Object args[] = {userId, goodId};
		
		return oneOrNull(jdbcTemplate.query(SELECT_USER_HAS_BUY_GOOD_SQL, args, new BeanPropertyRowMapper<Good>(Good.class)));
	}
	
	public int addGoodsBoughtNum(String userId, String goodId, int buyNum){
		Object args[] = {buyNum, userId, goodId};
		
		return jdbcTemplate.update(ADD_USER_BOUGHT_GOODSNUM_SQL, args);
	}

	public Integer removeGoodFromCar(String userId, String goodId) {
		Object args[] = { userId, goodId};
		return jdbcTemplate.update(REMOVE_GOOD_FROM_CAR_SQL, args);
	}

	public int alterGoodsBoughtNum(String userId, String goodId, int buyNum) {
		Object args[] = {buyNum, userId, goodId};
		
		return jdbcTemplate.update(ALTER_USER_BOUGHT_GOODS_NUM_SQL);
	}

	public List<ShoppingCar> getUserShoppingCar(String userId) {
		return jdbcTemplate.query(SELECT_USER_SHOPPINGCAR_SQL, new Object[] {userId}, 
				new BeanPropertyRowMapper<ShoppingCar>(ShoppingCar.class));
	}
}
