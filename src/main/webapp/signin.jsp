<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profiles</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <script src="https://kit.fontawesome.com/4995ef5a6c.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/hibernate/CSS/kitchenStyles.css">



</head>
<body class = "profiles-page">

<i class="bi bi-house-heart-fill" style="font-size: 64px; color:#fff;"></i>
<h1 style="color:#fff">click your profile</h1><br><br>

<div class="container">

    <div class="profile-card" onclick="openLogin()">
        <!--<img src="valentin.jpg">-->
        <br><br>
        <i class="fas fa-heart" style="font-size: 30px;"></i>
        <h2>Valentin</h2>
        <p>Click to enter Valentin's page</p>
    </div>

    <div class="profile-card" onclick="openLogin()">
        <!--<img src="skyler.jpg">-->
        <br><br>
        <i class="fas fa-star" style="font-size: 30px;"></i>
        <h2>Skyler</h2>
        <p>Click to enter Skyler's page</p>
    </div>

</div>

<!-- background and login popup -->

<div class="background-div" id="background-div"onclick="closeLogin()"></div>
<div class="login-popup" id="login-popup">
    <span class="close-btn" onclick="closeLogin()">x</span>
    <h2>Please Login</h2>
    <form action="login" method="post">
        <label>Username: </label>
        <input type="text" name="username" value="" required><br><br>

        <label>Password: </label>
        <input type="password" name="password" required><br><br>

        <button type="submit" name="login">login</button>
    </form>


</div>

<script>
    function openLogin() {
        const popup = document.getElementById("login-popup");
        const bg = document.getElementById("background-div");

        popup.classList.add("show");
        bg.classList.add("show");

        // Temporarily use display block to trigger transition
        popup.style.display = "block";
        bg.style.display = "block";

        // Use requestAnimationFrame to ensure transition is applied
        requestAnimationFrame(() => {
            popup.classList.add("show");
            bg.classList.add("show");
        });
    }

    function closeLogin() {
        const popup = document.getElementById("login-popup");
        const bg = document.getElementById("background-div");

        popup.classList.remove("show");
        bg.classList.remove("show");

        // Wait for animation to finish before hiding completely
        setTimeout(() => {
            popup.style.display = "none";
            bg.style.display = "none";
        }, 300); // Match the transition duration
    }


</script>

</body>

</html>