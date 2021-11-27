<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!--  import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
</head>
<body>
	<form name="form" action="backend_login.jsp" method="post">
		<h2>Welcome to Consultation Service</h2>
		<br>
		<br>
		<h3>LOGIN</h3>
		<!-- insert id, password, and university code from user -->
		<fieldset>
			<legend>Fill out the form</legend>
			<ul>
				<li><label for="id">ID: </label> <input type="text" id="id"
					name="id" size="10"></li>
				<li><label for="pw">PASSWORD: </label> <input type="text"
					id="pw" name="pw"></li>
				<li><label for="uco">University Code: </label> <input
					type="text" id="uco" name="uco" size="5"></li>
			</ul>
		</fieldset>
		<br>
		<!-- select role(occupation) by User (radio button) -->
		<fieldset>
			<legend>Login as</legend>
			<input type="radio" name="loginType" id="PROFESSOR" value="PROFESSOR">
			<label for="PROFESSOR">PROFESSOR</label> 
			<input type="radio" name="loginType" id="STUDENT" value="STUDENT"> 
			<label for="STUDENT">STUDENT</label>
			<input type="radio" name="loginType" id="ADMIN" value="ADMIN"> 
			<label for="ADMIN">ADMIN</label>
		</fieldset>
		<br>
		<!-- Sign In button -->
		<div id="buttons">
			<input type="submit" value="LogIn">
		</div>
	</form>
</body>
</html>