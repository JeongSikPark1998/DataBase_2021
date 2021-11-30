<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Modify Faculty and Course</title>

<%
	request.setCharacterEncoding("UTF-8");
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

<%	//새로운 과목 추가 개설
	int flag = 0;
	conn.setAutoCommit(false);
	String ICName = request.getParameter("ICName");
	String ICCode = request.getParameter("ICCode");
	String ICFCo = request.getParameter("ICFCo");
	String uco = (String)session.getAttribute("uco2");
	sql = "INSERT INTO COURSE VALUES('"+ICName+"', '" + ICCode + "', '" +ICFCo+"','"+uco+"')";
	//sql = "INSERT INTO COURSE VALUES('"+ICName+"', (SELECT MAX(CCode) + 1 FROM COURSE WHERE CUCO = '" + uco + "' and CFCo = '" + ICFCo +"'), '" +ICFCo+"','"+uco+"')";
	pstmt = conn.prepareStatement(sql);
	try {
		pstmt.executeQuery();
	} catch (Exception e) {
		flag = 1;
		%>
		   <script>
		      alert('There is a problem.\nPress this button to go main page.');
		      document.location.href="backend_adminSeeFacultyAndCourse.jsp";
		   </script>
		<%
	}
	if (flag == 0) {
		conn.commit();
		response.sendRedirect("backend_adminSeeFacultyAndCourse.jsp");
		pstmt.close();
	}
%>


</body>
</html>