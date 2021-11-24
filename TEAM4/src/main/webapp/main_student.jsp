<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
</head>
<body>
	<header id="header">
		<h1>CONSULTATION</h1>
		<nav>
		<ul>
			<li><a href="mypage_student.jsp">MY PAGE</a></li>
		</ul>
		</nav>
	</header>
	
	<!-- 민중시가 만든 jsp파일로 연결(consultType, professorName 만족하는 consultation 찾는 query문을 담은 jsp파일) -->
	<form name="form" action="schedule_student.jsp" method="post">
		<h2>Search available Consultation Schedule</h2><br><br>
		<!-- select consult type by User (radio button) -->
		<fieldset>
			<legend>Fill out the form</legend>
			<input type="radio" name="Consult_Type" id="GENERAL" value="GENERAL">
			<label for="GENERAL">GENERAL</label>
			<input type="radio" name="Consult_Type" id="FOLLOW" value="FOLLOW">
			<label for="FOLLOW">FOLLOW</label>
			<input type="radio" name="Consult_Type" id="COURSE" value="COURSE">
			<label for="COURSE">COURSE</label>
		<!-- insert Professor's first name -->
			<ul>
				<li>
					<label for="CProfName">Professor's First Name: </label>
					<input type="text" id="CProfName" name="CProfName">
				</li>
			</ul>
		</fieldset><br>
		<!-- search available consultation that meets student's selection In button -->
		<div id="buttons">
			<input type="submit" value="SEARCH">
		</div>
	</form>
</body>
</html>
