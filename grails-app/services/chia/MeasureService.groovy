package chia

import grails.transaction.Transactional

@Transactional
class MeasureService {

    def runMeasure(Measure measure) {
		measure.query
    }
}
