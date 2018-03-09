<%-- 
    Document   : exibePorStatus
    Created on : 02/12/2017, 11:47:25
    Author     : Ramon Cordeiro
--%>

<%@page import="util.Conf"%>
<%@page import="model.Agenda_Veiculo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
       <link rel="stylesheet" type="text/css" href="http://localhost:8282/frptransportes/css/style.css"/>
        <link href="../css/tables.css" rel="stylesheet">
        <script src="../js/jquery.min.js"></script>
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
        <%List<Agenda_Veiculo> retornoStatus = (List<Agenda_Veiculo>) session.getAttribute("retornaFiltroSelecionado");%>
        
        
         <%if (retornoStatus != null) {%>
        
        <h2>Viagens:</h2>
        <div class="table-responsive">
            <table  id="example" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr class="headings">
                        <th> </th>
                        <th>Nº Viagem</th>
                        <th>Data do Frete</th>
                        <th>Modelo Veiculo</th>
                        <th>Placa veiculo</th>
                        <th>Status Agenda</th>
                        <th>Ações Relacionadas</th>
                        <th></th>
                    </tr>
                </thead>
                     
                <form action="<%=Conf.getCaminhoContexto()%>ControleOrdemServico" method="POST">
                    <input type="submit" value="VerMais" name="acao" >  
                    <%
                        for (int i = 0; i< retornoStatus.size(); i++) {
                             Agenda_Veiculo agV = new Agenda_Veiculo();
                             agV = retornoStatus.get(i);
                    %>
                   
                    <tr class="odd pointer">
                        
                        <td class=" "><input type="checkbox" onclick=" completaCheck<%=agV.getId()%>()" id="checkbox<%=agV.getId()%><%=i%>" name="viagens2" value="<%=agV.getId()%>"> </td> 
                        <td class=" "><%=agV.getId()%></td>
                        <td class=" "><%=agV.getData_agenda()%></td>
                        <td class=" "><%=agV.getModelo_veic()%></td>
                        <td class=" "><%=agV.getPlaca_veic()%></td>
                        <td class=" "><%=agV.getStatus()%></td> 
                        
                         
                    </tr>

                    <script>
                         function completaCheck<%=agV.getId()%>(){
                             if(document.getElementById("checkbox<%=agV.getId()%><%=i%>").checked){
                        document.getElementById("checkbox<%=agV.getId()%><%=i + 1%>").checked = true;
                }else{
                    document.getElementById("checkbox<%=agV.getId()%><%=i + 1%>").checked = false;

                }
            }
                    </script>

          

            <% } %>
            </form>
            
</table>
      <button>  <a href="<%=Conf.getCaminhoContexto()%>logistica/principal_func_logistica.jsp">Voltar</a> </button>
  <% session.removeAttribute("retornaListaAgenda");%>
            <% } %>
        
        <footer id="footer">
       
        <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

    <script>
        CKEDITOR.replace('editor1');
    </script>
        
            <script src="../js/jquery.js"></script>
            <script src="../js/bootstrap.min.js"></script>
            <script src="../js/jquery.dataTables.js"></script>  
            <script src="../js/dataTables.tableTools.js"></script>  
        
       
    </body>
</html>
