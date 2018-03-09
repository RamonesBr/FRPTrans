<%-- 
    Document   : cadastro_usuario
    Created on : 23/03/2017, 16:08:31
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <title>FRPTRANS - Qualidade em Transporte</title>
  
  <!-- Bootstrap CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet">
  <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<br>
<br>

 <h3 class="page-header">Cadastro Cliente</h3>
 
        
        <form action="<%=Conf.getCaminhoContexto()%>ControleCliente" method="POST">
             <div id="main" class="container-fluid">
 
  <!-- area de campos do form -->
  <div class="row">
 <div class="form-group col-md-4">
   <label for="campo1">Nome </label>
   <input type="text" class="form-control" name="txtNome">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo2">Login</label>
   <input type="text" class="form-control" name="txtLogin">
 </div>
  </div>
</div>
<div class="row">
 <div class="form-group col-md-4">
   <label for="campo4">Senha</label>
   <input type="password" class="form-control" name="txtSenha">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo5">CPF</label>
   <input type="text" class="form-control" name="txtCpf">
 </div>
 <div class="form-group col-md-4">
   <label for="campo6">Endereço</label>
   <input type="text" class="form-control" name="txtEndereco">
 </div>
 
 </div>
</div>
<div class="row">
 <div class="form-group col-md-4">
   <label for="campo7">Data de Nascimento</label>
   <input type="Date" class="form-control" name="txt_Data_Nasc">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo8">E-mail</label>
   <input type="text" class="form-control" name="txtEmail">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo9">Celular</label>
   <input type="Tel" class="form-control" name="txtCelular">
 </div>
</div>

  <hr />
  <div id="actions" class="row">
    <div class="col-md-12">
      <button type="submit" value="Cadastrar" name="acao" class="btn btn-primary">Salvar</button>
      <buton> <a href="principal.jsp" class="btn btn-default">Cancelar</a></buton>
      <button> <a href="<%=Conf.getCaminhoContexto()%>principal.jsp" class="btn btn-default">Voltar</a> </button>
    </div>
  </div>
    <%
            String msg = (String) request.getAttribute("msg");
            if(msg != null){
               
        %>
        <font color="blue"><%=msg %></font>
       
        <% } %>
</form>
<nav class="navbar navbar-inverse navbar-fixed-top">
<div id="main" class="container-fluid">
  <div class="navbar-header">
 
   <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
    <span class="sr-only">Toggle navigation</span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
   </button>
   <a class="navbar-brand" href="#">FRPTRANS</a>
  </div>
  <div id="navbar" class="navbar-collapse collapse">
   <ul class="nav navbar-nav navbar-right">
    <li><a href="#">Início</a></li>
    <li><a href="#">Opções</a></li>
    <li><a href="#">Minha Conta</a></li>
    <li><a href="#">Ajuda</a></li>
    <li><a href="<%=Conf.getCaminhoContexto()%>ControleAcessoCliente?acao=Sair">Sair</a></li>
	


   </ul>
  </div>
 </div>
</nav>
  

  <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
 
  
  <script src="js/jquery.js"></script>
  <script src="js/bootstrap.min.js"></script>
</body>
</html>