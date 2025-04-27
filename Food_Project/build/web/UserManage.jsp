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
    <title>User Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="images/logo3.png">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>

    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.min.css" rel="stylesheet"/>
    <style>
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .home-button {
            margin: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
    <!-- MDB -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.1.0/mdb.umd.min.js"></script>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

    <a href="homeadmin" class="home-button">HOME</a>
    <div class="cart-content">
        <div>
            <table class="cart-table">
                <tr class="cart-header-table">
                    <th>User ID</th>
                    <th>User Name</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Delete/Ban</th>
                </tr>
                <c:forEach items="${user}" var="user">
                    <tr class="cart-item">
                        <form id="updateForm${user.user_id}" action="updateuserinformation" method="post">
                            <td>${user.user_id}</td>
                            <td><input type="text" name="username" value="${user.username}"></td>
                            <td><input type="text" name="fullname" value="${user.fullname}"></td>
                            <td><input type="text" name="email" value="${user.email}"></td>
                            <td><input type="text" name="phone" value="${user.phone_number}"></td>
                            <td>
                                <input type="hidden" name="user_id" value="${user.user_id}">
                                <c:if test="${user.user_id != 1}">
                                    <button type="button" class="button" data-toggle="modal" data-target="#updateModal${user.user_id}" style="background-color: blue">
                                        Update
                                    </button>
                                    <button type="button" class="button" data-toggle="modal" data-target="#deleteModal${user.user_id}">
                                        Delete
                                    </button>
                                </c:if>
                            </td>
                        </form>
                    </tr>
                    
                    <!-- Update Confirmation Modal -->
                    <div class="modal fade" id="updateModal${user.user_id}" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel${user.user_id}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="updateModalLabel${user.user_id}">Confirm Update</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    Are you sure you want to update user ${user.username}?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary" onclick="document.getElementById('updateForm${user.user_id}').submit();">Update</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Confirmation Modal -->
                    <div class="modal fade" id="deleteModal${user.user_id}" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel${user.user_id}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteModalLabel${user.user_id}">Confirm Delete</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    Are you sure you want to delete user ${user.username}?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <a href="deleteuser?user_id=${user.user_id}" class="btn btn-danger">Delete</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </table>
        </div>
    </div>

</body>

</html>
