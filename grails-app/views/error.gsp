<!DOCTYPE html>
<html>
	<head>
		<title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
		<meta name="layout" content="base">
		<g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
	</head>
	<body>
		<div class='body'>
			<div class="container">
   				<div class="row">
      				<div class="col-md-12">
           				<div class="widget worange">
			        	    <!-- Widget head -->
			            	<div class="widget-head">
			                	<i class="fa fa-question-circle"></i> Error 
			            	</div>

       	      				<div class="widget-content">
   	            				<div class="padd">
                					<div class="alert alert-danger">
               							<g:if env="development">
											<g:renderException exception="${exception}" />
										</g:if>
										<g:else>
											An error has occurred
										</g:else>
               						</div>
								</div>
              					</div>
             				</div>
            			</div>
           		</div>
       		</div>
		</div>
	</body>
</html>
