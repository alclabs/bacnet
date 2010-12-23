<%@ page import="com.controlj.experiment.bacnet.definitions.AnalogInputDefinition" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.data.BACnetObjectIdentifier" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.property.PropertyDefinition" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.*" %>
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int net = Integer.parseInt(request.getParameter("id"));

%>
<script type="text/javascript">
    function addDevice(id) {
        $("#tree").dynatree("getActiveNode").addChild({
            title: id,
            "id": id,
            childtype: "objects",
            icon: "../../../_common/lvl5/skin/graphics/type/hardware.gif",
            isLazy: true
        })
    }
</script>
<div>Network #<%= net %></div>
<div>
    Device Instance:&nbsp;<input type="text" id="devid">&nbsp;<button onclick="new function() { addDevice($('#devid').attr('value')); }">Add</button>
</div>