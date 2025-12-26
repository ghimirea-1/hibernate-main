<%--
  Created by IntelliJ IDEA.
  User: colon
  Date: 11/24/25
  Time: 2:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Planner</title>
    <link rel="stylesheet" type="text/css" href="/hibernate/CSS/kitchenStyles.css">
    <style>
        #main {
            padding: 20px;
            transition: margin-left 0.4s ease;
        }

        body.shifted #main {
            margin-left: 250px;
        }

        /* Prevent content from being cut off */
        #main, #calendar {
            width: calc(100% - 250px);
            max-width: 100%;
        }
    </style>


</head>
<body class="homepage">
<c:import url ="header.jsp"/>
<div id="main">

    <header>
        <div id="planner-controls">
            <button id="btn-week">Week</button>
            <button id="btn-month">Month</button>
            <button id="btn-prev">←</button>
            <button id="btn-next">→</button>
        </div>
    </header>


    <section id="calendar-view"></section>
</div>


<script>
    // script code is mostly AI generated
    function toggleSidebar() {
        document.body.classList.toggle('sidebar-open');
        const sidebar = document.getElementById("sidebar");
        sidebar.style.width = document.body.classList.contains('sidebar-open') ? "250px" : "0";
    }

    function closeSidebar() {
        document.getElementById("sidebar").style.width = "0";
        document.getElementById("main").style.marginLeft = "0";
    }

    /* Calendar logic */
    let currentView = 'week';
    let currentDate = new Date();

    document.addEventListener('DOMContentLoaded', () => {
        renderCalendar();

        document.getElementById('btn-week').addEventListener('click', () => {
            currentView = 'week';
            renderCalendar();
        });

        document.getElementById('btn-month').addEventListener('click', () => {
            currentView = 'month';
            renderCalendar();
        });

        document.getElementById('btn-prev').addEventListener('click', () => {
            if (currentView === 'week') currentDate.setDate(currentDate.getDate() - 7);
            else currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar();
        });

        document.getElementById('btn-next').addEventListener('click', () => {
            if (currentView === 'week') currentDate.setDate(currentDate.getDate() + 7);
            else currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar();
        });
    });

    function renderCalendar() {
        const container = document.getElementById('calendar-view');
        container.innerHTML = '';

        // Month title
        const title = document.createElement('h3');
        title.style.textAlign = 'center';
        title.style.margin = '1rem 0';
        title.textContent = currentDate.toLocaleDateString('default', { month: 'long', year: 'numeric' });
        container.appendChild(title);

        // Day labels
        const daysRow = document.createElement('div');
        daysRow.className = 'calendar-grid';
        const dayNames = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
        dayNames.forEach(name => {
            const cell = document.createElement('div');
            cell.style.padding = '10px';
            cell.style.background = '#f0f0f0';
            cell.style.fontWeight = 'bold';
            cell.style.textAlign = 'center';
            cell.textContent = name;
            daysRow.appendChild(cell);
        });
        container.appendChild(daysRow);

        // Calendar grid
        currentView === 'week' ? renderWeek(container) : renderMonth(container);
    }

    function renderWeek(container) {
        const grid = document.createElement('div');
        grid.className = 'calendar-grid';
        const startOfWeek = new Date(currentDate);
        startOfWeek.setDate(currentDate.getDate() - currentDate.getDay());

        for (let i=0;i<7;i++){
            const dayDate = new Date(startOfWeek);
            dayDate.setDate(startOfWeek.getDate()+i);

            const cell = document.createElement('div');
            cell.style.border = '1px solid #ccc';
            cell.style.padding = '10px';
            cell.style.minHeight = '100px';
            cell.innerHTML = `<strong>${dayDate.getDate()}</strong>`;
            grid.appendChild(cell);
        }
        container.appendChild(grid);
    }

    function renderMonth(container) {
        const grid = document.createElement('div');
        grid.className = 'calendar-grid';
        grid.style.gridTemplateRows='repeat(6,1fr)';

        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();
        const firstDay = new Date(year, month, 1);
        const startDay = firstDay.getDay();

        const startDate = new Date(firstDay);
        startDate.setDate(firstDay.getDate()-startDay);

        for(let i=0;i<42;i++){
            const dayDate = new Date(startDate);
            dayDate.setDate(startDate.getDate()+i);

            const cell = document.createElement('div');
            cell.style.border='1px solid #ccc';
            cell.style.padding='10px';
            cell.style.minHeight='100px';
            cell.innerHTML=`<strong>${dayDate.getDate()}</strong>`;

            if(dayDate.getMonth()!==month) cell.style.opacity='0.5';
            grid.appendChild(cell);
        }
        container.appendChild(grid);
    }
</script>

</body>
</html>

