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
    </head>
    <body>
        <%
            Cliente cliente = (Cliente) request.getAttribute("clienteEdicaoAdm");
        %>
        <br>
        <br>
        <br>
        <br>
        <h1>Altere os dados do Cliente</h1>

        <form action="<%=Conf.getCaminhoContexto()%>ControleCliente" method="POST">
 <div class="row">
 <div class="form-group col-md-4">
   <label for="campo1">Nome </label>
   <input type="text" value="<%=cliente.getNome()%>" class="form-control" name="txtNome">
 </div>
 
 <div class="form-group col-md-4">
   <label for="campo2">Data Nascimento</label>
   <input type="text" value="<%=cliente.getData_nasc()%>" class="form-control" name="txtData_nasc">
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
   <label for="campo5">Endereço</label>
   <input type="text"  value="<%=cliente.getEndereco()%>" class="form-control" name="txtEndereco">
 </div>
 </div>
            
            <input type="text" hidden name ="txtCpf" value="<%=cliente.getCpf()%>"></br>
            <br></br>
            <br></br>



            <input type="submit" value="Alterar2" name="acao" > 
            <button> <a href="<%=Conf.getCaminhoContexto()%>admin/manter_cliente.jsp">Voltar</a> </button>





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
