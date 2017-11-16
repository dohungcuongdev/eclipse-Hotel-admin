package dao;

import org.springframework.stereotype.Repository;

@Repository
public class TestDAOImpl implements TestDAO {

	@Override
	public String getName() {
		return "ban Cuong";
		
	}

}
