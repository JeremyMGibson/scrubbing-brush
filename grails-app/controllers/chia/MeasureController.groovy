package chia



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured;
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MeasureController {
	def measureService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	@Secured("ROLE_USER")
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Measure.list(params), model:[measureInstanceCount: Measure.count()]
    }

	@Secured("ROLE_USER")
    def show(Measure measureInstance) {
        respond measureInstance
    }

	@Secured("ROLE_EDITOR")
    def create() {
        respond new Measure(params)
    }

	@Secured("ROLE_EDITOR")
    @Transactional
    def save(Measure measureInstance) {
        if (measureInstance == null) {
            notFound()
            return
        }

        if (measureInstance.hasErrors()) {
            respond measureInstance.errors, view:'create'
            return
        }
		
        measureInstance.save flush:true

        request.withFormat {
            form multipartForm {
				flash.success = true
                flash.message = message(code: 'default.created.message', args: [message(code: 'measure.label', default: 'Measure'), measureInstance.id])
                redirect measureInstance
            }
            '*' { respond measureInstance, [status: CREATED] }
        }
    }

	@Secured("ROLE_EDITOR")
    def edit(Measure measureInstance) {
        respond measureInstance
    }

	@Secured("ROLE_EDITOR")
    @Transactional
    def update(Measure measureInstance) {
        if (measureInstance == null) {
            notFound()
            return
        }

        if (measureInstance.hasErrors()) {
            respond measureInstance.errors, view:'edit'
            return
        }

        measureInstance.save flush:true

        request.withFormat {
            form multipartForm {
				flash.success = true
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Measure.label', default: 'Measure'), measureInstance.id])
                redirect measureInstance
            }
            '*'{ respond measureInstance, [status: OK] }
        }
    }

	@Secured("ROLE_EDITOR")
    @Transactional
    def delete(Measure measureInstance) {

        if (measureInstance == null) {
            notFound()
            return
        }

        measureInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Measure.label', default: 'Measure'), measureInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

	@Secured("ROLE_USER")
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'measure.label', default: 'Measure'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	@Secured("ROLE_USER")
	@Transactional
	def run(Measure measureInstance) {
		if (measureInstance == null) {
			redirect action:"index", method: "GET"
			return
		} 
		
		def run = measureService.runMeasure(measureInstance);
				
		flash.success = run.success 
		if (run.success) {			
			flash.message = "Measure successfully run"
		} else {
			flash.message = "Measure failed to run"
		}
		redirect action:"show", method:"GET", id:measureInstance.id
	}
	
	
}
