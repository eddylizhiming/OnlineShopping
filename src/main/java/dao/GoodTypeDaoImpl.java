package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import static cons.ConDataBase.*;
import domain.GoodType;

@Repository
public class GoodTypeDaoImpl implements GoodTypeDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<GoodType> getAllTypes() {
		
		String sqlSelect = SELECT_ALLGOODTYPES_SQL;

		return jdbcTemplate.query(sqlSelect, new BeanPropertyRowMapper<GoodType>(GoodType.class));
	}

}
