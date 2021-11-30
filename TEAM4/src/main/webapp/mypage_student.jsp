<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
</head>
<body>
<button onclick="location.href='main_student.jsp'">Back to Main Page</button>
	<h2>MY PAGE</h2><br>
		<!-- manage upcoming schedule and my account -->
	<nav>
	<ul>
		<p>
		<li>
		<input type = "button" onclick = "location.href='upcomingScheduleStudent.jsp'" value="UPCOMING SCHEULE">
		</li>
		</p>
		<p>
		<li>
		<input type = "button" onclick = "location.href='backend_seeMyProfile.jsp'" value="ACCOUNT">
		</li>
		</p>
	</ul>
	</nav>
</body>
</html>