<%-- 
    Document   : Cart
    Created on : Oct 21, 2023, 5:18:49 PM
    Author     : Fpt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Order Management</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="images/logo3.png">
        <link rel="stylesheet" href="css/styleCart.css">
    </head>

    <body>

        <div class="container mt-3">
            <div class="d-flex justify-content-between align-items-center">
                <a href="homeadmin" class="home-button">HOME</a>
                <div class="search-container">
                    <form class="form-inline" action="ordermanage" method="POST">
                        <input class="form-control mr-sm-2" type="text" name="key" placeholder="Search...">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </div>
        <c:if test="${empty ord}">
            <h1 style="text-align: center; font-size: 30px;
                font-weight: bold;
                margin-bottom: 40px;">Opp ! No foods were found with the words '<span style="color: red">${searchKey}</span>'.</h1> 
        </c:if>

        <div class="cart-content">
            <h2>Total Revenue: ${sum}$</h2>
            <h2>Profit: ${sum * 0.25}$</h2>
            <div>
                <table class="cart-table">
                    <tr class="cart-header-table">
                        <th>User_id</th>
                        <th>Date</th>
                        <th>address</th>
                        <th>phonenumber</th>
                        <th>totalmoney</th>
                        <th>Detail</th>

                    </tr>
                    <c:forEach items="${ord}" var="ord">
                        <tr class="cart-item">
                            <td>${ord.user_id}</td>
                            <td>${ord.date}</td>

                            <td>${ord.address}</td>
                            <td>${ord.phonenumber}</td>

                            <td>${ord.totalmoney}$</td>
                            <td>
                                <c:if test="${ord.status == 0}">
                                    <form action="shiporder" method="post">
                                        <input type="hidden" value="${ord.orderID}" name="orderID">
                                        <input type="submit" value="Ship">
                                    </form>
                                </c:if>
                                <c:if test="${ord.status == 2}">
                                    <button type="button" class="btn btn-success">Complete</button>
                                </c:if>

                            </td>

                        </tr>
                    </c:forEach>


                </table>
            </div>
        </div>





    </body>

</html>