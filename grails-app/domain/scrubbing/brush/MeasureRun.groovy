package scrubbing.brush

import java.util.Formatter.DateTime

class MeasureRun {
	
	DateTime runtime
	int oldErrors
	int newErrors
	int fixedErrors
	int reappearingErrors
		
	static belongsTo = [measure:Measure]

    static constraints = {
		measure blank:false
    }
}
