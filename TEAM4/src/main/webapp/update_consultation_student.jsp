<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<%
//upcomingScheduleStudent.jsp에서 넘어온 배열 정보들 저장
String[] c2 = (String[])session.getAttribute("c2");
String[] p2 = (String[])session.getAttribute("p2");
String[] d2 = (String[])session.getAttribute("d2");
String[] t2 = (String[])session.getAttribute("t2");
String[] pl2 = (String[])session.getAttribute("pl2");
int[] m2 = (int[])session.getAttribute("m2");
String[] CNum2 = (String[])session.getAttribute("CNum2");
String[] CPId2 = (String[])session.getAttribute("CPId2");
int selectnum2 = Integer.parseInt(request.getParameter("select_num2"));
selectnum2 -= 1;
//내가 선택한 상담 정보 저장
session.setAttribute("selectnum2", selectnum2);
session.setAttribute("Consult_Type2", c2[selectnum2])
session.setAttribute("ProfName2", p2[selectnum2])
session.setAttribute("Consult_date2", d2[selectnum2]);
session.setAttribute("Consult_time2", t2[selectnum2]);
session.setAttribute("Consult_Space2", pl2[selectnum2]);
session.setAttribute("Max2", m2[selectnum2]);
session.setAttribute("CNum2", CNum2[selectnum2]);
session.setAttribute("CPId2", CPId2[selectnum2]);
%>
<body>
	<header id="header">
		<h1>Update your consultation</h1>
		<nav>
		<ul>
			<li><a href="update_consultinfo_student.jsp">update your consult information</a></li>
		</ul>
		</nav>
	</header>
	<nav>
		<ul>
			<li><a href="backend_cancel_consultation_student.jsp">cancel your consultation</a></li>
		</ul>
	</nav>
</body>
</html>