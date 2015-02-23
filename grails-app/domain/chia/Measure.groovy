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
	
	static hasMany = [errors:MeasureError, runs:MeasureRun]
	
	static mapping = {
		query type: 'text'
		correctionScript type: 'text'
		description type: 'text'
	 }
	
    static constraints = {
		name blank: false
		description blank:false 
		connection blank:false 
		query blank:false 
		type unique:false 
    }
}
