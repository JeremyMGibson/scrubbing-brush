package chia

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
		fixed nullable:true
	}
}
