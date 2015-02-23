package chia

import org.joda.time.DateTime


class MeasureRun {
	int runNumber
	DateTime runtime
	int oldErrors
	int newErrors
	int fixedErrors
	int reappearingErrors
	Boolean success
	Measure measure

    static constraints = {
		measure blank:false
    }
}
