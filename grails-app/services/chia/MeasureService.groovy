package chia

import java.sql.Connection
import java.sql.DriverManager
import java.sql.Statement

import org.joda.time.DateTime

class MeasureService {

	def runMeasure(Measure measure) {
		def measureRun = new MeasureRun()
		measureRun.runtime = new DateTime()
		try{
			//Load connection
			measure.connection
       		Connection conn = Class.forName("com.mysql.jdbc.Driver")
        	conn = DriverManager.getConnection("jdbc:mysql://localhost/mydb", "root", "root")
        	Statement stmt = conn.createStatement()
			def results = stmt.executeQuery(measure.query)

			def newErrorCount = 0
			def oldErrorCount = 0
			def fixedErrorCount = 0
			def rebrokenErrorCount = 0
			def errorRefs = []

			results.each{result ->
				def measureResult = MeasureResult.findByMeasureIdAndReference(measure.id, result[0])
				def errorData = [:]
				(1..result.size()).each{i ->
					errorData[i-1] = result[i]
				}
				if (measureResult == null) {
					measureResult = new MeasureResult(measure, result[0], errorData)
					newErrorCount++
				} else if (measureResult.ignore) {
					//Skip this one
				} else if (measureResult.fixed == null) {
					oldErrorCount++ 
				} else {
					measureResult.fixed = null
					measureResult.found = new DateTime()
					rebrokenErrorCount++
				}
				measureResult.save()
				errorRefs << measureResult.reference
			}
			def	fixedErrors = MeasureResult.findByMeasureIdAndReferenceAndFixed(measure.id, errorRefs, null)
			fixedErrors.each{error ->
				error.fixed = new DateTime()
				error.saved()
			}
	    	
		} catch(Exception e) {
			
			
		}
	}
}
