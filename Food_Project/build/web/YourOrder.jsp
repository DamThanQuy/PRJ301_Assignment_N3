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
        <title>Your Order</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>

        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.min.css" rel="stylesheet"/>
        <!-- Embed css here-->
        <link rel="stylesheet" href="css/styleCart.css">
        <link rel="shortcut icon" href="images/logo3.png">

    </head>

    <body>

        <a href="home" class="home-button">HOME</a>
        <div class="cart-content">
            <div>
                <table class="cart-table">
                    <tr class="cart-header-table">
                        <th>Date</th>
                        <th>address</th>
                        <th>phonenumber</th>
                        <th>totalmoney</th>
                        <th>Status</th>
                        <th>Detail</th>
                    </tr>
                    <c:forEach items="${ord}" var="ord" >
                        <tr class="cart-item">
                            <td>${ord.date}</td>
                            
                            <td>${ord.address}</td>
                            <td>${ord.phonenumber}</td>
                            
                            <td>${ord.totalmoney}$</td>
                            <c:if test="${ord.status == 0}">
                                <td>Shipping...</td>
                             </c:if>
                             <c:if test="${ord.status == 2}">
                                <td>Complete!</td>
                             </c:if>
                            <td>
                                <form action="seedetail" method="post">
                                    <input type="hidden" value="${ord.orderID}" name="orderID">
                                    <input type="submit" value="Detail">
                                </form>
                            </td>
                            
                        </tr>
                    </c:forEach>
                    

                </table>
            </div>
        </div>





    </body>

</html>