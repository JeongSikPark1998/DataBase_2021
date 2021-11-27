<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
	String Cousult_Type = request.getParameter("Consult_Type");
    String CProfName = request.getParameter("CProfName"); //교수 이름
    //String id = request.getParameter("id"); //학생 아이디
    String id = (String)session.getAttribute("id");
    System.out.println(Consult_Type);

    System.out.println(id);
    //session.setAttribute("Consult_Type", Consult_Type);
	//session.setAttribute("CProfName", CProfName);
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt;
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>
</head>
<body>
<% 
	//Consult_type에 따른 쿼리
	if (Cousult_Type.equals("COURSE")) {
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and csid = '" + id + "' "
				+ "and C_max_reserv_Num > (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum) "
				+ "and cpid in (select co2.cid from course_registration co2 "
				+ "				where (co2.crco, co2.crfco, co2.cruco) in (select co3.crco, co3.crfco, co3.cruco "
				+ "											from course_registration co3 "
				+ "											where cid = '" + id + "') "
				+ "				and co2.role = 'p')";
	}
	else if (Cousult_Type.equals("FOLLOW")) {//학생이 지도교수를 맞게 신청하면 보임
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num "
			+ "from consultation C, follow_student "
			+ "where tpid = cpid and tsid = csid "
			+ "and cprofname = '" + CProfName + "' "
			+ "and csid = '" + id + "' "
			+ "and C_max_reserv_Num > (select count(*) from consultation "
			+				"where cnum = C.cnum "
			+				"group by cnum)";
	}
	else {
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num "
				+ "from consultation C"
				+ "where cprofname = '" + CProfName + "' "
				+ "and C_max_reserv_Num > (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum)";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	
	//print
	out.println("<tr>");
	out.println("<td><b>consult type</b></td>");
	out.println("<td><b>professor</b></td>");
	out.println("<td><b>date</b></td>");
	out.println("<td><b>time</b></td>");
	out.println("<td><b>place</b></td>");
	out.println("<td><b>max participant number</b></td>");
	out.println("</tr>");
	
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getInt(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("</tr>");
		//out.println(rs.getString(1)); //Consult_type
		//out.println(rs.getString(2)); //profname
		//out.println(rs.getInt(3)); //Cdate
		//out.println(rs.getString(4)); //ctime
		//out.println(rs.getString(5)); //consult_space
		//out.println(rs.getString(6)); //c_max_reserv_num
	}
	
	rs.close();
	pstmt.close();
%>
</body>
</html>