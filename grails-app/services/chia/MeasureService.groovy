package chia

import java.sql.Connection
import java.sql.DriverManager
import java.sql.Statement

import org.joda.time.DateTime

class MeasureService {

	def runMeasure(Measure measure) {
		def measureRun = new MeasureRun()
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
				def measureResult = MeasureError.findByMeasureAndReference(measure, result[0])
				def errorData = [:]
				(1..result.size()).each{i ->
					errorData[i-1] = result[i]
				}
				if (measureResult == null) {
					measureResult = new MeasureError(measure, result[0], errorData)
					newErrorCount++
				} else if (measureResult.disregard) {
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
			def	fixedErrors = MeasureError.ffindByMeasureAndRNoteferenceAndFixed(measure, errorRefs, null)
			fixedErrors.each{error ->
				error.fixed = new DateTime()
				error.save()
			}
	    	
		} catch(Exception e) {
			
		}
	}
}
