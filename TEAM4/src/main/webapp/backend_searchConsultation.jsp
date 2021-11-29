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
	<form name="form" action="insert_info_student.jsp" method="post">
<% 
	//Consult_type에 따른 쿼리
	if (Consult_Type.equals("COURSE")) {
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num, C.CNum, C.CPId "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and csid = '" + id + "' "
				+ "and C_max_reserv_Num >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum) "
				+ "and cpid in (select co2.cid from course_registration co2 "
				+ "				where (co2.crco, co2.crfco, co2.cruco) in (select co3.crco, co3.crfco, co3.cruco "
				+ "											from course_registration co3 "
				+ "											where cid = '" + id + "') "
				+ "				and co2.role = 'p')"
				+ "and C.CSId = '0000000000'";
	}
	else if (Consult_Type.equals("FOLLOW")) {//학생이 지도교수를 맞게 신청하면 보임
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num, C.CNum, C.CPId "
			+ "from consultation C, follow_student "
			+ "where tpid = cpid and tsid = csid "
			+ "and cprofname = '" + CProfName + "' "
			+ "and csid = '" + id + "' "
			+ "and C_max_reserv_Num >= (select count(*) from consultation "
			+				"where cnum = C.cnum "
			+				"group by cnum)"
			+ "and C.CSId = '0000000000'";
	}
	else {
		sql = "select C.consult_type, C.CProfName, C.CDate, C.CTime, C.Consult_Space, C.C_Max_Reserv_Num, C.CNum, C.CPId  "
				+ "from consultation C "
				+ "where cprofname = '" + CProfName + "' "
				+ "and C_max_reserv_Num >= (select count(*) from consultation "
				+				"where cnum = C.cnum "
				+				"group by cnum)"
				+ "and C.CSId = '0000000000'";
	}
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	
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
	
	StringTokenizer st;
	while(rs.next()){
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
	out.println("<th>max participant number</th>");
	
	for(i=1; i<=total_cnt; i++){
		out.println("<tr>");
		out.println("<td>" + i + "</td>");
		out.println("<td>" + c[i-1] + "</td>");//Consult_type
		out.println("<td>" + p[i-1] + "</td>");//profname
		out.println("<td>" + d[i-1] + "</td>");//Cdate
		out.println("<td>" + t[i-1] + "</td>");//ctime
		out.println("<td>" + pl[i-1] + "</td>");//consult_space
		out.println("<td>" + m[i-1] + "</td>");//c_max_reserv_num
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
	session.setAttribute("CNum", CNum);
	session.setAttribute("CPId", CPId);
	
	rs.close();
	pstmt.close();
%>
	</form>
</body>
</html>