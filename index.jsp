<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.util.*" %> 
<html>
        <head>
                <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
                <title>sunday tomcat</title>
                <meta name="Author" content="centos,yum,update" />
                <meta charset="utf-8" />
                <link rel="shortcut icon" href="images/itour.ico" />
        </head>
<body>
<br><br><br>
<% 

  //HttpSession session = request.getSession(true); 

  System.out.println(session.getId());

  //out.println("<br> SESSION ID:" + session.getId()+"<br>");

String serverName = request.getServerName();
int serverPort = request.getServerPort();
%>
<table width="80%" border="1" align="center">
    <tr>
        <th colspan=2>tomcat test by linwangyi</th>
    </tr>
    <tr>
        <td>服务器IP</td>
        <td><% String serverIP  = request.getLocalAddr();
		 out.print( serverIP);%></td> 
    </tr>
    <tr>
        <td>服务器tomcat端口</td>
        <td><% int serverPORT = request.getLocalPort();
		 out.print( serverPORT);%></td> 
    </tr>
	<tr>
        <td>访问主机名称</td>
        <td><%=serverName%></td>
    </tr>
    <tr>
        <td>访问端口</td>
        <td><%=serverPort%></td>
    </tr>
	<tr>
        <td>根目录绝对路径</td>
        <td><%out.print( application.getRealPath(request.getRequestURI()) );%> </td>
    </tr>
	<tr>
        <td>SESSION ID</td>
        <td><%=session.getId()%></td>
    </tr>

	<tr>
        <th colspan=2>客户端信息</th>
    </tr>
    <tr>
        <td>客户端IP</td>
        <td><%
			String USERHeader=request.getHeader("x-forwarded-for");
			if (USERHeader != null) {
				out.print( request.getHeader("x-forwarded-for") );
			} else {
					out.print( request.getRemoteAddr() );
			}
		%></td>
    </tr>
    <tr>
        <td>User-Agent信息</td>
        <td><% String USERAgent  = request.getHeader("User-Agent");
		 out.print( USERAgent);%></td> 
    </tr>
</table>
</body>
</html>