<%-- 
    Document   : principal_cliente
    Created on : 14/04/2017, 00:45:16
    Author     : Ramon Cordeiro
--%>

<%@page import="java.util.List"%>
<%@page import="util.Conf"%>
<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FRPTRANS - QUALIDADE EM TRANSPORTE</title>
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
       <link rel="stylesheet" type="text/css" href="http://localhost:8282/frptransportes/css/style.css"/>
    </head>
    <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">FRPTRANS</a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="index.html">FRPTRANS</a></li>
                        <li><a href="pages.html">Cadastre seu Frete</a></li>
                        <li><a href="posts.html">Consulte Seu Cadastro</a></li>
                        <li><a href="users.html">Pedidos</a></li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">                    
                        <li><a href="<%=Conf.getCaminhoContexto()%>ControleAcessoCliente?acao=Sair">Logout</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </nav>
		<header id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-10">	  
                        <h1><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> FRPTRANS</h1>

                    </div>
                </div>
        </header>
        <div class="panel panel-default">
            <div class="panel-heading main-color-bg">
                <h3 class="panel-title">Informações Administrativas</h3>
            </div>
        </div>
    <body>
        <%
            //recupera o usuario da sessao

            Cliente cliente = (Cliente) session.getAttribute("clienteAutenticado");
            List<Cliente> mostrar = (List<Cliente>) request.getAttribute("retornaCliente");

            if (cliente != null && mostrar == null) {
        %>
        
        <h3>Bem Vindo, <%= cliente.getLogin()%> !  </h3> 

        <h3>Digite seu CPF para consulta de seus dados</h3>
        <form action="<%=Conf.getCaminhoContexto()%>ControleCliente" method="POST">
            Cpf : <input type="text" required="" name="txtCpf"><br/>
            <br>
            <input type="submit" value="Consultar" name="acao" >

        </form>
        






        <%} else if (cliente != null && mostrar != null) {    %>

        <div class="table-responsive">
           <table class="table table-striped table-bordered table-hover">
             <thead>
            <th>Nome</th>
            <th>Data de nascimento</th>
            <th>Rg</th>
            <th>Celular</th>
            <th>Endereço</th>
            <th>Ações Relacionadas</th>

        </thead>

        <%
            for (Cliente r : mostrar) {
        %>

        <h1>Meus Dados:</h1> 

            <td><%=r.getNome()%></td>
            <td><%=r.getData_nasc()%></td>
            <td><%=r.getEmail()%></td>
            <td><%=r.getCelular()%></td>
            <td><%=r.getEndereco()%></td>
            <td><br><a href="<%=Conf.getCaminhoContexto()%>ControleCliente?acao=BuscarClienteEdicao&idCliente=<%=r.getId()%>">Alterar</a></br></td>








        </tr>


        <%}%>
    </table>
    <br></br>
    <button> <a href="<%=Conf.getCaminhoContexto()%>/cliente/principal_cliente.jsp"/>Voltar</a> </button>

<%}%>
 
    <footer id="footer">
        <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

    

    <script>
        CKEDITOR.replace('editor1');
    </script>
        <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
  <script src="js/jquery.js"></script>
  <script src="js/bootstrap.min.js"></script>




</body>
</html>
