<%-- 
    Document   : manter_viagens
    Created on : 17/11/2017, 01:55:15
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page import="model.Viagem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FRPtrans</title>
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
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
       
        
        <%List<Viagem> viagem = (List<Viagem>) session.getAttribute("retornaExibirMaisViagens");  %>
        
       <%
       if(viagem!=null){
       %> 
       <br>
       <br>
       <br>
       
        <h1>Manter Viagens</h1>
        <div class="table-responsive">
         <table  class="table table-striped table-bordered table-hover">
                 <thead>
                     <tr class="headings">

                         <th>Nº Viagem</th>
                         <th>Nº Ordem Servico</th>
                         <th>Cliente</th>
                         <th>Modelo Veiculo</th>
                         <th>Placa veiculo</th>
                         <th>Valor Viagem</th>
                         <th>Endereco Origem</th>
                         <th>Endereco Destino</th>
                         <th>Metros Cubicos</th>
                         <th>Data Agenda</th>
                         <th>Veiculo</th>
                         <th>Ações Relacionadas</th>
                     </tr>
                 </thead>

                     <%
                         int i = 0;
                         for (Viagem v : viagem) {
                     %>
                      <form action="<%=Conf.getCaminhoContexto()%>ControleOrdemServico" method="POST">
                      <tr class="odd pointer">

                         <td><input value="<%=v.getAgenda_veiculo().getId()%>" name="idAgenda" readonly></td>
                         <td><input value="<%=v.getOrdem_servico().getId()%>" name="idOrdemServico" readonly></td>
                         <td><input value="<%=v.getOrdem_servico().getNome_cliente()%>" readonly >  </td>
                         <td><input value=" <%=v.getAgenda_veiculo().getModelo_veic()%>" readonly> </td>
                         <td><input value=" <%=v.getAgenda_veiculo().getPlaca_veic()%>" readonly> </td>
                         <td><input value="<%=v.getOrdem_servico().getValor_viagem()%>" readonly>  </td>
                         <td><input value="<%=v.getOrdem_servico().getRua_origem()%>" readonly> </td>
                         <td><input value="<%=v.getOrdem_servico().getRua_destino()%>" readonly>  </td>
                         <td><input value="<%=v.getOrdem_servico().getMetros_cubico()%>" readonly>  </td>
                         <td><input type="date" required value="<%=v.getAgenda_veiculo().getData_agenda()%>" name="dataAgenda"> </td>
                         <td><input type="text" required value="<%=v.getAgenda_veiculo().getVeiculo()%>" name="idVeiculo"> </td>
                         <td><input type="submit" value="Alterar" name="acao" > </td>



                               

                    </tr>
                    </form>
                    
                     
               
                        
                        <% } } %>

            </table>
                        
           <br> <button><a href="principal_func_logistica.jsp">Voltar</a></br></button> <button><a href="consulta_veiculo.jsp">Consultar Veículos</a></br></button>
          
           
           
        <footer id="footer">
       
        <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

    <script>
        CKEDITOR.replace('editor1');
    </script>
           
           <script src="js/jquery.js"></script>
           <script src="js/bootstrap.min.js"></script>

    </body>
</html>
