<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log In</title>
    <style type="text/css">
        body     { background-color:black; color:#A8A8A8; font-family:arial, sans-serif; }
        .welcome { height:100px; text-align:center; font-size:24px; }
        .label   { font-size: 18px; font-weight:bold; }
        .col1    { text-align:right; }
        .col3    { text-align:left; vertical-align:middle; height:60px; }
        .in      { width:15em; }
        #submit  { background-color:#A8A8A8; margin-left:20px; padding-left:4px; padding-right:4px; }
    </style>
</head>
<body style="height:100%" scroll="NO" onload="document.getElementById('name').focus()">
<form method="POST" action="j_security_check">
    <table border=0 cellpadding=0 cellspacing=0 style="width:100%; height:100%; vertical-align:middle; border:solid #A8A8A8 1px;">
      <tr>
         <td align="left">&nbsp;</td>
         <td width="100px">
            <table class="login" border=0 cellpadding=0 cellspacing=0 >
              <tr>
                  <td>&nbsp;</td>
                  <td class="welcome" colspan="1">Please Log In</td>
                  <td>&nbsp;</td>
              </tr>
              <tr>
                  <td class="col1 label">Name:&nbsp;&nbsp;</td>
                  <td class="col2"><input id="name" class="in" type="text" tabindex="1" name="j_username" size="25" maxlength="80"></td>
                  <td rowspan="2" class="col3">&nbsp;&nbsp;<input type="submit" id="submit" value="Log in" tabindex="3"/></td>
              </tr>
              <tr>
                  <td class="col1 label">Password:&nbsp;&nbsp;</td>
                  <td class="col2"><input class="in" type="password" tabindex="2" name="j_password" size="25" maxlength="80"></td>
              </tr>
            </table>
         </td>
         <td align="right">&nbsp;</td>
      </tr>
    </table>
</form>
</body>
</html>