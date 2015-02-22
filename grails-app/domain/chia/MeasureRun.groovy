package chia


class MeasureRun {
	int runNumber
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
