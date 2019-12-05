<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<head>
		<title>Sample Site</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300, 400,700|Inconsolata:400,700" rel="stylesheet">
		
		<link rel="stylesheet" href="/bootstrap/css/bootstrap.css">
		<link rel="stylesheet" href="/bootstrap/css/animate.css">
		<link rel="stylesheet" href="/bootstrap/css/owl.carousel.min.css">
		
		<link rel="stylesheet" href="/bootstrap/fonts/ionicons/css/ionicons.min.css">
		<link rel="stylesheet" href="/bootstrap/fonts/fontawesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="/bootstrap/fonts/flaticon/font/flaticon.css">
		
		<link rel="stylesheet" href="/bootstrap/css/style.css">
		
		<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	</head>
	<body>
		<div class="wrap">
			<header role="banner">
				<div class="top-bar">
					<div class="container">
						<div class="row">
							<div class="col-6 social">
								<a href="/board/list/1">Home(List)</a>
								<a href="/board/writeForm">Posting</a>
							</div>
							<div class="col-6 social text-right">
								<c:choose>
									<c:when test="${empty sessionScope.user}">
										<a href="/user/joinForm">Join</a>
										<a href="/user/loginForm">Login</a>
									</c:when>
									<c:otherwise>
										<a href="/user/info/${sessionScope.user.username}" style="opacity:1; text-decoration:none; cursor:pointer;"><img src="${sessionScope.user.profile}" style="width:30px; border-radius:50%; display:inline-block"/></a>
										<a href="#" style="opacity:1; text-decoration:none; cursor:default;">Hello, ${sessionScope.user.username}</a>
										<a href="/user/info/${sessionScope.user.username}">MyInfo</a>
										<a href="/user/logout">Logout</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				
				<div class="container logo-wrap">
					<div class="row pt-5">
						<div class="col-12 text-center">
							<a class="absolute-toggle d-block d-md-none" data-toggle="collapse" href="#navbarMenu" role="button" aria-expanded="false" aria-controls="navbarMenu">
								<span class="burger-lines"></span>
							</a>
							<h1 class="site-logo">
								<a href="/board/list/1">Sample Site</a>
							</h1>
							<hr/>
						</div>
					</div>
				</div>
				
				<!-- nav class="navbar navbar-expand-md  navbar-light bg-light">
					<div class="container">
						<div class="collapse navbar-collapse" id="navbarMenu">
							<ul class="navbar-nav mx-auto">
								<li class="nav-item">
									<a class="nav-link active" href="/board/list/1">Home(List)</a>
								</li>
								<li class="nav-item">
									&nbsp; &nbsp; &nbsp;
								</li>
								<li class="nav-item">
									<a class="nav-link" href="/guide">Guide</a>
								</li>
								<li class="nav-item">
									&nbsp; &nbsp; &nbsp;
								</li>
								<li class="nav-item">
									<a class="nav-link" href="/board/writeForm">Posting</a>
								</li>
							</ul>
						</div>
					</div>
				</nav -->
			
			</header>
