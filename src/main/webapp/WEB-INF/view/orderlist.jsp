<%@ page language="java" isELIgnored="false" contentType="text/html;charset=utf-8"
                pageEncoding="utf-8" %>
       <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
       <html lang="en">
       <head>
           <title>Restaurant Web Order System</title>
           <meta charset="utf-8">
           <meta name="viewport" content="width=device-width, initial-scale=1">
           <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
           <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
           <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
           <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

               <style>
                    #order_detail_no {width: 200px;}
                    #menu_name {width: 200px;}
                    #order_detail_no {width: 200px;}
                    table {text-align: center; border: 1px solid #dddddd}
                    thead {background-color: #fafafa; text-align: center;}
               </style>
       </head>
       <body>
        <br>
     <div class="container">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="/terminal.do">Terminal</a>
                            </li>
                            <li class="nav-item active">
                                <a class="nav-link" href="/order.do">Kitchen</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/ledge.do">Ledge<span class="sr-only">(current)</span></a>
                            </li>
                            <c:if test="${sessionScope.user.user_type == 'admin'}">
                            <li><a class="nav-link" href="/user.do">User</a></li>
                            <li><a class="nav-link" href="/menu.do">Menu</a></li>
                            </c:if>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">

                            <c:if test="${not empty sessionScope.user.user_login}">
                                <li class="active"><a class="nav-link" href="#"><c:out value="${sessionScope.user.user_login}"/></a></li>
                                <li><a class="nav-link" href="/logout">Sign out</a></li>
                            </c:if>
                        </ul>
            </nav>
        <br>

           <h2>Kitchen Page</h2>
           <hr/>


           <table class="table" style="text-align: center; border: 1px solid #dddddd" id="mytable">
               <thead>
               <tr>
                   <th>Order No.</th>
                   <th>Waiter</th>
                   <th>Order</th>
                   <th>Message</th>
                   <th>Cooking status</th>
                   <th>Action</th>
               </tr>
               </thead>
               <tbody>
                   <c:forEach items = "${orderList}" var = "data">
                       <tr id="mycell">
                       <input type="hidden" class="order_detail_id" value="${data.order_detail_id}"/>
                           <td><b>${data.order_id}</b> - ${data.order_detail_id}</td>
                           <td>${data.user_name}</td>
                           <td>${data.menu_name}</td>
                           <td>${data.message}</td>
                           <td id="cooking_status" class="cooking_status">${data.cooking_status}</td>
                           <td>
                                <button class="btn btn-danger btn-order-fire">Fire</button>
                                <button class="btn btn-success btn-order-serve">Serve</button>
                           </td>
                       </tr>
                   </c:forEach>
               </tbody>
           </table>
       </div>
   </body>

 <script type="text/javascript">
 $(function(){
	 $(".btn-order-fire").click(function(){
		 var cooking_status = $(this).parent().parent().find("td.cooking_status").text();
		 var order_detail_id = $(this).parent().parent().find("input.order_detail_id").val();
		 $(this).parent().parent().find("td.cooking_status").text("Started");
		 $(this).parent().parent().css("background-color","E1FFCB");
		 $.ajax({
		      type: "get",
		      url: "./orders/" + order_detail_id + "?cooking_status=Started",
		      contentType: 'application/json',
		      dataType: "json", // return type
		      success: function (response) {
		    	  console.log(response);
		      }
		    });
	 })
	 $(".btn-order-serve").click(function(){
		 var cooking_status = $(this).parent().parent().find("td.cooking_status").text();
		 var order_detail_id = $(this).parent().parent().find("input.order_detail_id").val();
		 if ("Started" == cooking_status) {
		 	$(this).parent().parent().remove();
			 $.ajax({
			      type: "get",
			      url: "./orders/" + order_detail_id + "?cooking_status=Served",
			      contentType: 'application/json',
			      dataType: "json", // return type
			      success: function (response) {
			    	  console.log(response);
			      }
			    });
		 }
	 })
 })
 </script>  
</html>