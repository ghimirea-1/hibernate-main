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
    <title>Recipes</title>

    <script src="https://kit.fontawesome.com/4995ef5a6c.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/CSS/kitchenStyles.css">

    <style>
        /* Basic styles omitted for brevity */
        #main { padding: 20px; }
        .add-button-container { display: flex; justify-content: space-between; padding: 20px; }
        .add-button-container input, .add-button-container select { padding: 10px; width: 220px; border: 1px solid #ccc; border-radius: 6px; }
        .card-container { display: flex; flex-wrap: wrap; gap: 20px; }
        .card { background: white; border-radius: 8px; padding: 16px; width: 220px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        .card.green  { background-color: #d4edda; }
        .card.yellow { background-color: #fff3cd; }
        .card.red    { background-color: #f8d7da; }
        .card-buttons { display: flex; justify-content: space-between; margin-top: 10px; }
        .icon-btn { background: none; border: none; cursor: pointer; font-size: 22px; }
        .modal-popup { display: none; position: fixed; z-index: 20; width: 350px; background-color: #ffffff; border-radius: 15px; text-align: left; padding: 20px; top: 50%; left: 50%; transform: translate(-50%, -50%) scale(0.9); opacity: 0; transition: opacity 0.3s ease, transform 0.3s ease; box-shadow: 0 4px 10px rgba(0,0,0,0.25); }
        .modal-popup.show { display: block; opacity: 1; transform: translate(-50%, -50%) scale(1); }
        .modal-popup input, .modal-popup textarea { width: 100%; padding: 8px; margin-top: 6px; margin-bottom: 10px; border-radius: 5px; border: 1px solid #ccc; }
        .modal-popup button { padding: 10px 20px; background-color: #466300; color: white; cursor: pointer; border: none; border-radius: 5px; }
        .background-div { display: none; position: fixed; z-index: 15; height: 100%; width: 100%; background-color: rgba(0,0,0,0.25); opacity: 0; transition: opacity 0.3s ease; }
        .background-div.show { display: block; opacity: 1; }
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
        <input type="text" id="searchInput" placeholder="Search recipes..." onkeyup="filterCards()">

        <select id="categoryFilter" onchange="filterCards()">
            <option value="">All Recipes</option>
            <sql:query dataSource="${db}" var="rsCategory">
                SELECT DISTINCT recipe_category FROM Recipe;
            </sql:query>
            <c:forEach var="row" items="${rsCategory.rows}">
                <option value="${row.recipe_category}">${row.recipe_category}</option>
            </c:forEach>
        </select>

        <button class="icon-btn" onclick="openAddPopup()">
            <i class="fa-solid fa-circle-plus"></i>
        </button>
    </div>

    <!-- Add Recipe Popup -->
    <div class="modal-popup" id="addPopup">
        <span class="close-btn" onclick="closePopups()">×</span>
        <h2>Add Recipe</h2>
        <form action="addRecipe" method="post">
            <label>Recipe Name:</label>
            <input type="text" name="recipe_name" required>

            <label>Category:</label>
            <input type="text" name="recipe_category" required>

            <label>Instructions:</label>
            <textarea name="recipe_instructions" required></textarea>

            <label>Ingredients (comma-separated):</label>
            <input type="text" name="ingredient_list" placeholder="e.g., Eggs, Flour, Milk" required>

            <button type="submit">Add Recipe</button>
        </form>
    </div>

    <!-- Edit Recipe Popup -->
    <div class="modal-popup" id="editPopup">
        <span class="close-btn" onclick="closePopups()">×</span>
        <h2>Edit Recipe</h2>
        <form action="editRecipe" method="post">
            <input type="hidden" name="recipe_id" id="edit-id">

            <label>Recipe Name:</label>
            <input type="text" name="recipe_name" id="edit-recipe_name" required>

            <label>Category:</label>
            <input type="text" name="recipe_category" id="edit-recipe_category" required>

            <label>Instructions:</label>
            <textarea name="recipe_instructions" id="edit-recipe_instructions" required></textarea>

            <label>Ingredients (comma-separated):</label>
            <input type="text" name="ingredient_list" id="edit-ingredient_list" required>

            <button type="submit">Save Changes</button>
        </form>
    </div>

    <!-- Recipe Cards -->
    <div class="card-container">
        <sql:query dataSource="${db}" var="rs">
            SELECT * FROM Recipe;
        </sql:query>

        <c:forEach var="row" items="${rs.rows}">
            <div class="card green">
                <h3><c:out value="${row.recipe_name}" /></h3>
                <p>Category: <c:out value="${row.recipe_category}" /></p>
                <p>Instructions: <c:out value="${row.recipe_instructions}" /></p>
                <p>Ingredients: <c:out value="${row.ingredient_list}" /></p>

                <div class="card-buttons">
                    <!-- EDIT BUTTON -->
                    <button class="icon-btn"
                            onclick="openEditPopup(
                                    '${row.recipe_id}',
                                    '${row.recipe_name}',
                                    '${row.recipe_category}',
                                    '${row.recipe_instructions}',
                                    '${row.ingredient_list}'
                                    )">
                        <i class="fa-solid fa-pen"></i>
                    </button>

                    <!-- DELETE BUTTON -->
                    <form action="deleteRecipe" method="post" onsubmit="return confirm('Delete this Recipe?');">
                        <input type="hidden" name="id" value="${row.recipe_id}">
                        <button type="submit" class="icon-btn">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>

</div>

<script>
    const bg = document.querySelector(".background-div");

    function openAddPopup() {
        document.getElementById("addPopup").classList.add("show");
        bg.classList.add("show");
    }

    function openEditPopup(id, name, category, instructions, ingredientList) {
        document.getElementById("edit-id").value = id;
        document.getElementById("edit-recipe_name").value = name;
        document.getElementById("edit-recipe_category").value = category;
        document.getElementById("edit-recipe_instructions").value = instructions;
        document.getElementById("edit-ingredient_list").value = ingredientList;

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

        const cards = document.querySelectorAll(".card");
        cards.forEach(card => {
            let matches = true;

            const name = card.querySelector("h3").textContent.toLowerCase();
            if (query && !name.includes(query)) matches = false;

            const catText = card.querySelector("p:nth-of-type(1)").textContent.toLowerCase();
            const cardCategory = catText.replace("category: ", "");
            if (category && cardCategory !== category) matches = false;

            card.style.display = matches ? "block" : "none";
        });
    }
</script>

</body>
</html>
