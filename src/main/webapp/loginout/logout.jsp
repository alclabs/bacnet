<%@ page import="com.controlj.green.addonsupport.web.SingleSignOn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><%
    System.out.println("About to log out");
    SingleSignOn.logout(request);
%>
<html>
<head>
  <title>Log in failed</title>
    <style type="text/css">
        body  { background-color:black; color:#A8A8A8; font-family:arial, sans-serif; }
        a     { color:#A8A8A8; }
        .main { height:100px; text-align:center; font-size:24px; }
        .centered { text-align:center; }
    </style>
</head>
<body style="height:100%" >

<table border=0 cellpadding=0 cellspacing=0 style="width:100%; height:100%; vertical-align:middle; border:solid #A8A8A8 1px;">
  <tr>
     <td align="left">&nbsp;</td>
     <td class="centered" >
        <table class="centered" border=0 cellpadding=0 cellspacing=0 >
          <tr>
              <td class="main">Log out successful</td>
          </tr>
          <tr>
               <td><a href="<%= request.getContextPath()%>">Log in again</a></td>
          </tr>
        </table>
     </td>
     <td align="right">&nbsp;</td>
  </tr>
</table>
</body>
</html>