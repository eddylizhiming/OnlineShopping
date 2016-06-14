package cons;

public class ConDataBase {

//	public static String IS_USER_EXIST_SQL = "SELECT count(*) FROM tb_users ";
	public static String SELECT_USER_SQL = "SELECT userId, userName, password, balance, email FROM tb_users ";
	public static String INSERT_USER_SQL = "INSERT INTO tb_users (userId, userName, password, balance, email) ";
	public static String UPDATE_USER_SQL = "UPDATE tb_users SET userName = ?,"
			+ " password = ?, authority = ?, balance = ?, email=? ";
}
