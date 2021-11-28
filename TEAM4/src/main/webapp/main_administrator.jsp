<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!--  import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Administrator</title>
</head>
<body>
	<header id="header">
		<h1>Admin</h1>
	</header>
	<form name="form" method="post">
		<h3>Create New University</h3>
		<fieldset>
			<ul>
				<li><label for="UName">University Name: </label> 
				<input type="text" id="UName" name="UName">
				<input type="submit" value="CREATE" onclick = "javascript: form.action='backend_adminCreateUniversity.jsp';">
				</li>
			</ul>
			<!-- Create new university with input name -->
		</fieldset>
		<h3>Delete University</h3>
		<fieldset>
			<ul>
				<li><label for="UCode">University Code: </label> 
				<input type="text" id="UCode" name="UCode">
				<input type="submit" value="DELETE" onclick = "javascript: form.action='backend_adminDeleteUniversity.jsp';"></li>
			</ul>
			<!-- Delete university with input code -->
		</fieldset>
		<h3>See Faculty and Course in University</h3>
		<fieldset>
			<ul>
				<li><label for="UCode">University Code: </label> 
				<input type="text" id="UCo1" name="UCo1">
				<input type="submit" value="SUBMIT" onclick = "javascript: form.action='backend_adminSeeFacultyAndCourse.jsp';"></li>
			</ul>
			<!-- See university with input code -->
		</fieldset>
	</form>

	
</body>
</html>