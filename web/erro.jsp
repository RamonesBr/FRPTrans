<%-- 
    Document   : erro
    Created on : 23/03/2017, 16:09:31
    Author     : Ramon Cordeiro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error page</title>
    </head>
    <body>
        <h1>Erro !!!</h1>
        <%= ((Exception) request.getAttribute("erro")).getMessage() %>
                
        
    </body>
</html>
