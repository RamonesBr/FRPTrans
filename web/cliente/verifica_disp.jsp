<%-- 
    Document   : painel_cliente
    Created on : 05/05/2017, 01:45:04
    Author     : Ramon Cordeiro
--%>

<%@page import="model.Veiculo"%>
<%@page import="java.util.List"%>
<%@page import="model.Agenda_Veiculo"%>
<%@page import="model.Cliente"%>
<%@page import="util.Conf"%>
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
    
    <body>
        <%Cliente cliente = (Cliente) session.getAttribute("clienteAutenticado");%>
        <%List<String> datasDisp = (List<String>) request.getAttribute("retornaDatas");%>
        <%Agenda_Veiculo data_dados = (Agenda_Veiculo) request.getAttribute("data_dados");%>
        <br>
        <br>
        <br>
        <br>
        <h3>Escolha uma Data</h3>

        <form action="<%=Conf.getCaminhoContexto()%>VerificaDispOs" method="POST">

            <div class="form-group col-md-2">
                <label for="campo14">Data Partida </label>
                <input type="date" class="form-control" name="txtDataPartida"><br/>
            </div>

            <br>
            <br>
            <br>
            <h3>Informe as dimensões do pacote para envio</h3>
            <br>
            <div class="row">
                <div class="form-group col-md-2">
                    <label for="campo11">Altura (m) </label>
                    <input type="number"step="0.01" min="0" max="4" class="form-control" name="txtAltura"><br/>
                </div> 
            

                <div class="row">
                    <div class="form-group col-md-2">
                        <label for="campo12">Comprimento (m) </label>
                        <input type="number" type="number"step="0.01" min="0" max="14" class="form-control" name="txtComprimento"><br/>
                    </div>

                    <div class="row">
                        <div class="form-group col-md-2">
                            <label for="campo13">Largura (m) </label>
                            <input type="number" type="number"step="0.01" min="0" max="3" class="form-control" name="txtLargura"><br/>
                        </div>
                        <div class="form-group col-md-2">
                            <label for="campo14">Peso (Kg) </label>
                            <input type="number" type="number"step="0.01" min="0" max="23000" class="form-control" name="txtPeso"><br/>
                        </div>

                        </div>
                    </div>
                  </div>
             
            <input type="text" hidden name ="txtIdCliente" value="<%=cliente.getId()%>"></br>
            <input type="submit"  value="Verificar" name="acao" >
            <button>  <a href="<%=Conf.getCaminhoContexto()%>cliente/painel_cliente.jsp">Voltar</a> </button>
            
        </form>
       
        <br>
        <br>


        <%
            if (datasDisp != null) {

                if (datasDisp.size() == 0) {
        %>
        <script>
            alert('A data escolhida está disponivel ! \n\
                  Favor prosseguir com o cadastro !');
        </script>
        <form action="<%=Conf.getCaminhoContexto()%>VerificaDispOs" method="POST">

            <input type="text" hidden name ="idCliente" value="<%=cliente.getId()%>"></br>
            <input type="text" hidden name ="dataReq" value="<%=data_dados.getData_agenda()%>"></br>
            <input type="text" hidden name ="idVeiculo" value="<%=data_dados.getVeiculo()%>"></br>
            <input type="submit"  value="Cadastrar" name="acao" >
            <button> <a href="cliente/painel_cliente.jsp">Cancelar frete</a> </button>

       </form>

        <%} else {%>
        <form action="<%=Conf.getCaminhoContexto()%>VerificaDispOs" method="POST">
            <input type="text" hidden name ="idCliente" value="<%=cliente.getId()%>">
            <input type="text" hidden name ="idVeiculo" value="<%=data_dados.getVeiculo()%>">

            <div class="form-group">
                <label class="control-label col-md-3 col-sm-3 col-xs-12">Desculpe! Não temos a data requerida, mas sugerimos as datas a seguir</label>

                <div class="col-md-9 col-sm-9 col-xs-12">
                    <select name="dataReq" class="form-control">
                        <%for (int i = 0; i < datasDisp.size(); i++) {%>
                        <option value="<%=datasDisp.get(i)%>"><%=datasDisp.get(i)%></option>
                        <%}%>
                    </select>
                </div>
            </div>
                                

            <br>
            <br>
            <br>
            <input type="submit"  value="Cadastrar" name="acao" >

        </form>

        <% } %>
        <% }%>
        <footer id="footer">
        <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>
<script>
        CKEDITOR.replace('editor1');
    </script>
        <!-- jQuery (necessario para os plugins Javascript do Bootstrap) -->
        <script src="http://localhost:8282/frptransportes/css/js/jquery.js"></script>
        <script src="http://localhost:8282/frptransportes/css/js/bootstrap.min.js"></script>
    </body>
</html>
