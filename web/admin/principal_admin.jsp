<%-- 
    Document   : principal
    Created on : 23/03/2017, 16:10:44
    Author     : Ramon Cordeiro
--%>

<%@page import="model.Viagem"%>
<%@page import="model.Agenda_Veiculo"%>
<%@page import="java.util.List"%>
<%@page import="util.Conf"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina principal </title>
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
                        
                    </ul>

                    <ul class="nav navbar-nav navbar-right">                    
                        <li><a href="<%=Conf.getCaminhoContexto()%>ControleAcessoCliente?acao=Sair">Logout</a></li>
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </nav>
                    
            <%List<Viagem> viagem = (List<Viagem>) session.getAttribute("retornaDadosViagemAdm");%>
		<header id="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-10">	  
                        <h1><span class="glyphicon glyphicon-cog" aria-hidden="true"></span> FRPTRANS</h1>

                    </div>
                </div>
            </div>
        </header>
     <body>
    <section id="breadcrumb">
      <div class="container">
        <ol class="breadcrumb">
          <li class="active">Painel</li>
        </ol>
      </div>
    </section>

    <section id="main">
      <div class="container">
        <div class="row">
          <div class="col-md-3">
            <div class="list-group">
              <a href="index.html" class="list-group-item active main-color-bg">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span> Admin Area
              </a>
              <a href="pages.html" class="list-group-item"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Cadastre Seu Frete <span class="badge"></span></a>
              
              <a href="users.html" class="list-group-item"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Consulte Seu Cadastro <span class="badge"></span></a>
            </div>

            
          </div>
          <div class="col-md-9">
            <!-- Website Overview -->
            <div class="panel panel-default">
              <div class="panel-heading main-color-bg">
                <h3 class="panel-title">Informações Administrativas</h3>
              </div>
              <div class="panel-body">
                <div class="col-md-4">
                  <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> </h2>
                    <h4><a href="manter_func.jsp">Manter Funcionários</a></h4>
                  </div>
                </div>
                
                <div class="col-md-4">
                  <div class="well dash-box">
                    <h2><span class="glyphicon glyphicon-user" aria-hidden="true"></span> </h2>
                    <h4><a href="manter_cliente.jsp">Manter Cliente</a></h4>
                  </div>
                </div>
                
              </div>
              </div>
            
            <form action="<%=Conf.getCaminhoContexto()%>ControleOrdemServico" method="POST">
              <div class="form-group col-md-2">
                <label for="campo14">Data Inicio </label>
                <input type="date" class="form-control" name="Data1"><br/>
             </div>
              <div class="form-group col-md-2">
                <label for="campo14">Data Fim </label>
                <input type="date" class="form-control" name="Data2"><br/>
             </div>
              <div class="form-group col-md-2">
                  <label for="campo14">Status </label>
                <select name="status" class="form-control">
                        
                    <option>PENDENTE</option>
                    <option>ANDAMENTO</option>
                    <option>ENCERRADO</option>
                    <option>INDISPONIVEL</option>
                        
                </select>
                </div> 
              <br>
              
              
               <input type="submit" value="RelatorioEntreDatas" name="acao" >
              
              </form>
              
              </div>
          </div>
        </div>
     
    </section>

                    <%if(viagem !=null){ %>  
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
                         <th>Status</th>
                         
                     </tr>
                 </thead>

                     <%
                         int i = 0;
                         for (Viagem v : viagem) {
                     %>
                      <form action="<%=Conf.getCaminhoContexto()%>ControleOrdemServico" method="POST">
                      <tr class="odd pointer">

                         <td><input value="<%=v.getAgenda_veiculo().getId()%>" name="idAgenda" readonly></td>
                         <td><input type="date"  value="<%=v.getAgenda_veiculo().getData_agenda()%>" readonly name="dataAgenda"> </td>
                         <td><input value="<%=v.getOrdem_servico().getId()%>" name="idOrdemServico" readonly></td>
                         <td><input value="<%=v.getOrdem_servico().getNome_cliente()%>" readonly >  </td>
                         <td><input value=" <%=v.getAgenda_veiculo().getModelo_veic()%>" readonly> </td>
                         <td><input value=" <%=v.getAgenda_veiculo().getPlaca_veic()%>" readonly> </td>
                         <td><input value="<%=v.getOrdem_servico().getValor_viagem()%>" readonly>  </td>
                         <td><input value="<%=v.getOrdem_servico().getRua_origem()%>" readonly> </td>
                         <td><input value="<%=v.getOrdem_servico().getRua_destino()%>" readonly>  </td>
                         <td><input value="<%=v.getOrdem_servico().getMetros_cubico()%>" readonly>  </td>
                         <td><input value="<%=v.getAgenda_veiculo().getStatus() %>" readonly>  </td>
                         
                         
                         



                               

                    </tr>
                    </form>
                    
                     
               
                        
                        <% } } %>

            </table>
                        
                    
                    
                    
                    
                    
                    
                   
                 
                </div>
              
    <footer id="footer">
      <p>Copyright FRPTRANS, &copy; 2017</p>
    </footer>

  <script>
     CKEDITOR.replace( 'editor1' );
 </script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
