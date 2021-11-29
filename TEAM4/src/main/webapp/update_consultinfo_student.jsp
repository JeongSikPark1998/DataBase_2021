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
	<form name="form" action="backend_modifyConsultInfo.jsp" method="post">
		<h3>Update your content</h3>
		<fieldset>
			<legend>Fill out the form</legend>
			<ul>
				<li>content: <textarea name="content2" cols=50 rows="10"></textarea></li>
			</ul>
		</fieldset>
		<div id="buttons">
			<input type="submit" value="submit">
		</div>
	</form>
</body>
</html>