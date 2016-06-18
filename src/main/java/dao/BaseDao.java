package dao;

import java.util.List;

public interface BaseDao {
	
	 <T> T oneOrNull(List<T> list);

}
