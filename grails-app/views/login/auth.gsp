<html>
	<head>
		<meta name="layout" content="base"/>
		<title>Welcome to Grails</title>
		<r:require module="core" />
	</head>
	<body>

<!-- Form area -->
<div class="admin-form">
  <div class="container">

    <div class="row">
      <div class="col-md-12">
        <!-- Widget starts -->
            <div class="widget worange">
              <!-- Widget head -->
              <div class="widget-head">
                <i class="fa fa-lock"></i> Login 
              </div>

              <div class="widget-content">
                <div class="padd">
					<g:if test='${flash.message}'>
						<div class="alert alert-danger">${flash.message}</div>
					</g:if>
			
				<form action='${postUrl}' method='POST' id='loginForm' class='form-horizontal'>
					<div class="form-group">
                      <label class="control-label col-lg-3" for="username"><g:message code="springSecurity.login.username.label"/></label>
                      <div class="col-lg-9">
                        <input type="text" class="form-control" id="username" name='j_username' placeholder="Email">
                      </div>
                    </div>
					<div class="form-group">
                      <label class="control-label col-lg-3" for="password"><g:message code="springSecurity.login.password.label"/></label>
                      <div class="col-lg-9">
                        <input type="password" class="form-control" id="password" name="j_password" placeholder="Password">
                      </div>
                    </div>
					<div class="form-group">
						<div class="col-lg-9 col-lg-offset-3">
	                      <div class="checkbox">
	                        <label>
	                          <input type="checkbox" name='${rememberMeParameter}'  id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
	                          Remember me
	                        </label>
							</div>
						</div>
					</div>
                    <div class="col-lg-9 col-lg-offset-3">
						<button type="submit" id="submit" class="btn btn-info btn-sm">Sign in</button>
					</div>
                    <br />
				</form>
				</div>
               </div>
              </div>
             </div>
            </div>
           </div>
          </div>
	</body>
</html>