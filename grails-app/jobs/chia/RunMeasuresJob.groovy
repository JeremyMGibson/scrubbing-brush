package chia



class RunMeasuresJob {
	def measureService
	
    static triggers = {
      cron name: "morningAndNight", cronExpression: "0 0 6,12,18 * * ?" //Run at 6am and 6pm every day
    }

	def group = "MeasuresTriggers"
	def description = "Job that runs all measures before and after work"
	
    def execute() {
		measureService.runAllMeasures()
    }
}
