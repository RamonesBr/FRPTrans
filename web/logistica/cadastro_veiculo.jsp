<%-- 
    Document   : cadastro_veiculo
    Created on : 05/05/2017, 19:00:14
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
            </div>
        </header>
        <div class="panel panel-default">
            <div class="panel-heading main-color-bg">
                <h3 class="panel-title">Informações Administrativas</h3>
            </div>
        </div>
    <body>
    
        

        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {


        %>
        <font color="blue"><%=msg%></font>
        <% }%>

        <form action="<%=Conf.getCaminhoContexto()%>ControleVeiculo" method="POST">

  <div id="main" class="container-fluid">
 <h3 class="page-header">Cadastro Veiculos </h3>
 <form action="index.html">
  <!-- area de campos do form -->
  <div class="row">
 <div class="form-group col-md-4">
   <label for="campo1">Marca </label>
   <input type="text" class="form-control" name="txtMarca">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo2">Modelo</label>
   <input type="text" class="form-control" name="txtModelo">
   </div>
   <div class="form-group col-md-4">
   <label for="campo8">Cor</label>
   <input type="text" class="form-control" name="txtCor">
 </div>
</div>
<div class="row">
 <div class="form-group col-md-4">
   <label for="campo4">Placa</label>
   <input type="text" class="form-control" name="txtPlaca">
 </div>
 <div class="row">
 <div class="form-group col-md-4">
   <label for="campo9">Status</label>
   <input type="text" class="form-control" name="txtStatus">
 </div>
 </div>
 <div class="form-group col-md-4">
   <label for="campo9">Tipo</label>
   <input type="text" class="form-control" name="txtTipo">
 </div>
</div>
  <div class="row">
      <div class="form-group col-md-4">
      <label for="campo9">Ano</label>
   <input type="Date" class="form-control" name="txtAno">
 </div>
  </div>
            <br></br>
            <br></br>
            <br></br>

        </select><br/>

 <input type="submit" value="Cadastrar" name="acao" >
 <button>  <a href="<%=Conf.getCaminhoContexto()%>logistica/manter_veiculo.jsp">Voltar</button>
    
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
