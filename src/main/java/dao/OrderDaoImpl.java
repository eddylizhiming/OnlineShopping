package dao;

import static cons.ConDataBase.SELECT_GOODS_COUNT_BYTYPE_SQL;
import static cons.ConDataBase.SELECT_ORDERS_COUNT_SQL;
import static cons.ConDataBase.SELECT_PAGED_ORDERS_SQL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import cons.ConDataBase;
import domain.Order;
import tool.Page;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public Page<Order> getPageOrders(int pageNo, int pageSize) {

		long totalCount = jdbcTemplate.queryForLong(SELECT_ORDERS_COUNT_SQL);
		
		long startIndex = Page.getStartOfPage(pageNo, pageSize);
		//limit从0开始
		final List<Order> data = new ArrayList<Order>();
		//必须使用RowCallbackHandler，否则类型转换不正确。
		jdbcTemplate.query(SELECT_PAGED_ORDERS_SQL, 
				new Object[]{startIndex, pageSize}, new RowCallbackHandler() {
					
					public void processRow(ResultSet rs) throws SQLException {
						//add加进去的是对象的一个引用，对象实例化放在循环外面，
						//你每次都更新了这个引用的值，当然list里面的值都一样的。
						Order order = new Order();
						order.setOrderId(rs.getString("orderId"));
						order.setUserId(rs.getString("userId"));
						order.setGoodIds(rs.getString("goodIds"));
						order.setAmounts(rs.getString("amounts"));
						order.setTotal(rs.getDouble("total"));
						//JDK Date转 JODA
						order.setGenerateTime(new DateTime(rs.getDate("generateTime")));
						order.setStatus(rs.getString("status"));
						data.add(order);			
		
					}
				});

		return new Page<Order>(startIndex, totalCount, pageSize, data);
	}
	//书本P369
	public int[] batchDeleteByIds(final String[] orderIds) {
		return jdbcTemplate.batchUpdate(ConDataBase.DELETE_ORDER_BY_ID, new BatchPreparedStatementSetter() {

			public void setValues(PreparedStatement ps, int i) throws SQLException {
				String orderId = orderIds[i];
				ps.setString(1, orderId);
			}

			public int getBatchSize() {
				return orderIds.length;
			}
		});
	}

	public int[] batchUpdateOrders(final List<Order> orders){
		return jdbcTemplate.batchUpdate(ConDataBase.UPDATE_ORDER_SQL, new BatchPreparedStatementSetter() {

			public void setValues(PreparedStatement ps, int i) throws SQLException {
				ps.setString(1, orders.get(i).getGoodIds());
				ps.setString(2, orders.get(i).getAmounts());
				ps.setDouble(3, orders.get(i).getTotal());
				ps.setString(4, orders.get(i).getStatus());
				ps.setString(5, orders.get(i).getOrderId());
			}

			public int getBatchSize() {
				return orders.size();
			}
		});
	}
	public Page<Order> findOrdersByCondition(Order order, int pageNo, int pageSize) {
		
		long totalCount = jdbcTemplate.queryForLong("SELECT count(*) "
				+ " FROM tb_orders  WHERE orderId like '%"+order.getOrderId()+"%'" + 
				 " AND userId like '%"+order.getUserId()+"%'" + 
				 " AND goodIds like '%"+order.getGoodIds()+"%'" + 
				 " AND amounts like '%"+order.getAmounts()+"%'" + 
				 " AND status like '%"+order.getStatus()+"%'");
		
		if (totalCount <= 0)
			return new Page<Order>();
		String select_orders_by_condition_sql = "SELECT orderId, userId, goodIds, amounts, total, generateTime, status "
				+ " FROM tb_orders  WHERE orderId like '%"+order.getOrderId()+"%'" + 
				 " AND userId like '%"+order.getUserId()+"%'" + 
				 " AND goodIds like '%"+order.getGoodIds()+"%'" + 
				 " AND amounts like '%"+order.getAmounts()+"%'" + 
				 " AND status like '%"+order.getStatus()+"%'" + 
				 " LIMIT ?, ?";
		
		long startIndex = Page.getStartOfPage(pageNo, pageSize);
		Object[] args = {
				//参数是startIndex！！不是pageNo
				startIndex,
				pageSize
		};
		//limit从0开始
		final List<Order> data = new ArrayList<Order>();
		//必须使用RowCallbackHandler，否则类型转换不正确。
		jdbcTemplate.query(select_orders_by_condition_sql, 
				args, new RowCallbackHandler() {

			public void processRow(ResultSet rs) throws SQLException {
				//add加进去的是对象的一个引用，对象实例化放在循环外面，
				//你每次都更新了这个引用的值，当然list里面的值都一样的。
				Order order = new Order();
				order.setOrderId(rs.getString("orderId"));
				order.setUserId(rs.getString("userId"));
				order.setGoodIds(rs.getString("goodIds"));
				order.setAmounts(rs.getString("amounts"));
				order.setTotal(rs.getDouble("total"));
				//JDK Date转 JODA
				order.setGenerateTime(new DateTime(rs.getDate("generateTime")));
				order.setStatus(rs.getString("status"));
				data.add(order);			

			}
		});
		
		return new Page<Order>(startIndex, totalCount, pageSize, data);
	}
}
