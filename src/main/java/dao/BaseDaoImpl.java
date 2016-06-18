package dao;

import java.util.List;

public class BaseDaoImpl implements BaseDao{

	public <T> T oneOrNull(List<T> list) {
		if (list == null || list.size() == 0) {
			return null;
		} else {	
			return list.get(0);
		}
	}

}
