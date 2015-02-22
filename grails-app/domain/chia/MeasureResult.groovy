package chia

class MeasureResult {
	String reference
	String errorData	
	DateTime found
	DateTime fixed
	bool ignore
		
	static belongsTo = [measure:Measure]

	static constraints = {
		reference blank:false
		found defaultValue:"new DateTime()"
	}
}
