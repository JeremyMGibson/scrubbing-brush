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
		measureRun.success = false;
		measureRun.save()
		
		try{
			Sql sql = createSql()
	
			def newErrorCount = 0
			def oldErrorCount = 0
			def rebrokenErrorCount = 0

			def errors = MeasureResult.findAllByMeasureAndFixed(measure, null)

			sql.eachRow(measure.query){result ->
				MeasureResult measureError = errors.findResult {it.reference == result.errorId ? it : null}
								
				if (measureError == null) {
					//Double check if it has already been fixed
					measureError = MeasureResult.findByReference(result.errorId)
					
					if (measureError == null) {
						measureError = new MeasureResult()
						measureError.reference = result.errorId
						measureError.errorData = result
						measureError.found = measureRun
						measureError.measure = measure
						measureError.disregard = false
						measureError.save()
						
						newErrorCount++
					} else {												
						measureError.fixed = null
						measureError.found = measureRun
						rebrokenErrorCount++
					}
				} else {
					measureError.errorData = result
					errors.removeAll{it.reference == result.errorId}

				 	if (!measureError.disregard) {
						oldErrorCount++ 
					} 
					measureError.save() 
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
			measureRun.save()
		} catch(Exception e) {
			e.printStackTrace();
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
