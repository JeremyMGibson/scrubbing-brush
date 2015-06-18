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
  <!-- Calendar -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/fullcalendar.css">
  <!-- prettyPhoto -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/prettyPhoto.css">  
  <!-- Star rating -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/rateit.css">
  <!-- Date picker -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/bootstrap-datetimepicker.min.css">
  <!-- CLEditor -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/jquery.cleditor.css">  
  <!-- Data tables -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/jquery.dataTables.css"> 
  <!-- Bootstrap toggle -->
  <link rel="stylesheet" href="${request.contextPath}/macadmin/css/jquery.onoff.css">
  <!-- Main stylesheet -->
  <link href="${request.contextPath}/macadmin/css/style.css" rel="stylesheet">
  <!-- Widgets stylesheet -->
  <link href="${request.contextPath}/macadmin/css/widgets.css" rel="stylesheet">
  
  <link href="${request.contextPath}/css/admin.css" rel="stylesheet">   
  
  <script src="${request.contextPath}/macadmin/js/respond.min.js"></script>
  <!--[if lt IE 9]>
  <script src="${request.contextPath}/macadmin/js/html5shiv.js"></script>
  <![endif]-->

  <!-- Favicon -->
  <link rel="shortcut icon" href="img/favicon/favicon.png">
  <g:layoutHead/>
  
  <!-- JS -->
	<script src="${request.contextPath}/macadmin/js/jquery.js"></script> <!-- jQuery -->
	<script src="${request.contextPath}/macadmin/js/bootstrap.min.js"></script> <!-- Bootstrap -->
	<script src="${request.contextPath}/macadmin/js/jquery-ui.min.js"></script> <!-- jQuery UI -->
	<script src="${request.contextPath}/macadmin/js/fullcalendar.min.js"></script> <!-- Full Google Calendar - Calendar -->
	<script src="${request.contextPath}/macadmin/js/jquery.rateit.min.js"></script> <!-- RateIt - Star rating -->
	<script src="${request.contextPath}/macadmin/js/jquery.prettyPhoto.js"></script> <!-- prettyPhoto -->
	<script src="${request.contextPath}/macadmin/js/jquery.slimscroll.min.js"></script> <!-- jQuery Slim Scroll -->
	<script src="${request.contextPath}/macadmin/js/jquery.dataTables.min.js"></script> <!-- Data tables -->
	
	<!-- jQuery Flot -->
	<script src="${request.contextPath}/macadmin/js/excanvas.min.js"></script>
	<script src="${request.contextPath}/macadmin/js/jquery.flot.js"></script>
	<script src="${request.contextPath}/macadmin/js/jquery.flot.resize.js"></script>
	<script src="${request.contextPath}/macadmin/js/jquery.flot.pie.js"></script>
	<script src="${request.contextPath}/macadmin/js/jquery.flot.stack.js"></script>
	
	<!-- jQuery Notification - Noty -->
	<script src="${request.contextPath}/macadmin/js/jquery.noty.js"></script> <!-- jQuery Notify -->
	<script src="${request.contextPath}/macadmin/js/themes/default.js"></script> <!-- jQuery Notify -->
	<script src="${request.contextPath}/macadmin/js/layouts/bottom.js"></script> <!-- jQuery Notify -->
	<script src="${request.contextPath}/macadmin/js/layouts/topRight.js"></script> <!-- jQuery Notify -->
	<script src="${request.contextPath}/macadmin/js/layouts/top.js"></script> <!-- jQuery Notify -->
	<!-- jQuery Notification ends -->
	
	<script src="${request.contextPath}/macadmin/js/sparklines.js"></script> <!-- Sparklines -->
	<script src="${request.contextPath}/macadmin/js/jquery.cleditor.min.js"></script> <!-- CLEditor -->
	<script src="${request.contextPath}/macadmin/js/bootstrap-datetimepicker.min.js"></script> <!-- Date picker -->
	<script src="${request.contextPath}/macadmin/js/jquery.onoff.min.js"></script> <!-- Bootstrap Toggle -->
	<script src="${request.contextPath}/macadmin/js/filter.js"></script> <!-- Filter for support page -->
	<script src="${request.contextPath}/macadmin/js/custom.js"></script> <!-- Custom codes -->
	<script src="${request.contextPath}/macadmin/js/charts.js"></script> <!-- Charts & Graphs -->
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

  	<!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-dropdown"><a href="#">Navigation</a></div>

        <!--- Sidebar navigation -->
        <!-- If the main navigation has sub navigation, then add the class "has_sub" to "li" of main navigation. -->
        <ul id="nav">
          <!-- Main menu with font awesome icon -->
          <li><a href="${request.contextPath}"><i class="fa fa-home"></i> Dashboard</a></li>
          <sec:ifAnyGranted roles="ROLE_USER,ROLE_EDITOR,ROLE_ADMIN">
          	<li><a href="${request.contextPath}/measure/"><i class="fa fa-bar-chart"></i> Measures</a></li>
		  </sec:ifAnyGranted>
		  <sec:ifAnyGranted roles="ROLE_ADMIN">
          	<li><a href="${request.contextPath}/user/"><i class="fa fa-user"></i> Users</a></li>
          	<li><a href="${request.contextPath}/tag/"><i class="fa fa-list"></i> Tags</a></li>
          </sec:ifAnyGranted>  
        </ul>
    </div>

    <!-- Sidebar ends -->

  	<!-- Main bar -->
  	<div class="mainbar">
        <g:layoutBody/>  
    </div>

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