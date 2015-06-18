package chia

/**
 * The name of the tags that a measure can be within
 * @author gibsonj2
 *
 */
class Tag {
	String name
	static hasMany = [measures : Measure]
	static belongsTo = Measure
	
    static constraints = {
		name blank: false
    }
}
