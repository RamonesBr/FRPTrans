<%-- 
    Document   : teste
    Created on : 24/04/2017, 20:21:25
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            //recupera o usuario da sessao
            
           
            Cliente cliente2  = (Cliente) request.getAttribute("retornaCliente");
            
            if(cliente2 ==null){ //VAI MOGI!
         %>
          
          
        
           <form action="<%=Conf.getCaminhoContexto()%>ControleCliente" method="POST">
            Cpf : <input type="text" name="txtCpf"><br/>
            
            <input type="submit" value="Consultar" name="acao" >
            
          
            
            

               
       
            <%

          cliente2.getCpf();
          cliente2.getNome();
          cliente2.getEndereco();
          cliente2.getCelular();
          
}
          
                
          
          %>
            </form>
        
        
    </body>
</html>
