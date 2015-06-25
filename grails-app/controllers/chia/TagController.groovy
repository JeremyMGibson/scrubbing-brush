package chia

import javax.swing.SpringLayout.Constraints;

import grails.plugin.springsecurity.annotation.Secured;

@Secured(["ROLE_ADMIN"])
class TagController {
	static scaffold = true  
}
