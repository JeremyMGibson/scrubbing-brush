package scrubbing.brush


class MeasureRun {
	
	Date runtime
	int oldErrors
	int newErrors
	int fixedErrors
	int reappearingErrors
		
	static belongsTo = [measure:Measure]

    static constraints = {
		measure blank:false
    }
}
