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
String[] c = (String[]) session.getAttribute("c2");
String[] p = (String[]) session.getAttribute("p2");
String[] d = (String[]) session.getAttribute("d2");
String[] t = (String[]) session.getAttribute("t2");
String[] pl = (String[]) session.getAttribute("pl2");
int[] m = (int[]) session.getAttribute("m2");
String[] CNum = (String[])session.getAttribute("CNum2");
String[] CPId = (String[])session.getAttribute("CPId2");
int selectnum = Integer.parseInt(request.getParameter("select_num2"));
selectnum -= 1;
session.setAttribute("selectnum2", selectnum2);
session.setAttribute("Consult_date2", d2[selectnum]);
session.setAttribute("Consult_time2", t2[selectnum]);
session.setAttribute("Consult_Space2", pl2[selectnum]);
session.setAttribute("Max2", m2[selectnum]);
session.setAttribute("CNum2", CNum2[selectnum]);
session.setAttribute("CPId2", CPId2[selectnum]);
%>
</head>
<body>
	<form name="form" action="backend_update_consultinfo_student.jsp" method="post">
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