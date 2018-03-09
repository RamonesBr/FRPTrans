<%-- 
    Document   : altera_cadastro_veiculo
    Created on : 12/05/2017, 11:00:36
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page import="model.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FRPTRANS - QUALIDADE EM TRANSPORTE</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
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
                        <li><a href="#"></a></li>
                        <li><a href="../login_cliente.jsp">Logout</a></li>
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
            Cliente cliente = (Cliente) request.getAttribute("clienteEdicao");
        %>
       
        <h1>Altere seus Dados</h1>

        <form action="<%=Conf.getCaminhoContexto()%>ControleCliente" method="POST">
 <div class="row">
 <div class="form-group col-md-4">
   <label for="campo1">Nome </label>
   <input type="text" value="<%=cliente.getNome()%>" class="form-control" name="txtNome">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo2">Data Nascimento</label>
   <input type="text" value="<%=cliente.getData_nasc()%>" class="form-control" name="txtData_Nasc">
   </div>
   <div class="form-group col-md-4">
   <label for="campo8">Email</label>
   <input type="text" value="<%=cliente.getEmail()%>" class="form-control" name="txtEmail">
 </div>
</div>
<div class="row">
 <div class="form-group col-md-4">
   <label for="campo4">Celular</label>
   <input type="text" value="<%=cliente.getCelular()%>" class="form-control" name="txtCelular">
 </div>
 <div class="form-group col-md-4">
   <label for="campo6">Endereço</label>
   <input type="text" value="<%=cliente.getEndereco()%>" class="form-control" name="txtEndereco">
 </div>
 
 </div>

            
            <input type="text" hidden name ="txtCpf" value="<%=cliente.getCpf()%>"></br>
            



            <input type="submit" value="Alterar" name="acao" > 
            <button> <a href="<%=Conf.getCaminhoContexto()%>cliente/principal_cliente.jsp">Voltar</a> </button>





        </form>
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
