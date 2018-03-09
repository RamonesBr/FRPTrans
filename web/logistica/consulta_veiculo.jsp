<%-- 
    Document   : manter_veiculo
    Created on : 05/05/2017, 18:50:35
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page import="model.Veiculo"%>
<%@page import="java.util.List"%>
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
            </div>
        </header>
        <div class="panel panel-default">
            <div class="panel-heading main-color-bg">
                <h3 class="panel-title">Informações Administrativas</h3>
            </div>
        </div>
    <body    <% List<Veiculo> mostrarVeiculos = (List<Veiculo>) session.getAttribute("retornaTodosVeiculos");  %>

          <%if (mostrarVeiculos == null) {%>

        onload="carregaVeiculos()"

        <%}%>
       
        >
        
        <br>
        <br>
        <br>
        <br>
        <br>
        
        <h1>Veiculos</h1>

        

        

        <%
            if (mostrarVeiculos != null) {%>
            <div class="table-responsive">
             <table class="table table-striped table-bordered table-hover">
            <thead>
            <th>Id </th>
            <th>Marca</th>
            <th>Modelo</th>
            <th>Cor</th>
            <th>Placa</th>
            <th>Status</th>
            <th>Ano</th>
            <th>Tipo</th>



            
        </thead>
<%

                for (Veiculo v : mostrarVeiculos) {
        %>

        
                <td><%=v.getId()%></td>
                <td><%=v.getMarca()%></td>
                <td><%=v.getModelo()%></td>
                <td><%=v.getCor()%></td>
                <td><%=v.getPlaca()%></td>
                <td><%=v.getStatus()%></td>
                <td><%=v.getAno()%></td>
                <td><%=v.getTipo()%></td>
               


            </tr>
       

        <%}%>
        </table>
         <% session.removeAttribute("retornaTodosVeiculos");%>
        
        <%}%>
        
        <button> <a href="<%=Conf.getCaminhoContexto()%>ControleAcesso?acao=Sair"> Logout</a> </button>
        <button> <a href="<%=Conf.getCaminhoContexto()%>logistica/manter_viagens.jsp"> voltar</a> </button>

        
        <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
        
        <script>function carregaVeiculos() {

                    location.href = "<%=Conf.getCaminhoContexto()%>ControleVeiculo?acao=ConsultaVeiculo";

                }
            </script>
  <script src="js/jquery.js"></script>
  <script src="js/bootstrap.min.js"></script>
      
    </body>
</html>
