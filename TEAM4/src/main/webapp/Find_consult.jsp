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
	String cousult_type = request.getParameter("Consult_type");
    String pname = request.getParameter("pname"); //교수 이름
    String id = request.getParameter("id"); //학생 아이디
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

<% //Consult_type에 따른 쿼리
	if (cousult_type.equals("COURSE")) {
		sql = "select C.consult_type, C.C_Max_Reserv_Num, C.CTime, C.CProfName, C.CDate "
				+ "from consultation C "
				+ "where cprofname = '" + pname + "' "
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
	else if (cousult_type.equals("FOLLOW")) {//학생이 지도교수를 맞게 신청하면 보임
		sql = "select C.consult_type, C.C_Max_Reserv_Num, C.CTime, C.CProfName, C.CDate "
			+ "from consultation C, follow_student "
			+ "where tpid = cpid and tsid = csid "
			+ "and cprofname = '" + pname + "' "
			+ "and csid = '" + id + "' "
			+ "and C_max_reserv_Num > (select count(*) from consultation "
			+				"where cnum = C.cnum "
			+				"group by cnum)";
	}
	else {
		sql = "select C.consult_type, C.C_Max_Reserv_Num, C.CTime, C.CProfName, C.CDate "
				+ "from consultation C"
				+ "where cprofname = '" + pname + "' "
				+ "and C_max_reserv_Num > (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum)";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	while(rs.next()){
		out.println(rs.getString(1)); //Consult_type
		out.println(rs.getString(2)); //max_reserv_num
		out.println(rs.getString(3)); //Ctime
		out.println(rs.getString(4)); //profname
		out.println(rs.getInt(5)); //cdate
	}
	rs.close();
	pstmt.close();
%>


</body>
</html>