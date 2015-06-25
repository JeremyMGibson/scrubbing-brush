package chia

import grails.converters.JSON

class MeasureResult {
	String reference
	String errorData
	MeasureRun found
	MeasureRun fixed
	Boolean disregard
	Measure measure

	static mapping = {
		errorData type:"text"
	}
	
	static constraints = {
		measure blank:false
		found blank:false
		fixed nullable:true
	}
	
	def getData() {
		return JSON.parse(errorData)
	}
}
