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
        <title>Food Shop</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/styleHome.css">
    </head>

    <body class="home-body">
        <div class="homeadmin-header main-header">
    <div class="header-left">
        <span style="font-size:1.2em;font-weight:bold;color:#ff5200;">FOOD SHOP</span>
    </div>
    <nav class="header-nav">
        <a href="home">HOME</a>
        <a href="cart">CART</a>
        <a href="About.jsp">ABOUT</a>
        <a href="#footer">CONTACT</a>
    </nav>
    <div class="header-right">
        <c:if test="${sessionScope.acc != null}">
            <form action="logout" method="post" style="margin:0;">
                <button type="submit" style="background:#ff5200;color:#fff;border:none;padding:8px 18px;border-radius:0;font-weight:600;cursor:pointer;">Logout</button>
            </form>
        </c:if>
        <c:if test="${sessionScope.acc == null}">
            <a href="Login.jsp" class="header-login-btn">Login</a>
        </c:if>
    </div>
</div>
        <div class="container-fluid padding">

            <div class="row">

                <!-- Đã xóa cột banner rỗng để sản phẩm chiếm full trang -->
                <div class="col-lg-12 col-md-12 col-sm-12 favorite">

                    <!-- Insert code favorite places here-->
                    <!--categories-->
                    <div class="nopadding form-table" style="display: flex;
                         justify-content: center;">
                        <ul id="list-option">
                            <li>
                                <form action="homesubservlet" method="post">
                                    <input type="hidden" name="category" value="-1">
                                    <input style="${tag == -1 ? 'color: #ff5200;box-shadow: 0 0 20px #ff5200' : ''}" type="submit" value="All">
                                </form>
                            </li>
                            <c:forEach items="${cat}" var="cat" >
                                <li>
                                    <form action="homesubservlet" method="post">
                                        <input type="hidden" name="category" value="${cat.id}">
                                        <input style="${tag == cat.id ? 'color: #ff5200;box-shadow: 0 0 20px #ff5200' : ''}" type="submit" value="${cat.name}">
                                    </form>
                                </li>
                            </c:forEach>   

                            <li class="list-option-search"> 
                                <form action="homesubservlet" method="post">
                                    <input type="hidden" name="category" value="-1">
                                    <input type="text" name="search" style="${tag == -1 ? "color: #ff5200;box-shadow: 0 0 20px #ff5200"  : ""}" maxlength="15">
                                    <button type="submit">Search</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                    <!--                    <form class="nopadding" action="" method="">
                                            
                                        </form>-->
                    <!--products-->
                    <c:if test="${empty prd}">
                        <h1 style="text-align: center; font-size: 30px;
                            font-weight: bold;
                            margin-bottom: 40px;">Opp ! No foods were found with the words '<span style="color: red">${searchKey}</span>'.</h1> 
                    </c:if>

                    <div class="product-grid">
    <c:forEach items="${prd}" var="prd" >   
        <div class="favorite-item-father">
            <div class="favorite-item">
                <img class="favorite-item-img nopadding" src="${prd.image_url}" alt="">
                <p style="margin: 0px">${prd.name}</p>
                <p style="margin: 0px">Sold: ${prd.quantity_sold}</p>
                <h3>${prd.price}$</h3>
                <c:if test="${sessionScope.acc != null}">
                    <form action="productdesservlet" method="post">
                        <input type="hidden" name="product" value="${prd.id}">
                        <input type="hidden" name="category" value="${prd.category_id}">
                        <input type="submit" value="View" style="">
                    </form>
                </c:if>
                <c:if test="${sessionScope.acc == null}">
                    <!--                                    <form action="login" method="">
                                                            <input type="submit" value="View">
                                                        </form>-->
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>

                </div>
            </div>
        </div> <!--Kết thúc container-fluid-->



        <div class="container-fluid" id="footer">
            <a href="home" class="home-button-footer">HOME</a>
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
