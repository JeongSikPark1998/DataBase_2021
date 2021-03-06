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
	String id = (String)session.getAttribute("id");
	String uco = (String)session.getAttribute("uco");
%>

<%
   String serverIP = "localhost";
   String strSID = "orcl";
   String portNum = "1521";
   String user = "TEAM4";
   String pass = "1234";
   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
   Connection conn = null;
   PreparedStatement pstmt,pstmt2,pstmt3;
   ResultSet rs,rs2,rs3;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
%>
</head>
<body>
	<header id="header">
		<h1>CONSULTATION</h1>
		<nav>
			<ul>
				<li><a href="mypage_student.jsp">MY PAGE</a></li>
			</ul>
		</nav>
	</header>
	<form name="form" action="backend_searchConsultation.jsp" method="post">
		<h2>Search available Consultation Schedule</h2>
		<br> <br>
		<!-- select consult type by User (radio button) -->
		<fieldset>
			<legend>Fill out the form</legend>
			<input type="radio" name="Consult_Type" id="GENERAL" value="GENERAL">
			<label for="GENERAL">GENERAL</label> 
			<input type="radio" name="Consult_Type" id="FOLLOW" value="FOLLOW"> 
			<label for="FOLLOW">FOLLOW</label> 
			<input type="radio" name="Consult_Type" id="COURSE" value="COURSE"> <label for="COURSE">COURSE</label>
			<!-- insert Professor's first name -->
			<ul>
				<li><label for="CProfName">Professor's First Name: </label> 
				<input type="text" id="CProfName" name="CProfName"></li>
			</ul>
		</fieldset>
		<br>
		<!-- search available consultation that meets student's selection In button -->
		<div id="buttons">
			<input type="submit" value="SEARCH">
		</div>
		
	<h2>Follow Professor Consultation</h2>
	<%
	//보여주고 싶은 정보 가져다 쓰시면 됩니다!
	//혹시 몰라서 남겨뒀는데 이건 자신의 지도교수가 상담을 개설했을때 보여주는 겁니다.
	sql = "select consult_type, CProfName, CDate, CTime, Consult_Space, C_Max_Reserv_Num, CNum, CPId"
			+ " FROM CONSULTATION"
			+ " WHERE CPId = (SELECT TPId FROM FOLLOW_STUDENT WHERE TSId = '"+id+"')"
			+ " AND CSId = '0000000000' AND CSUco = '"+uco+"'";
	String sql3 = "select count(*) - 1, cnum"
			+ " FROM CONSULTATION"
			+ " WHERE CPId = (SELECT TPId FROM FOLLOW_STUDENT WHERE TSId = '"+id+"')"
			+ " GROUP By CNum";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	pstmt3 = conn.prepareStatement(sql3);
	rs3 = pstmt3.executeQuery();
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	
	//store data
	String[] c3 = new String[100];
	String[] p3 = new String[100];
	String[] d3 = new String[100];
	String[] t3 = new String[100];
	String[] pl3 = new String[100];
	int[] m3 = new int[100];
	String[] CNum3 = new String[100];
	String[] CPId3 = new String[100];
	int i = 0;
	String[] NowN = new String[100];
	
	StringTokenizer st;
	while(rs.next() && rs3.next()){
		c3[i] = rs.getString(1);
		p3[i] = rs.getString(2);
		d3[i] = rs.getString(3);
		st = new StringTokenizer(d3[i]);
		d3[i] = st.nextToken();
		t3[i] = rs.getString(4);
		pl3[i] = rs.getString(5);
		m3[i] = rs.getInt(6);
		CNum3[i] = rs.getString(7);
		CPId3[i] = rs.getString(8);
		NowN[i] = rs3.getString(1);
		i++;
	}
	int total_cnt = i;

	if(total_cnt > 0){
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
		out.println("<td>" + c3[i-1] + "</td>");//Consult_type
		out.println("<td>" + p3[i-1] + "</td>");//profname
		out.println("<td>" + d3[i-1] + "</td>");//Cdate
		out.println("<td>" + t3[i-1] + "</td>");//ctime
		out.println("<td>" + pl3[i-1] + "</td>");//consult_space
		out.println("<td>" + NowN[i-1] + "/" + m3[i-1] + "</td>");//c_max_reserv_num
		out.println("</tr>");
	}
	out.println("</table>");
	}
	
	rs.close();
	rs3.close();
	pstmt.close();
	pstmt3.close();
%>
<h2>Course Professor Consultation</h2>
<%
	//보여주고 싶은 정보 가져다 쓰시면 됩니다!
	//자신이 수강하는 과목의 교수님의 상담을 보여줍니다.
	sql = "select consult_type, CProfName, CDate, CTime, Consult_Space, C_Max_Reserv_Num, CNum, CPId"
			+" FROM CONSULTATION"
			+" WHERE CPId IN (SELECT DISTINCT CId FROM COURSE_REGISTRATION"
			+"		 WHERE CRco IN (SELECT CRco FROM COURSE_REGISTRATION"
			+"				 WHERE CId = '"+id+"')"
			+"		 AND CRFco = (SELECT SFco FROM STUDENT"
			+"				 WHERE SId = '"+id+"')"
			+"		 AND CRUco = '"+uco+"'"
			+"		 AND Role = 'p')"
			+" AND CSId = '0000000000' AND CSUco = '"+uco+"'"
			+" AND consult_type = 'COURSE'";
	sql3 = "select count(*) - 1, cnum"
		+ " FROM CONSULTATION"
		+" WHERE CPId IN (SELECT DISTINCT CId FROM COURSE_REGISTRATION"
		+"		 WHERE CRco IN (SELECT CRco FROM COURSE_REGISTRATION"
		+"				 WHERE CId = '"+id+"')"
		+"		 AND CRFco = (SELECT SFco FROM STUDENT"
		+"				 WHERE SId = '"+id+"')"
		+"		 AND CRUco = '"+uco+"'"
		+"		 AND Role = 'p')"
		+ " GROUP By CNum";
	pstmt2 = conn.prepareStatement(sql);
	rs2 = pstmt2.executeQuery();
	pstmt3 = conn.prepareStatement(sql3);
	rs3 = pstmt3.executeQuery();
	
	rsmd = rs2.getMetaData();
	cnt = rsmd.getColumnCount();
	
	//store data
	String[] c2 = new String[100];
	String[] p2 = new String[100];
	String[] d2 = new String[100];
	String[] t2 = new String[100];
	String[] pl2 = new String[100];
	int[] m2 = new int[100];
	String[] CNum2 = new String[100];
	String[] CPId2 = new String[100];
	i = 0;
	String[] NowC = new String[100];
	
	while(rs2.next() && rs3.next()){
		c2[i] = rs2.getString(1);
		p2[i] = rs2.getString(2);
		d2[i] = rs2.getString(3);
		st = new StringTokenizer(d2[i]);
		d2[i] = st.nextToken();
		t2[i] = rs2.getString(4);
		pl2[i] = rs2.getString(5);
		m2[i] = rs2.getInt(6);
		CNum2[i] = rs2.getString(7);
		CPId2[i] = rs2.getString(8);
		NowC[i] = rs3.getString(1);
		i++;
	}
	total_cnt = i;
	
	//print
	if(total_cnt>0){
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
			out.println("<td>" + c2[i-1] + "</td>");//Consult_type
			out.println("<td>" + p2[i-1] + "</td>");//profname
			out.println("<td>" + d2[i-1] + "</td>");//Cdate
			out.println("<td>" + t2[i-1] + "</td>");//ctime
			out.println("<td>" + pl2[i-1] + "</td>");//consult_space
			out.println("<td>" + NowC[i-1] + "/" + m2[i-1] + "</td>");//c_max_reserv_num
			out.println("</tr>");
		}
		out.println("</table>");
	}
	
	rs2.close();
	rs3.close();
	pstmt2.close();
	pstmt3.close();
	//
%>
	</form>
</body>
</html>
