package chia

import org.joda.time.DateTime

class MeasureError {
	String reference
	String errorData
	DateTime found = new DateTime()
	DateTime fixed
	Boolean disregard
	Long measureId
	
	static constraints = {
		reference blank:false
		measureId blank:false
	}
}
