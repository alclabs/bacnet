<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  ~ Copyright (c) 2010 Automated Logic Corporation
  ~
  ~ Permission is hereby granted, free of charge, to any person obtaining a copy
  ~ of this software and associated documentation files (the "Software"), to deal
  ~ in the Software without restriction, including without limitation the rights
  ~ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  ~ copies of the Software, and to permit persons to whom the Software is
  ~ furnished to do so, subject to the following conditions:
  ~
  ~ The above copyright notice and this permission notice shall be included in
  ~ all copies or substantial portions of the Software.
  ~
  ~ THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  ~ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  ~ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  ~ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  ~ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  ~ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  ~ THE SOFTWARE.
  --%>

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