package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.TestDAO;

@Service
public class TestServiceImpl implements TestService {
	
	@Autowired
	private TestDAO testDAO;
	
	@Override
	public String getName() {
		return testDAO.getName();
	}

}
