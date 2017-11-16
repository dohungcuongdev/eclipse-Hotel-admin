/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import service.TestService;


/**
 *
 * @author Do Hung Cuong
 */
@Controller
@RequestMapping(value = "/")
public class MainController {

	@Autowired
	private TestService testService;

	// index
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.put("test", testService.getName());
		return "index";
	}

}
