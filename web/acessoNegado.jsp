<%-- 
    Document   : acessoNegado
    Created on : 23/03/2017, 16:09:21
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acesso Negado</title>
    </head>
    <body>
        <h1>Você não tem permissão de acesso...</h1>
        
        <a href="<%=Conf.getCaminhoContexto()%>/admin/principal_admin.jsp"> Voltar para o menu principal </a><br/>
    </body>
</html>
