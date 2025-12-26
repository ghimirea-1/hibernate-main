<%--
  Created by IntelliJ IDEA.
  User: colon
  Date: 11/24/25
  Time: 10:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>

<%
    String user = (String) session.getAttribute("username");
    String headerContent = (String) request.getAttribute("headerContent");
    if (headerContent == null) headerContent = "";
%>

<%!
    public String todaysDate() {
        Date date = new Date();
        SimpleDateFormat fullFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy");
        return "Today is " + fullFormat.format(date);
    }
%>

<link rel="stylesheet" type="text/css" href="/hibernate/CSS/kitchenStyles.css">
<script src="https://kit.fontawesome.com/4995ef5a6c.js" crossorigin="anonymous"></script>

<style>


    body {
        margin: 0;
        overflow-x: hidden; /* Prevent horizontal scroll */
        transition: margin-left 0.4s ease;
    }

    /* Sidebar */
    .sidebar {
        height: 100%;
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #446110;
        overflow-x: hidden;
        transition: width 0.4s ease;
        padding-top: 60px;
        z-index: 10;
    }

    .sidebar h2 {
        color: white;
        text-align: center;
    }

    .sidebar a {
        padding: 10px 20px;
        text-decoration: none;
        color: white;
        display: block;
        transition: background 0.3s;
    }

    .sidebar a:hover {
        background-color: #78a130;
    }

    .closebtn {
        position: absolute;
        top: 10px;
        right: 20px;
        font-size: 28px;
        color: white;
        cursor: pointer;
    }

    /* Header */
    #header {
        background-color: #78a130;
        color: white;
        padding: 15px 20px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        transition: margin-left 0.4s ease;
    }

    #header h2, #header h3 {
        margin: 0 10px;
    }

    /* When sidebar opens */
    body.shifted #header {
        margin-left: 250px;
    }

    body.shifted {
        margin-left: 250px;
    }
</style>

<!-- Sidebar -->
<div id="sidebar" class="sidebar">
    <a href="javascript:void(0)" class="closebtn" onclick="toggleSidebar()">&times;</a>
    <h2>Menu</h2>
    <a href="recipes.jsp">Recipes</a>
    <a href="homepage.jsp">Planner</a>
    <a href="pantry.jsp">Pantry</a>
    <a href="profilePage.jsp">Profile</a>
</div>

<!-- Header -->
<div id="header">
    <span style="font-size:30px; cursor:pointer;" onclick="toggleSidebar()">&#9776;</span>
    <div>
        <h2>Online Kitchen</h2>
        <h3>Welcome, <%= user %>!</h3>
        <h3><%= todaysDate() %></h3>
    </div>
</div>

<script>

    document.body.classList.add('sidebar-open');


    function toggleSidebar() {
        document.body.classList.toggle('sidebar-open');
        const sidebar = document.getElementById("sidebar");
        sidebar.style.width = document.body.classList.contains('sidebar-open') ? "250px" : "0";
    }

</script>

