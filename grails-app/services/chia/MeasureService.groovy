package chia

import grails.transaction.Transactional

import java.sql.Connection
import java.sql.DriverManager
import java.sql.Statement

import org.joda.time.DateTime

@Transactional
class MeasureService {

	MeasureRun runMeasure(Measure measure) {
		def run = runQuery(measure)
		if (!measure.correctionScript?.trim() && run.success) {
			runUpdate(measure, run)
			def results = executeSql(measure.connection, measure.query)
			run.fixedErrors = run.newErrors + run.oldErrors + run.reappearingErrors - results.size()
			run.save()
		}
		return run 
	}

	def runUpdate(Measure measure, MeasureRun run) {
		def errors = MeasureResult.findAllByMeasureAndFixed(measure, null)
		errors.each{ error ->
			// Load the error references and their data into the correction Script and execute it
			error.fixed = run
			error.save()
		}
	}

	MeasureRun runQuery(Measure measure) {
		def measureRun = new MeasureRun()

		measureRun.runtime = new DateTime()
		measureRun.measure = measure
		measureRun.runNumber = measure.runs == null ? 1 : measure.runs.size() + 1
		try{
			def results = executeSql(measure.connection, measure.query)
	
			def newErrorCount = 0
			def oldErrorCount = 0
			def rebrokenErrorCount = 0

			def errors = MeasureResult.findAllByMeasureAndFixed(measure, null)

			results.each{result ->
				def measureResult = errors[result[0]]
				def errorData = [:]
				(1..result.size()).each{i ->
					errorData[i-1] = result[i]
				}
				if (measureResult == null) {
					measureResult = new MeasureResult()
					measureResult.reference = result[0]
					measureResult.errorData = errorData
					measureResult.found = measureRun
					measureResult.measure = measure
					
					newErrorCount++
				} else {
					measureResult.errorData = errorData
					errors.remove(result[0])

				 	if (measureResult.disregard) {
						//Skip this one
					} else if (measureResult.fixed == null) {
						oldErrorCount++ 
					} else {												
						measureResult.fixed = null
						measureResult.found = new DateTime()
						rebrokenErrorCount++
					}
				}
				measureResult.save()
			}
			errors.each{error ->
				error.fixed = measureRun
				error.save()
			}
			measureRun.oldErrors = oldErrorCount
			measureRun.newErrors = newErrorCount
			measureRun.reappearingErrors = rebrokenErrorCount
			measureRun.fixedErrors = errors.size()
		} catch(Exception e) {
			e.printStackTrace();
			measureRun.success = false
		} finally {
			measureRun.save()
		}

		return measureRun
	}

	def executeSql(Measure.Connection connection, String query) {
		Class.forName ("oracle.jdbc.OracleDriver");
		//Load connection
      	def conn = DriverManager.getConnection("jdbc:oracle:oci:@RM-PRD", "GIBSONJ2_RO", "TEMP1234")
	 	Statement stmt = conn.createStatement()
		return stmt.executeQuery(query)
	}
}
