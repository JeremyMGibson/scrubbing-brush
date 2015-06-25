<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title><g:layoutTitle default="Grails"/></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="author" content="">

 <!-- Stylesheets -->
  <link href="${request.contextPath}/macadmin/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font awesome icon -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/font-awesome.min.css"> 
  <!-- jQuery UI -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/jquery-ui.css"> 
  <!-- Main stylesheet -->
  <link href="${request.contextPath}/macadmin/css/style.css" rel="stylesheet">
  <!-- Widgets stylesheet -->
  <link href="${request.contextPath}/macadmin/css/widgets.css" rel="stylesheet">
  
  <link href="${request.contextPath}/assets/admin.css" rel="stylesheet">
  <!-- Favicon -->
  <link rel="shortcut icon" href="${request.contextPath}/macadmin/img/favicon/favicon.png">
  
  <script src="${request.contextPath}/macadmin/js/jquery.js"></script> <!-- jQuery -->
  <script src="${request.contextPath}/macadmin/js/bootstrap.min.js"></script> <!-- Bootstrap -->
	<script src="${request.contextPath}/macadmin/js/jquery-ui.min.js"></script> <!-- jQuery UI -->
  
</head>

<body>

<div class="navbar navbar-fixed-top bs-docs-nav" role="banner">
        <!-- Menu button for smallar screens -->
      <div class="navbar-header">
		  <button class="navbar-toggle btn-navbar" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
			<span>Menu</span>
		  </button>
		  <!-- Site name for smallar screens -->
		  <a href="index.html" class="navbar-brand">Chia</a>
		</div>
      
      

      <!-- Navigation starts -->
      <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">         
        <!-- Links -->
        <ul class="nav navbar-nav pull-right">
          <li class="dropdown pull-right">            
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
              <i class="fa fa-user"></i> Admin <b class="caret"></b>              
            </a>
            
            <!-- Dropdown menu -->
            <ul class="dropdown-menu">
              <li><a href="#"><i class="fa fa-user"></i> Profile</a></li>
              <li><a href="${request.contextPath}/j_spring_security_logout"><i class="fa fa-sign-out"></i> Logout</a></li>
            </ul>
          </li>
          
        </ul>
      </nav>

    </div>


<!-- Main content starts -->

<div class="content">

  	<g:layoutBody/>  

   <!-- Mainbar ends -->	    	
   <div class="clearfix"></div>

</div>
<!-- Content ends -->

<!-- Footer starts -->
<footer>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
      </div>
    </div>
  </div>
</footer> 	

<!-- Footer ends -->

<!-- Scroll to top -->
<span class="totop"><a href="#"><i class="fa fa-chevron-up"></i></a></span> 

</body>
</html>