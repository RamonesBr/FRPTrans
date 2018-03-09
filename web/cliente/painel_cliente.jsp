<%-- 
    Document   : painel_cliente
    Created on : 05/05/2017, 01:45:04
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page import="java.util.List"%>
<%@page import="model.Ordem_Servico"%>
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
        <link href="../css/style.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
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
    
       <body
       
        <%List<Ordem_Servico> os_cliente = (List<Ordem_Servico>) session.getAttribute("retornaOsCliente");%>

        <%if (os_cliente == null) {%>
        onload ="carregaOs()"
        <%}%> >


        <%Cliente cliente = (Cliente) session.getAttribute("clienteAutenticado");%>
        <h4> Bem vindo, <%=cliente.getLogin()%>,</h4>
        <h3> ESCOLHA UMA OPÇÃO</h2>
        <div class="panel-body">
            <div class="col-md-6">
                <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 203</h2>
                    <h4><a href="verifica_disp.jsp">Cadastre seu frete</a></h4>
                </div>
            </div>
            <div class="col-md-6">
                <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-user" aria-hidden="true"></span> 33</h2>
                    <h4><a href="principal_cliente.jsp">Consulte seu cadastro</a></h4>
                </div>
            </div>
        </div>
        

        <input type="text" hidden id="cliente" name ="txtIdCliente" value="<%=cliente.getId()%>" ></br>
        <h2>Seus Fretes </h2>

        <%if (os_cliente != null) {%>
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
                  
                <thead>
                <th>Nº Frete</th>
                <th>Cliente</th>
                <th>Data do Frete</th>
                <th>Rua de Origem</th>
                <th>Rua de Destino</th>
                <th>Valor do Frete(R$)</th>
                <th>Kilometragem percorrida</th>
                <th>Status</th>

                </thead>

                <%
                    for (Ordem_Servico os : os_cliente) {
                %>

         




                <td><%=os.getId()%></td>
                <td><%=os.getNome_cliente()%></td>
                <td><%=os.getData_partida()%></td>
                <td><%=os.getRua_origem()%></td>
                <td><%=os.getRua_destino()%></td>
                <td>R$ <%=os.getValor_viagem()%></td>
                <td><%=os.getKm_percorrido()%> Km</td>
                <td><%=os.getStatus()%></td>

                </tr>
                <%}%>
     

            </table>

            <% }
                session.removeAttribute("retornaOsCliente");%>




  <footer id="footer">
        <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

    

    <script>
        CKEDITOR.replace('editor1');
    </script>
    
            <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->

            <script>function carregaOs() {
                    var cliente = document.getElementById("cliente").value;
                    location.href = "<%=Conf.getCaminhoContexto()%>ControleOrdemServico?acao=ListarOsCliente&idCliente=" + cliente.valueOf();

                }
            </script>
            <script src="../js/jquery.js"></script>
            <script src="../js/bootstrap.min.js"></script>
    </body>
</html>
