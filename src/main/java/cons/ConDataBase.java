package cons;

public class ConDataBase {
	
//	public static String IS_USER_EXIST_SQL = "SELECT count(*) FROM tb_users ";
	public final static String SELECT_USER_SQL = "SELECT userId, userName, password, authority, balance, email, headScul FROM tb_users ";
	public final static String INSERT_USER_SQL = "INSERT INTO tb_users (userId, userName, password, balance, email, headScul) ";
	public final static String UPDATE_USER_SQL = "UPDATE tb_users SET userName = ?,"
		 	+ " password = ?, authority = ?, balance = ?, email = ?, headScul = ? ";

	
	public final static String SELECT_GOOD_BY_ID_SQL = "SELECT goodId, goodName, goodType, pictureSrc, unitPrice, amount"
			+ " FROM tb_goods WHERE goodId = ? ";
	
	
	public final static String SELECT_ALLGOODTYPES_SQL = "SELECT typeId, typeName FROM tb_goodTypes WHERE 1 ";
	public final static String SELECT_GOODS_COUNT_BYTYPE_SQL = "SELECT count(*) FROM tb_goods WHERE goodType = ? ";
	public final static String SELECT_PAGEGOODS_BYTYPE_SQL = "SELECT goodId, goodName, goodType, pictureSrc, unitPrice, amount"
			+ " FROM tb_goods as goods , tb_goodTypes as types "
			+ "WHERE goods.goodType = types.typeId AND types.typeId = ?"
			+ " LIMIT ?, ?";
			
/*	public final static String SELECT_SEARCH_GOODS_BY_CONDITION_SQL = "SELECT goodId, goodName, goodType, pictureSrc, amount"
			+ " FROM tb_goods as goods "
			+ " WHERE goodType = ?  AND (goodId like %? % OR goodName like %? %) "
			+ " LIMIT ?, ?";*/

	public final static String INSERT_SHOPPING_CAR_SQL = "INSERT INTO tb_shoppingCar (userId, goodId, amount) "
			+ " VALUES (:userId, :goodId, :amount) ";
	public final static String SELECT_USER_HAS_BUY_GOOD_SQL = " SELECT userId, goodId, amount FROM tb_shoppingCar "
			+ " WHERE userId = ? AND goodId = ? ";
	public final static String UPDATE_USER_BOUGHT_GOODSNUM_SQL = " UPDATE tb_shoppingCar SET amount = amount + ? "
			+ " WHERE userId = ? AND goodId = ? ";
}
