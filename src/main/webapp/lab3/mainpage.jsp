<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ page import="auxiliaryclasses.ConstantsClass" %><%--
  Created by IntelliJ IDEA.
  User: ывв
  Date: 26.02.2018
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Journals</title>
    <style type="text/css">
        <%@include file="../bootstrap/css/bootstrap.min.css"%>
    </style>
    <script type="text/javascript">
        function filterType() {
            var select = document.getElementById("type");
            var type = select.options[select.selectedIndex].value;
            switch (type) {
                case "" :
                    document.getElementById("liketype").value = "";
                    document.getElementById("equalstype").value = "";
                    document.getElementById("liketype").disabled = true;
                    document.getElementById("equalstype").disabled = true;
                    break;
                case "like":
                    document.getElementById("liketype").disabled = false;
                    document.getElementById("equalstype").value = "";
                    document.getElementById("equalstype").disabled = true;
                    break;
                case "equals":
                    document.getElementById("equalstype").disabled = false;
                    document.getElementById("liketype").value = "";
                    document.getElementById("liketype").disabled = true;
                    break;
            }
        }

        function buttonClick(x) {
            switch (x.id) {
                case "add":
                    document.getElementById("hid").value = "Add";
                    document.forms[0].submit();
                    break;
                case "edit":
                    document.getElementById("hid").value = "Update";
                    document.forms[0].submit();
                    break;
                case "delete":
                    var radios = document.getElementsByName("usernumber");
                    var checked = false;
                    for (var i = 0; i < radios.length; i++) {
                        if (radios[i].checked) {
                            checked = true;
                            break;
                        }
                    }
                    if (checked) {
                        if (confirm("Are you sure want to delete this journal?")) {
                            document.getElementById("hid").value = "Delete";
                            document.forms[0].submit();
                        }
                    }
                    else {
                        alert("Select a journal to perform an action!")
                    }
                    break;
                case "choose" :
                    document.getElementById("hid").value = "Choose";
                    document.forms[0].submit();
                    break;
                case "sort":
                    if (document.getElementById("sortcolumn").value.localeCompare("") == 0 ||
                        document.getElementById("sortcriteria").value.localeCompare("") == 0)
                        alert("Choose column and criterion to perform a sorting!");
                    else {
                        document.getElementById("hid").value = "Sort";
                        document.forms[0].submit();
                    }
                    break;
                case "allvals":
                    document.getElementById("hid").value = "allvals";
                    document.forms[0].submit();
                    break;
                case "reload":
                    document.getElementById("hid").value = "reload";
                    document.forms[0].submit();
                    break;
            }
        }
    </script>
</head>
<body>
<%
    Boolean isSorted = request.getAttribute(ConstantsClass.IS_SORTED) == null ? false : (Boolean) request.getAttribute(ConstantsClass.IS_SORTED);
%>
<div align="center"><strong>JOURNALS</strong></div>
<form method="post" action="<%=ConstantsClass.JOURNAL_SERVLET_ADDRESS%>" role="form">
    <div class="form-group">
        <input type="hidden" id="hid" name=<%=ConstantsClass.USERACTION%>>
        <input type="hidden" name="<%=ConstantsClass.ACTION%>" value=<%=ConstantsClass.DO_CRUD_FROM_JOURNAL%>>

        <table class="table">
            <tr>
                <th>№</th>
                <th>Name</th>
                <th>Description</th>
            </tr>
            <x:parse xml="${sessionScope.journalContainer}" var="container"/>
            <x:forEach select="$container/journalContainer/journals/entry" var="journal">
                <tr>
                    <td>
                        <label>
                            <input type="radio" class="form-control" name="<%=ConstantsClass.USERNUMBER%>"
                                   value="<x:out select="$journal/value/id"/>"/>
                        </label>
                    </td>
                    <td>
                        <x:out select="$journal/value/name"/>
                    </td>
                    <td>
                        <x:out select="$journal/value/description"/>
                    </td>
                </tr>
            </x:forEach>
        </table>
        <div align="center">
            <table>
                <tr>
                    <td><input type="button" class="btn btn-outline-success"
                               id="choose" value="Choose journal"
                               onclick="buttonClick(this)">
                    </td>
                    <td><input type="button" class="btn btn-outline-success"
                               id="add" value="Add journal"
                               onclick="buttonClick(this)">
                    </td>
                    <td><input type="button" class="btn btn-outline-success"
                               id="edit" value="Edit journal"
                               onclick="buttonClick(this)">
                    </td>
                    <td><input type="button" class="btn btn-outline-success"
                               id="delete" value="Delete journal"
                               onclick="buttonClick(this)">
                    </td>
                </tr>
            </table>
        </div>
        <div align="center">
            <table>
                <tr>
                    <td>Sort by:</td>
                    <td>
                        <select class="form-control" name="<%=ConstantsClass.SORT_COLUMN%>"
                                id="<%=ConstantsClass.SORT_COLUMN%>">
                            <option value=""></option>
                            <option value="<%=ConstantsClass.HIBERNATE_NAME%>">
                                Name
                            </option>
                            <option value="<%=ConstantsClass.HIBERNATE_DESCRIPTION%>">
                                Description
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Criterion:
                    </td>
                    <td>
                        <select class="form-control" name="<%=ConstantsClass.SORT_CRITERIA%>"
                                id="<%=ConstantsClass.SORT_CRITERIA%>">
                            <option value=""></option>
                            <option value="<%=ConstantsClass.SORT_ASC%>">
                                Ascending
                            </option>
                            <option value="<%=ConstantsClass.SORT_DESC%>">
                                Descending
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Choose filter:
                    </td>
                    <td>
                        <select class="form-control" id="type" onchange="filterType()">
                            <option value=""></option>
                            <option value="like">
                                Like
                            </option>
                            <option value="equals">
                                Equals
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Like:
                    </td>
                    <td>
                        <input class="form-control" type="text" id="liketype" name="<%=ConstantsClass.FILTER_LIKE%>"
                               value="<%=request.getAttribute(ConstantsClass.FILTER_LIKE)==null?"":request.getAttribute(ConstantsClass.FILTER_LIKE)%>"
                               disabled>
                    </td>
                </tr>
                <tr>
                    <td>
                        Equals:
                    </td>
                    <td>
                        <input type="text" class="form-control" id="equalstype" name="<%=ConstantsClass.FILTER_EQUALS%>"
                               value="<%=request.getAttribute(ConstantsClass.FILTER_EQUALS)==null?"":request.getAttribute(ConstantsClass.FILTER_EQUALS)%>"
                               disabled>
                    </td>
                </tr>
            </table>
            <%
                if (isSorted) {
            %>
            <div align="center">
                <input type="button" class="btn btn-outline-primary" id="allvals" value="Show all values"
                       onclick="buttonClick(this)">
            </div>
            <%
                }
            %>
            <div align="center">
                <input type="button" class="btn btn-outline-success" id="sort" value="Sort"
                       onclick="buttonClick(this)">
            </div>
        </div>
    </div>
</form>
<div align="center">
    <%=
    request.getAttribute(ConstantsClass.MESSAGE_ATTRIBUTE) == null ? "" : request.getAttribute(ConstantsClass.MESSAGE_ATTRIBUTE)
    %>
</div>
</body>
</html>
