<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team4: Consultation</title>
<%
	request.setCharacterEncoding("UTF-8");
	String Consult_Type = request.getParameter("Consult_Type");
    String CProfName = request.getParameter("CProfName"); //교수 이름
    //String id = request.getParameter("id"); //학생 아이디
    String id = (String)session.getAttribute("id");
    String uco = (String)session.getAttribute("uco");

    System.out.println(Consult_Type);

    System.out.println(id);
    session.setAttribute("Consult_Type", Consult_Type);
	session.setAttribute("CProfName", CProfName);
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt, pstmt2;
   ResultSet rs, rs2;
   String sql, sql2;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>
</head>
<body>
	<form name="form" action="consultAvailableCheck.jsp" method="post">
<% 
	//Consult_type에 따른 쿼리
	if (Consult_Type.equals("COURSE")) {
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num, C.CNum, C.CPId "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and (C_max_reserv_Num + 1) >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum) "
				+ "and CPId IN (SELECT DISTINCT CId FROM COURSE_REGISTRATION"
				+"		 WHERE CRco IN (SELECT CRco FROM COURSE_REGISTRATION"
				+"				 WHERE CId = '"+id+"')"
				+"		 AND CRFco = (SELECT SFco FROM STUDENT"
				+"				 WHERE SId = '"+id+"')"
				+"		 AND CRUco = '"+uco+"'"
				+"		 AND Role = 'p') "
				+ "and C.CSId = '0000000000' "
				+ "and C.consult_type = 'COURSE'";
		sql2 = "select count(*) - 1, cnum "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and (C_max_reserv_Num + 1) >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum) "
				+ "and CPId IN (SELECT DISTINCT CId FROM COURSE_REGISTRATION"
				+"		 WHERE CRco IN (SELECT CRco FROM COURSE_REGISTRATION"
				+"				 WHERE CId = '"+id+"')"
				+"		 AND CRFco = (SELECT SFco FROM STUDENT"
				+"				 WHERE SId = '"+id+"')"
				+"		 AND CRUco = '"+uco+"'"
				+"		 AND Role = 'p') "
				+ "and C.consult_type = 'COURSE' "
				+ "GROUP BY C.CNum";
	}
	else if (Consult_Type.equals("FOLLOW")) {//학생이 지도교수를 맞게 신청하면 보임
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num, C.CNum, C.CPId "
			+ "from consultation C, follow_student "
			+ "where tpid = cpid and tsid = '"+id +"' "
			+ "and cprofname = '" + CProfName + "' "
			+ "and (C_max_reserv_Num + 1) >= (select count(*) from consultation "
			+				"where cnum = C.cnum "
			+				"group by cnum) "
			+ "and C.CSId = '0000000000' "
			+ "and C.consult_type = 'FOLLOW'";
		sql2 = "select count(*) - 1,cnum "
				+ "from consultation C, follow_student "
				+ "where tpid = cpid and tsid = '"+id +"' "
				+ "and cprofname = '" + CProfName + "' "
				+ "and (C_max_reserv_Num + 1) >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum) "
				+ "and C.consult_type = 'FOLLOW' "
				+ "GROUP BY C.Cnum";
	}
	else {
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num, C.CNum, C.CPId  "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and (C_max_reserv_Num + 1) >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum)"
				+ "and C.CSId = '0000000000' "
				+ "and C.consult_type = 'GENERAL'";
		sql2 = "select (count(*) - 1),cnum "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and (C_max_reserv_Num + 1) >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum) "
				+ "and C.consult_type = 'GENERAL' "
				+ "GROUP BY C.Cnum";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	pstmt2 = conn.prepareStatement(sql2);
	rs2 = pstmt2.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	System.out.println(sql2);
	
	//store data
	String[] c = new String[100];
	String[] p = new String[100];
	String[] d = new String[100];
	String[] t = new String[100];
	String[] pl = new String[100];
	int[] m = new int[100];
	String[] CNum = new String[100];
	String[] CPId = new String[100];
	int i = 0;
	String[] Now = new String[100];
	
	StringTokenizer st;
	while(rs.next() && rs2.next()){
		c[i] = rs.getString(1);
		p[i] = rs.getString(2);
		d[i] = rs.getString(3);
		st = new StringTokenizer(d[i]);
		d[i] = st.nextToken();
		t[i] = rs.getString(4);
		pl[i] = rs.getString(5);
		m[i] = rs.getInt(6);
		CNum[i] = rs.getString(7);
		CPId[i] = rs.getString(8);
		Now[i] = rs2.getString(1);
		i++;
	}
	int total_cnt = i;
	
	//print
	out.println("<table border=\"1\">");
	out.println("<th>#</th>");
	out.println("<th>consult type</th>");
	out.println("<th>professor</th>");
	out.println("<th>date</th>");
	out.println("<th>time</th>");
	out.println("<th>place</th>");
	out.println("<th>participant number</th>");
	
	for(i=1; i<=total_cnt; i++){
		out.println("<tr>");
		out.println("<td>" + i + "</td>");
		out.println("<td>" + c[i-1] + "</td>");//Consult_type
		out.println("<td>" + p[i-1] + "</td>");//profname
		out.println("<td>" + d[i-1] + "</td>");//Cdate
		out.println("<td>" + t[i-1] + "</td>");//ctime
		out.println("<td>" + pl[i-1] + "</td>");//consult_space
		out.println("<td>" + Now[i-1] + "/" + m[i-1] + "</td>");//c_max_reserv_num
		out.println("</tr>");
	}
	out.println("</table>");
	
	//select consultation number
	out.println("<br><label for=\"select_num\">상담 선택</label>");
	out.println("<select name = \"select_num\" id=\"select_num\">");
	for(i=1; i<total_cnt+1; i++){
		out.println("<option value = \"" + i +"\">"+ i +"</option>");
	}
	out.println("</select>");
		
	//button
	out.println("<div id=\"buttons\">");
	out.println("<input type=\"submit\" value=\"apply\"></div>");

	//session enroll
	//배열 전체를 attribute로 등록함.
	session.setAttribute("c", c);
	session.setAttribute("p", p);
	session.setAttribute("d", d);
	session.setAttribute("t", t);
	session.setAttribute("pl", pl);
	session.setAttribute("m", m);
	session.setAttribute("CNumIn", CNum);
	session.setAttribute("CPIdIn", CPId);
	
	rs.close();
	rs2.close();
	pstmt.close();
	pstmt2.close();
%>
	</form>
</body>
</html>