package chia

import grails.transaction.Transactional
import groovy.sql.Sql

import org.joda.time.DateTime

import com.mysql.jdbc.ResultSetMetaData

@Transactional
class MeasureService {

	MeasureRun runMeasure(Measure measure) {
		def run = runQuery(measure)
		if (!measure.correctionScript?.trim() && run.success) {
			//runUpdate(measure, run)
			//def results = createSql(measure.connection, measure.query)
			//run.fixedErrors = run.newErrors + run.oldErrors + run.reappearingErrors - results.size()
			//run.save()
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
			Sql sql = createSql()
	
			def newErrorCount = 0
			def oldErrorCount = 0
			def rebrokenErrorCount = 0

			def errors = MeasureResult.findAllByMeasureAndFixed(measure, null)

			sql.eachRow(measure.query){result ->
				def measureResult = errors.findResult {err -> err.reference = result.errorId}
								
				if (measureResult == null) {
					measureResult = new MeasureResult()
					measureResult.reference = result.errorId
					measureResult.errorData = result
					measureResult.found = measureRun
					measureResult.measure = measure
					measureResult.save()
					
					newErrorCount++
				} else {
					measureResult.errorData = result
					errors.removeIf {err -> err.reference = result.errorId}

				 	if (measureResult.disregard) {
						//Skip this one
					} else if (measureResult.fixed == null) {
						oldErrorCount++ 
					} else {												
						measureResult.fixed = null
						measureResult.found = new DateTime()
						rebrokenErrorCount++
					}
					measureResult.save() 
				}
				
			}
			errors.each{error ->
				error.fixed = measureRun
				error.save()
			}
			measureRun.oldErrors = oldErrorCount
			measureRun.newErrors = newErrorCount
			measureRun.reappearingErrors = rebrokenErrorCount
			measureRun.fixedErrors = errors.size()
			measureRun.success = true
		} catch(Exception e) {
			e.printStackTrace();
			measureRun.success = false
		} finally {
			measureRun.save()
		}

		return measureRun
	}

	def createSql() {
		return Sql.newInstance(
			"jdbc:oracle:thin:@cman1.qut.edu.au:1630/RMPRD.QUT.EDU.AU",
			"GIBSONJ2_RO",
			"TEST1234",
			"oracle.jdbc.OracleDriver")
	}
}
