<%@ page import="com.controlj.experiment.bacnet.definitions.AnalogInputDefinition" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.data.BACnetObjectIdentifier" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.property.PropertyDefinition" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.*" %>
<%--
Copyright (c) 2010, Automated Logic Corporation
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Automated Logic Corporation nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL AUTOMATED LOGIC CORPORATION BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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