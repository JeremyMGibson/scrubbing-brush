package chia

import org.joda.time.DateTime;

class MeasureResult {
	String reference
	String errorData
	MeasureRun found
	MeasureRun fixed
	Boolean disregard
	Measure measure

	    static constraints = {
		measure blank:false
		found blank:false 
		fixed blank:true 
    }
}
