package chia

class Measure {
	enum MeasureType { ERROR, WARNING }
	enum Connection { RESEARCH_MASTER }
	enum Priority { CRITICAL, HIGH, MEDIUM, LOW }
	enum Concern { HIGH, MEDIUM, LOW }
	
	String name
	String description
	Connection connection
	String query
	String correctionScript
	MeasureType type
	Priority priority
	Long threshold
	Long numErrors
	
	def getOutstandingErrors() {
		return MeasureResult.findAllByMeasureAndFixed(this, null)	
	}
	
	def getConcern() {
		if (threshold != null && numErrors != null) {
			if (numErrors/threshold > 1) {
				return Concern.HIGH
			} else if (numErrors/threshold > 0.75) {
				return Concern.MEDIUM
			} else {
				return Concern.LOW
			}			
		}
		return Concern.LOW			
	}
	
	def getOldErrorData() {
		def oldErrorData = []
		runs.each{run ->
			oldErrorData << [run.runNumber, run.oldErrors]
		}
		return oldErrorData
	}
	
	def getNewErrorData() {
		def newErrorData = []
		runs.each{run ->
			newErrorData << [run.runNumber, run.newErrors]
		}
		return newErrorData
	}
	
	def getRebrokenErrorData() {
		def recurringErrorData = []
		runs.each{run ->
			recurringErrorData << [run.runNumber, run.reappearingErrors]
		}
		return recurringErrorData
	}
	
	def getFixedData() {
		def fixedErrorData = []
		runs.each{run -> 
			fixedErrorData << [run.runNumber, run.fixedErrors]
		}
		return fixedErrorData
	}
	
	static hasMany = [results:MeasureResult, runs:MeasureRun, tags:Tag]
	
	static mapping = {
		query type: 'text'
		correctionScript type: 'text'
		description type: 'text'
		runs sort:'runNumber', order: 'desc'
		results sort:'reference'
		numErrors formula: '(select count(*) from measure_result mr where mr.fixed_id is null and mr.measure_id = id)'
	}
	
    static constraints = {
		name blank: false
		description blank:false 
		connection blank:false 
		query blank:false 
		type unique:false 
		correctionScript nullable:true
    }
}
