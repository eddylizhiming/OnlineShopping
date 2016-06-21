package dao;

import java.util.List;

public class BaseDaoImpl implements BaseDao{

	/**
	 * 判断是否有匹配条件的返回值，若有返回一个实例，若没有Null
	 * @param list 使用query查询出来的列表
	 */
	public <T> T oneOrNull(List<T> list) {
		if (list == null || list.size() == 0) {
			return null;
		} else {	
			return list.get(0);
		}
	}

}
