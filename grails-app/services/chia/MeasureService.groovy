package chia

import grails.transaction.Transactional

import java.sql.Connection
import java.sql.DriverManager
import java.sql.Statement

import org.joda.time.DateTime

@Transactional
class MeasureService {

	def  runMeasure(Measure measure) {
		def run = runQuery(measure)
		if (!measure.updateScript?.trim() && run.success) {
			runUpdate(measure)
			def results = executeSql(measure.connection, measure.query)
			run.fixedErrors = run.newErrors + run.oldErrors + run.rebrokenErrors - results.size()
			run.save()
		} 
	}

	def runUpdate(Measure measure) {
		def errors = MeasureError.findByMeasureIdAndFixed(measure.id, null)
		// Load the error references and their data into the correction Script and execute it
	}

	def runQuery(Measure measure) {
		def measureRun = new MeasureRun()

		measureRun.runtime = new DateTime()
		measureRun.measure = measure
		measureRun.runNumber = measure.runs.size()
		try{
			def results = executeSql(measure.connection, measure.query)
	
			def newErrorCount = 0
			def oldErrorCount = 0
			def rebrokenErrorCount = 0

			def errors = MeasureError.findByMeasureIdAndFixed(measure.id, null)

			results.each{result ->
				def measureResult = errors[result[0]]
				def errorData = [:]
				(1..result.size()).each{i ->
					errorData[i-1] = result[i]
				}
				if (measureResult == null) {
					measureResult = new MeasureError(measure, result[0], errorData)
					newErrorCount++
				} else {
					measureResult.errorData = errorData
					errors.remove(result[0])

				 	if (measureResult.ignore) {
						//Skip this one
					} else if (measureResult.fixed == null) {
						oldErrorCount++ 
					} else {												measureResult.fixed = null
						measureResult.found = new DateTime()
						rebrokenErrorCount++
					}
				}
				measureResult.save()
				errorRefs << measureResult.reference
			}
			errors.each{error ->
				error.fixed = new DateTime()
				error.save()
			}
			measureRun.oldErrors = oldErrorCount
			measureRun.newErrors = newErrorCount
			measureRun.reappearingErrors = rebrokenErrorCount
			measureRun.fixedErrors = errors.size()
		} catch(Exception e) {
			measureRun.success = false
		} finally {
			measureRun.save()
		}

		return measureRun
	}

	def executeSql(Measure.Connection connection, String query) {
		//Load connection
      	Connection conn = Class.forName("com.mysql.jdbc.Driver") 		
		conn = DriverManager.getConnection("jdbc:mysql://localhost/mydb", "root", "root")
	 	Statement stmt = conn.createStatement()
		return stmt.executeQuery(query)
	}
}
