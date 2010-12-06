<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Log in failed</title>
    <style type="text/css">
        body  { background-color:black; color:#A8A8A8; font-family:arial, sans-serif; }
        .main { height:100px; text-align:center; font-size:24px; }
        .centered { text-align:center; }
        #button { background-color:#A8A8A8; text-align:center; margin-top:80px;}
    </style>
</head>
<body style="height:100%" >

<table border=0 cellpadding=0 cellspacing=0 style="width:100%; height:100%; vertical-align:middle; border:solid #A8A8A8 1px;">
  <tr>
     <td align="left">&nbsp;</td>
     <td class="centered" >
        <table class="centered" border=0 cellpadding=0 cellspacing=0 >
          <tr>
              <td class="main">Log In Failed</td>
          </tr>
          <tr>
               <td><%= request.getAttribute("loginerr")%></td>
          </tr>
          <tr>
              <td><form><input id="button" type="button" value="Try Again" onclick="history.go(-1);return true;"></form></td>
          </tr>
        </table>
     </td>
     <td align="right">&nbsp;</td>
  </tr>
</table>
</body>
</html>