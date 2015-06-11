package chia

class Measure {
	enum MeasureType { ERROR, WARNING }
	enum Connection { RESEARCH_MASTER }
	
	String name
	String description
	Connection connection
	String query
	String correctionScript
	MeasureType type
	
	def getRunData() {
		def oldErrorData = []
		def newErrorData = []
		def recurringErrorData = []
		def fixedErrorData = []
		def allErrorData = [newErrorData, recurringErrorData, oldErrorData, fixedErrorData]
		runs.each{run ->
			oldErrorData << [run.runNumber, run.oldErrors]
			newErrorData << [run.runNumber, run.newErrors]
			recurringErrorData << [run.runNumber, run.reappearingErrors]
			fixedErrorData << [run.runNumber, run.fixedErrors]
		}
		return allErrorData
	}
	
	static hasMany = [results:MeasureResult, runs:MeasureRun]
	
	static mapping = {
		query type: 'text'
		correctionScript type: 'text'
		description type: 'text'
		runs sort:'runNumber'
		results sort:'reference'
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
