package chia

import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional;


@Secured(['ROLE_ADMIN'])
class UserController {
	static scaffold = true
}
 