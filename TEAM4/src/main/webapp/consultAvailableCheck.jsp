<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>checking...</title>
<%
	request.setCharacterEncoding("UTF-8");
	String[] c = (String[]) session.getAttribute("c");
	String[] p = (String[]) session.getAttribute("p");
	String[] d = (String[]) session.getAttribute("d");
	String[] t = (String[]) session.getAttribute("t");
	String[] pl = (String[]) session.getAttribute("pl");
	int[] m = (int[]) session.getAttribute("m");
	String[] CNumIn = (String[])session.getAttribute("CNumIn");
	String[] CPIdIn = (String[])session.getAttribute("CPIdIn");
	int selectnum = Integer.parseInt(request.getParameter("select_num"));
	selectnum -= 1;
	session.setAttribute("selectnum", selectnum);
	//Consult_Type는 이미 지정 완료
	//CProfName는 이미 지정 완료
	session.setAttribute("Consult_date", d[selectnum]);
	session.setAttribute("Consult_time", t[selectnum]);
	session.setAttribute("Consult_Space", pl[selectnum]);
	session.setAttribute("Max", m[selectnum]);
	//이후에 사용할 것들
	session.setAttribute("CNum", CNumIn[selectnum]);
	session.setAttribute("CPId", CPIdIn[selectnum]);
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
   ResultSet rs;
   String sql;
   int cnt;
   ResultSetMetaData rsmd;
   Class.forName("oracle.jdbc.driver.OracleDriver");
   conn = DriverManager.getConnection(url, user, pass);
   conn.setAutoCommit(false); 
%>

</head>
<body>
<h1>checking...</h1>
<% //본인 정보
	//sql 순서가 들어가기 전에 체크를 해서 넘으면 내보내 에러랑 함께 내보내고 안 넘으면 받고,
	sql = "SELECT COUNT(*), C_Max_Reserv_Num FROM CONSULTATION WHERE CNum = '"+ CNumIn[selectnum] +"' GROUP BY CNum, C_Max_Reserv_Num";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = rs.getMetaData();
	rs.next();
	cnt = rsmd.getColumnCount();
	String countMember = rs.getString(1);
	String maxCount = rs.getString(2);
	rs.close();
	pstmt.close();
	if (Integer.parseInt(countMember) > Integer.parseInt(maxCount)){
		%><script>
			alert('This reservation is full reserved');
			document.location.href="main_student.jsp";
			</script>
		<%
	}
	else {
		response.sendRedirect("insert_info_student.jsp");
	}
	%>
</body>
</html>