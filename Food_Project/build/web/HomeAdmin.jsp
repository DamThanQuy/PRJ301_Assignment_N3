<%-- 
    Document   : Home
    Created on : Oct 21, 2023, 1:22:52 AM
    Author     : Fpt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Admin Home</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/logo3.png">
        <link rel="stylesheet" href="css/styleHome.css">
        <link rel="stylesheet" href="css/styleEditProduct.css">
    </head>

    <body id="body">

        <!-- Modern Admin Header -->
        <div class="homeadmin-header">
            <div class="header-left">
                <!-- Logo hoặc Admin -->
                <span style="font-size:1.2em;font-weight:bold;color:#ff5200;">ADMIN</span>
            </div>
            <nav class="header-nav">
                <a href="homeadmin">HOME</a>
                <a href="loadaddproduct">ADD PRODUCTS</a>
                <a href="usermanage">Users Manage</a>
                <a href="ordermanage">Orders Manage</a>
                <c:if test="${sessionScope.acc != null}">
                    <!-- <a href="logout">Logout</a> -->
                </c:if>
                <c:if test="${sessionScope.acc == null}">
                    <a href="Login.jsp">Login</a>
                </c:if>
            </nav>
            <div class="header-right">
                <c:if test="${sessionScope.acc != null}">
                    <form action="logout" method="post" style="margin:0;">
                        <button type="submit" style="background:#ff5200;color:#fff;border:none;padding:8px 18px;border-radius:0;font-weight:600;cursor:pointer;">Logout</button>
                    </form>
                </c:if>
            </div>
        </div>

        <!-- Main Content Container -->
        <div class="homeadmin-container">
            <!-- Category Filter/Search -->
            <div class="category-list">
    <form action="homeadminsubservlet" method="post" style="display:inline-block;">
        <input type="hidden" name="category" value="-1">
        <input style="${tag == -1 ? 'color: #ff5200;box-shadow: 0 0 20px #ff5200' : ''}" type="submit" value="All">
    </form>
    <c:forEach items="${cat}" var="cat" >
        <form action="homeadminsubservlet" method="post" style="display:inline-block;">
            <input type="hidden" name="category" value="${cat.id}">
            <input style="${tag == cat.id ? 'color: #ff5200;box-shadow: 0 0 20px #ff5200'  : ''}" type="submit" value="${cat.name}">
        </form>
    </c:forEach>   
    <form class="list-option-search" action="homeadminsubservlet" method="post" style="display:inline-block;">
        <input type="hidden" name="category" value="-1">
        <input type="text" name="search" placeholder="Search product..." style="${tag == -1 ? 'color: #ff5200;box-shadow: 0 0 20px #ff5200'  : ''}">
        <button type="submit">Search</button>
    </form>
</div>

            <!-- Product List -->
            <div class="admin-product-list">
                <c:forEach items="${prd}" var="prd">
                    <div class="admin-product-card">
                        <img src="${prd.image_url}" alt="">
                        <p>${prd.name}</p>
                        <p>Sold: ${prd.quantity_sold}</p>
                        <h3>${prd.price}$</h3>
                        <c:if test="${sessionScope.acc != null}">
                            <form action="editproduct" method="post">
                                <input type="hidden" name="product" value="${prd.id}">
                                <input type="hidden" name="category" value="${prd.category_id}">
                                <input type="submit" value="Edit">
                            </form>
                        </c:if>
                        <c:if test="${sessionScope.acc == null}">
                            <form action="login" method="get">
                                <input type="submit" value="View">
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="container-fluid" id="footer">
            <a href="#body" class="home-button-footer">HOME</a>
            <div class="row">

                <div class="footer">

                    <p>Email : group4@fpt.edu.vn</p>
                    <p>Address: FPTU Campus HCM</p>
                    <h5>&copy; Copyright FoodParadise.FPT</h5>
                </div>

            </div>

        </div>
    </body>

</html>
