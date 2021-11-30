<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!--  import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
<%
	String[] c = (String[]) session.getAttribute("c");
	String[] p = (String[]) session.getAttribute("p");
	String[] d = (String[]) session.getAttribute("d");
	String[] t = (String[]) session.getAttribute("t");
	String[] pl = (String[]) session.getAttribute("pl");
	int[] m = (int[]) session.getAttribute("m");
	String[] CNumIn = (String[])session.getAttribute("CNumIn");
	String[] CPIdIn = (String[])session.getAttribute("CPIdIn");
	int selectnumIn = (int)session.getAttribute("selectnumIn");
	selectnumIn -= 1;
	//Consult_Type는 이미 지정 완료
	//CProfName는 이미 지정 완료
	session.setAttribute("Consult_date", d[selectnumIn]);
	session.setAttribute("Consult_time", t[selectnumIn]);
	session.setAttribute("Consult_Space", pl[selectnumIn]);
	session.setAttribute("Max", m[selectnumIn]);
	//이후에 사용할 것들
	session.setAttribute("CNum", CNumIn[selectnumIn]);
	session.setAttribute("CPId", CPIdIn[selectnumIn]);
%>
</head>
<body>
	<form name="form" action="backend_signUpConsultation.jsp" method="post">
		<h3>Insert your Information</h3>
		<fieldset>
			<legend>Fill out the form</legend>
			<ul>
				<li><label for="Name">Name: </label> <input type="text"
					id="Name" name="Name"></li>
				<li><label for="Grade">Grade: </label> <input type="text"
					id="Grade" name="Grade"></li>
				<li><label for="GPA">GPA: </label> <input type="text" id="GPA"
					name="GPA"></li>
				<li><label for="age">age: </label> <input type="text" id="age"
					name="age"></li>
				<li><label for="m_served">Military Served</label> <select
					name="m_served" id="m_served">
						<option value="Y">Y</option>
						<option value="N">N</option>
				</select>
				<li>content: <textarea name="content" cols=50 rows="10"></textarea></li>
			</ul>
		</fieldset>
		<div id="buttons">
			<input type="submit" value="submit">
		</div>
	</form>
</body>
</html>