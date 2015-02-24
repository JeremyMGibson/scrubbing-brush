package chia

import org.jadira.usertype.dateandtime.joda.PersistentDateTime
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

	int getTotalErrors() {
		return oldErrors + newErrors + reappearingErrors
	}	

	static mapping = {
		runtime type: PersistentDateTime
	}
	
    static constraints = {
		measure blank:false
    }
}
