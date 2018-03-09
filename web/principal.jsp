<%@page import="model.Usuario"%>
<%@page import="util.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FRPTRANS - QUALIDADE EM TRANSPORTE</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Didact+Gothic" rel="stylesheet" />
 <link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

</head>
<body>
<div id="header-wrapper">
	<div id="header" class="container">
		<div id="logo">
			<h1><a href="#">FRPTRANS</a></h1>
		</div>
		<div id="menu">
			<ul>
				<li class="active"><a href="#" accesskey="1" title="">A FRPTRANS</a></li>
				<li><a href="cliente/cadastro_cliente.jsp" accesskey="2" title="">CADASTRE-SE</a></li>
				<li><a href="<%=Conf.getCaminhoContexto()%>login_func.jsp" accesskey="3" title="">FUNCIONARIOS</a></li>
				<li><a href="<%=Conf.getCaminhoContexto()%>login_cliente.jsp" accesskey="4" title="">CADASTRE SEU FRETE</a></li>
				<li><a href="#" accesskey="5" title="">CONTATO</a></li>
			</ul>
		</div>
	</div>

<div id="banner-wrapper">
	<div id="banner" class="container">
		<div class="title">
			<h2>PODEMOS FAZER MUITO MAIS PELO SEU NEGÓCIO</h2>
			<span class="byline">FAÇA SUA COTAÇÃO EM MINUTOS.</span>
		</div>
		<ul class="actions">
			<li><a href="<%=Conf.getCaminhoContexto()%>login_cliente.jsp" class="button">COTAR AGORA</a></li>
		</ul>
	</div>
</div>
</div>
<div id="wrapper">
	<div id="three-column" class="container">
    
		<div class="title">
			<h2>VANTAGENS DE USAR NOSSOS SERVIÇOS</h2>
			<span class="byline">VOE MAIS ALTO COM NOSSAS SOLUÇÕES EM FRETES</span>
		</div>
		<div class="boxA">
			<p>Precisa de uma entrega ultra rápida de documentos, e pequenos pacotes, conte conosco!</p>
			<a href="#" class="button button-alt">Frota de Motos</a>
		</div>
		<div class="boxB">
			<p>Temos todos os tipos de Veiculos para melhor atender você e sua empresa.</p>
			<a href="#" class="button button-alt">Conheça nossa Frota</a>
		</div>
		<div class="boxC">
			<p>Cote, cadastre seu frete na comodidade de sua casa ou empresa. </p>
			<a href="#" class="button button-alt">Cotação</a>
		</div>
	</div>
</div>
<div id="welcome">
	<div class="container">
		<div class="title">
			<h2>ALCANCE NIVEIS MAIS ALTOS</h2>
			<span class="byline">Cadastre-se em nosso site, o resto é com a gente! </span>
		</div>
        <img src="imagens/pic02.jpg" alt="" class="image image-full" />
      <p>Nós somos a  <strong>FRPTRANS</strong>, empresa especializada em transporte no Alto Tiête, com Transparência e Agilidade a sua entrega dentro do prazo, mais tempo para você tocar o seu negócio sem se preocupar com o transporte  </p>
		<ul class="actions">
			<li><a href="#" class="button">Saiba Mais</a></li>
		</ul>
	</div>
</div>
<div id="copyright" class="container">
	<p>Copyright FRPTRANS, &copy; 2017.</p>
</div>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
 <script src="js/bootstrap.min.js"></script>
</body>
</html>
