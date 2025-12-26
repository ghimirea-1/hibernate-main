<%--
  Created by IntelliJ IDEA.
  User: colon
  Date: 11/25/25
  Time: 12:58 PM
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="java.util.Date, java.util.Map" %>
<%@ page import="java.time.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pantry</title>

    <script src="https://kit.fontawesome.com/4995ef5a6c.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/Users/colon/Desktop/hibernate/src/main/webapp/CSS/kitchenStyles.css">
    <style>
        #main { padding: 20px; }

        .add-button-container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
        }

        .add-button-container input,
        .add-button-container select {
            padding: 10px;
            width: 220px;
            border: 1px solid #ccc;
            border-radius: 6px;

        }

        .exp-filter {
            font-size: 10px
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card {
            background: white;
            border-radius: 8px;
            padding: 16px;
            width: 220px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .card.green  { background-color: #d4edda; }
        .card.yellow { background-color: #fff3cd; }
        .card.red    { background-color: #f8d7da; }

        .card-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .icon-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 22px;
        }

        /* Popup Modal */
        .modal-popup {
            display: none;
            position: fixed;
            z-index: 20;
            width: 350px;
            background-color: #ffffff;
            border-radius: 15px;
            text-align: left;
            padding: 20px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.9);
            opacity: 0;
            transition: opacity 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 10px rgba(0,0,0,0.25);
        }

        .modal-popup.show {
            display: block;
            opacity: 1;
            transform: translate(-50%, -50%) scale(1);
        }

        .modal-popup input {
            width: 100%;
            padding: 8px;
            margin-top: 6px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .modal-popup button {
            padding: 10px 20px;
            background-color: #466300;
            color: white;
            cursor: pointer;
            border: none;
            border-radius: 5px;
        }


        .background-div {
            display: none;
            position: fixed;
            z-index: 15;
            height: 100%;
            width: 100%;
            background-color: rgba(0,0,0,0.25);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .background-div.show {
            display: block;
            opacity: 1;
        }

    </style>
</head>
<body class="homepage">

<div class="background-div" id="background-div" onclick="closePopups()"></div>

<c:import url="header.jsp" />

<!-- Database Connection -->
<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:8889/ADVJAVAPROJ?useSSL=false&serverTimezone=UTC"
                   user="root" password="root" />

<div id="main">

    <div class="add-button-container">
        <input type="text" id="searchInput" placeholder="Search pantry..." onkeyup="filterCards()">

        <select id="categoryFilter" onchange="filterCards()">
            <option value="">All Categories</option>
            <sql:query dataSource="${db}" var="rs">
                SELECT * FROM Pantry_Item;
            </sql:query>
            <c:forEach var="row" items="${rs.rows}">
                <option value="${row.item_category}">${row.item_category}</option>
            </c:forEach>
        </select>

        <label class="exp-filter">
            <input type="checkbox" id="expiringSoon" onchange="filterCards()"> Expiring in 7 days
        </label>

        <button class="icon-btn" onclick="openAddPopup()">
            <i class="fa-solid fa-circle-plus"></i>
        </button>
    </div>

    <!-- Add Pantry Item Popup -->
    <div class="modal-popup" id="addPopup">
        <span class="close-btn" onclick="closePopups()">×</span>
        <h2>Add Pantry Item</h2>

        <form action="addPantryItem" method="post">
            <label>Item Name:</label>
            <input type="text" name="item_name" required>

            <label>Category:</label>
            <input type="text" name="item_category" required>

            <label>Quantity:</label>
            <input type="number" name="item_quantity" required>

            <label>Unit:</label>
            <input type="text" name="item_unit" required>

            <label>Last Bought:</label>
            <input type="date" name="last_bought" required>

            <label>Expiration Date:</label>
            <input type="date" name="exp_date" required>

            <button type="submit">Add Item</button>
        </form>
    </div>

    <!-- Edit Pantry Item Popup -->
    <div class="modal-popup" id="editPopup">
        <span class="close-btn" onclick="closePopups()">×</span>
        <h2>Edit Pantry Item</h2>

        <form action="editPantryItem" method="post">
            <input type="hidden" name="id" id="edit-id">

            <label>Item Name:</label>
            <input type="text" name="item_name" id="edit-item_name" required>

            <label>Category:</label>
            <input type="text" name="item_category" id="edit-item_category" required>

            <label>Quantity:</label>
            <input type="number" name="item_quantity" id="edit-item_quantity" required>

            <label>Unit:</label>
            <input type="text" name="item_unit" id="edit-item_unit" required>

            <label>Last Bought:</label>
            <input type="date" name="last_bought" id="edit-last_bought" required>

            <label>Expiration Date:</label>
            <input type="date" name="exp_date" id="edit-exp_date" required>

            <button type="submit">Save Changes</button>
        </form>
    </div>

    <!-- Pantry Cards -->
    <div class="card-container">
        <sql:query dataSource="${db}" var="rs">
            SELECT * FROM Pantry_Item;
        </sql:query>

        <c:forEach var="row" items="${rs.rows}">
            <%
                LocalDateTime expLDT = (LocalDateTime) ((Map) pageContext.findAttribute("row")).get("exp_date");
                Date expDate = Date.from(expLDT.atZone(ZoneId.systemDefault()).toInstant());
                Date nowDate = new Date();

                long expTime = expDate.getTime();
                long nowTime = nowDate.getTime();
                long oneWeek = 7L * 24 * 60 * 60 * 1000;

                String colorClass;
                if (expTime < nowTime) colorClass = "red";
                else if (expTime - nowTime <= oneWeek) colorClass = "yellow";
                else colorClass = "green";
            %>

            <div class="card <%= colorClass %>">
                <h3><c:out value="${row.item_name}" /></h3>
                <p>Category: <c:out value="${row.item_category}" /></p>
                <p>Quantity: <c:out value="${row.item_quantity}" /> <c:out value="${row.item_unit}" /></p>
                <p>Last bought: <c:out value="${row.last_bought}" /></p>
                <p>Exp: <c:out value="${row.exp_date}" /></p>

                <div class="card-buttons">

                    <!-- EDIT BUTTON -->
                    <button class="icon-btn"
                            onclick="openEditPopup(
                                    '${row.item_id}',
                                    '${row.item_name}',
                                    '${row.item_category}',
                                    '${row.item_quantity}',
                                    '${row.item_unit}',
                                    '${row.last_bought}',
                                    '${row.exp_date}'
                                    )">
                        <i class="fa-solid fa-pen"></i>
                    </button>

                    <!-- DELETE BUTTON -->
                    <form action="deletePantryItem" method="post"
                          onsubmit="return confirm('Delete this pantry item?');">
                        <input type="hidden" name="id" value="${row.item_id}">
                        <button type="submit" class="icon-btn">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </form>

                </div>
            </div>
        </c:forEach>
    </div>

</div>

<!-- JavaScript code is AI Generated -->
<script>
    const bg = document.querySelector(".background-div");

    function openAddPopup() {
        document.getElementById("addPopup").classList.add("show");
        bg.classList.add("show");
    }

    function openEditPopup(id, name, category, quantity, unit, lastBought, expDate) {
        document.getElementById("edit-id").value = id;
        document.getElementById("edit-item_name").value = name;
        document.getElementById("edit-item_category").value = category;
        document.getElementById("edit-item_quantity").value = quantity;
        document.getElementById("edit-item_unit").value = unit;
        document.getElementById("edit-last_bought").value = lastBought;
        document.getElementById("edit-exp_date").value = expDate;

        document.getElementById("editPopup").classList.add("show");
        bg.classList.add("show");
    }

    function closePopups() {
        document.getElementById("addPopup").classList.remove("show");
        document.getElementById("editPopup").classList.remove("show");
        bg.classList.remove("show");
    }

    function filterCards() {
        const query = document.getElementById("searchInput").value.toLowerCase();
        const category = document.getElementById("categoryFilter").value.toLowerCase();
        const expiringSoon = document.getElementById("expiringSoon").checked;

        const cards = document.querySelectorAll(".card");

        cards.forEach(card => {
            let matches = true;

            // Name
            const name = card.querySelector("h3").textContent.toLowerCase();
            if (query && !name.includes(query)) {
                matches = false;
            }

            // Category
            const catText = card.querySelector("p:nth-of-type(1)").textContent.toLowerCase();
            const cardCategory = catText.replace("category: ", "");
            if (category && cardCategory !== category) {
                matches = false;
            }

            // Expiring within 7 days
            if (expiringSoon) {
                const expText = card.querySelector("p:nth-of-type(4)").textContent.replace("Exp: ", "");
                const expDate = new Date(expText);
                const now = new Date();

                const diff = expDate - now;
                const oneWeek = 7 * 24 * 60 * 60 * 1000;

                if (diff > oneWeek || diff < 0) {
                    matches = false;
                }
            }

            // Show or hide
            card.style.display = matches ? "block" : "none";
        });
    }


</script>

</body>
</html>
