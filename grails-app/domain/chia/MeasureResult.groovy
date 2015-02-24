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
		measure nullable:false
		found nullable:false 
		fixed nullable:true 
    }
}
