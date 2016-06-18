package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GoodTypeDao;
import domain.GoodType;

@Service
public class GoodTypeServiceImpl implements GoodTypeService {

	@Autowired
	private GoodTypeDao goodTypeDao;
	public List<GoodType> getAllTypes() {
		
		return goodTypeDao.getAllTypes();
	}

}
