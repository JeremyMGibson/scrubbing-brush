package chia

import grails.plugin.springsecurity.annotation.Secured;

@Secured(['ROLE_EDITOR'])
class MeasureController {
	static scaffold = true
}
