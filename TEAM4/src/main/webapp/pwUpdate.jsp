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
<form name="form" action="backend_pwUpdate.jsp" method="post">
	<h1>Update your Password</h1>
	<label for="pwUpdate">PASSWORD: </label> 
	<input type="text" id="pwUpdate" name="pwUpdate">
	<div id="buttons">
				<input type="submit" value="update">
	</div>
</form>
</body>
</html>