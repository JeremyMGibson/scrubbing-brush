package scrubbing.brush

class Measure {
	enum MeasureType { ERROR, WARNING }
	
	String name
	String description
	String connection
	String query
	String correctionScript
	MeasureType type
	
	static hasMany = [run:MeasureRun, errors:MeasureResult]
	
    static constraints = {
		name blank: false
		description blank:false 
		connection blank:false 
		query blank:false 
		type unique:false 
    }
}
