<%@ page import="com.controlj.green.addonsupport.bacnet.data.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.data.datetime.*" %>
<%@ page import="com.controlj.green.addonsupport.bacnet.object.ScheduleDefinition" %>
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
<div>Schedule page</div>
<%!
    private static final SimpleDateFormat hourMinuteFormatter = new SimpleDateFormat("HH:mm");
    private static final SimpleDateFormat mdyFormatter = new SimpleDateFormat("MM/dd/yy");
    private static final String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    private static final String[] months = {"January", "February", "March", "April", "May", "June", "July",
            "August", "September", "October", "November", "December"};


    public String formatTime(BACnetTime time) {
        if (time.isSimpleTime()) {
            return hourMinuteFormatter.format(time.asDate());
        }
        else {
            return "Time is too complex";
        }
    }

    public String stringFromAny(BACnetAny any) {
        if (any instanceof BACnetBoolean) {
            return ((BACnetBoolean)any).getValue() ? "Occupied" : "Unoccupied";
        } else if (any instanceof BACnetEnumerated) {
            int value = ((BACnetEnumerated) any).asInt();
            return (value == 1) ? "Occupied" : "Unoccupied";
        } else if (any instanceof BACnetUnsigned) {
            // MultiStateValue
            return ((BACnetUnsigned)any).getBigInteger().toString();
        } else if (any instanceof BACnetNull) {
            return "NULL";
        } else {
            return any.toString();
        }
    }

    public String getNameForDayOfWeek(int num) {
        if (num > 7 || num < 1) {
            return "Bad encoding for day of week!";
        }
        return days[num-1];
    }

    public String getNameForMonth(int num) {
        if (num > 12 || num < 1) {
            return "Bad encoding for month!";
        }
        return months[num-1];
    }

    public String getSmallOrdinal(int num) {
        if (num == 1) { return "1st"; }
        else if (num == 2) { return "2nd"; }
        else if (num == 3) { return "3rd"; }
        else { return num + "th"; }
    }

    public String formatBACnetDate(BACnetDate date) {
        StringBuilder result = new StringBuilder();
        if (date.isSimpleDate()) {
            result.append(mdyFormatter.format(date.asDate()));
        } else {
            DateRule rule = date.getDateRule();

            switch (rule.getDayRule()) {
                case ANY:
                    break; // don't add anything for this case

                case DAY_OF_WEEK:
                    result.append("Every ");
                    result.append(getNameForDayOfWeek(rule.getDayOfWeekNumber()));
                    break;

                case LAST_OF_MONTH:
                    result.append("Last day of the month");
                    break;

                case FIXED:
                    result.append("Day ");
                    result.append(rule.getDay());
                    result.append(" of the month");
                    break;
            }

            switch (rule.getMonthRule()) {
                case ANY:
                    break; // don't add anything for this case

                case EVEN:
                    result.append(" in even months");
                    break;

                case ODD:
                    result.append(" in odd months");
                    break;

                case FIXED:
                    result.append(" in ");
                    result.append(getNameForMonth(rule.getMonthNum()));
                    break;
            }

            switch (rule.getYearRule()) {
                case ANY:
                    if (rule.getDayRule() == DayRule.ANY &&
                        rule.getMonthRule() == MonthRule.ANY) {
                        result.append("Every day");
                    }
                    break;

                case FIXED:
                    result.append(" in ");
                    result.append(rule.getYear());
                    break;
            }
        }
        return result.toString();
    }

    public String describeCalendarEntry(BACnetCalendarEntry entry) {
        StringBuilder result = new StringBuilder();
        switch (entry.getChoice()) {
            case date:
                result.append(formatBACnetDate(entry.getDate()));
                break;

            case dateRange:
                BACnetDateRange range = entry.getDateRange();
                result.append(formatBACnetDate(range.getStartDate()));
                result.append(" - ");
                result.append(formatBACnetDate(range.getEndDate()));
                break;

            case weekNDay:
                BACnetWeekNDay wnd = entry.getWeekNDay();
                if (wnd.getDayOfWeekRule() == AnyRule.ANY) {
                    result.append("Any day");
                } else {
                    int dow = wnd.getDayOfWeek().getNum();
                    result.append(getNameForDayOfWeek(dow));
                }


                switch (wnd.getWeekRule()) {
                    case ANY:
                        result.append(" any week");
                        break;

                    case LAST:
                        result.append(" last week of month");
                        break;

                    case FIXED:
                        result.append(" ");
                        result.append(getSmallOrdinal(wnd.getWeekNumber()));
                        result.append(" week of month");
                }

                result.append(" in ");
                switch (wnd.getMonthRule()) {
                    case ANY:
                        result.append("every month");
                        break;

                    case EVEN:
                        result.append("every even month");
                        break;

                    case ODD:
                        result.append("every odd month");
                        break;

                    case FIXED:
                        result.append(getNameForMonth(wnd.getMonthNumber()));
                        break;
                }
                break;
        }

        return result.toString();
    }


    public String getExceptionScheduleCell(BACnetSpecialEvent event) {
        StringBuilder result = new StringBuilder();
        if (event.getPeriodChoice() == BACnetSpecialEvent.PeriodChoice.periodReference) {
            result.append("<div>Period = Calendar Reference (unsupported)</div>");
        } else {
            result.append("<div>Period = "+ describeCalendarEntry(event.getPeriod()) +"</div>");
        }
        result.append("<div>Priority = "+ event.getEventPriority().asInt()+ "</div>");
        BACnetList<BACnetTimeValue> tvs = event.getTimeValues();
        for (BACnetTimeValue tv : tvs) {
            result.append("<div>");
            result.append(formatTime(tv.getTime()));
            result.append(" - ");
            result.append(stringFromAny(tv.getValue()));
            result.append("</div>");
        }

        return result.toString();
    }
%>
<%
    int objIdNum = Integer.parseInt(request.getParameter("id"));
    int devInstanceNum = Integer.parseInt(request.getParameter("devid"));

    BACnetConnection conn = BACnet.getBACnet().getDefaultConnection();
    BACnetAccess bacnet = conn.getAccess();

    BACnetDevice device = bacnet.lookupDevice(devInstanceNum).get();
    BACnetObjectIdentifier objId = new BACnetObjectIdentifier(objIdNum);
    ReadPropertiesResult result = device.readProperties(objId, ScheduleDefinition.objectName,
            ScheduleDefinition.weeklySchedule, ScheduleDefinition.exceptionSchedule).get();
%>
<table>
    <tr>
        <td>Name:</td>
        <td><%= result.getValue(objId, ScheduleDefinition.objectName).getValue() %></td>
    </tr>
    <tr>
        <td>Weekly Schedule:</td>
        <td>
            <%
                BACnetArray<BACnetDailySchedule> dailySchedules =
                        result.getValue(objId, ScheduleDefinition.weeklySchedule);
                if (! dailySchedules.isEmpty()) {
            %>
            <table cellpadding="0" cellspacing="0" id="vborders">
                <tr>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                    <th>Sunday</th>
                </tr>
                <%
                    for (BACnetDailySchedule day : dailySchedules) {
                %>
                <td>
                    <%
                    for (BACnetTimeValue tv : day.getTimeValues()) {
                    %>
                    <div><%= formatTime(tv.getTime())%> - <%= stringFromAny(tv.getValue()) %></div>
                    <% } %>
                </td>
                <% } %>
            </table>
            <% } %>
        </td>
    </tr>

    <tr>
        <td>Exception Schedules:</td>
    <tr>
    <%

        BACnetArray<BACnetSpecialEvent> exceptionSchedules =
            result.getValue(objId, ScheduleDefinition.exceptionSchedule);
        for (BACnetSpecialEvent event : exceptionSchedules) {
    %>
    <tr>
        <td>&nbsp;</td>
        <td class="excell"><%= getExceptionScheduleCell(event) %></td>
    </tr>
    <% } %>
</table>