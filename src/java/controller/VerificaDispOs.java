/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Agenda_Veiculo;
import model.Agenda_VeiculoDAO;
import model.Cliente;
import model.Pacote;
import model.PacoteDAO;
import model.Veiculo;
import model.VeiculoDAO;
import util.Validacao;

/**
 *
 * @author Ramon Cordeiro
 */
public class VerificaDispOs extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String acao = Validacao.Formulario(request.getParameter("acao"));

            if (acao.equals("Verificar")) {
                verificaDispOs(request, response);
            }
            else if(acao.equals("Cadastrar")){
                cadastraAgenda(request, response);
            }

        } catch (Exception e) {
        }

    }

    private void verificaDispOs(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException {

        //Recupera dados Pacote
        double altura = Double.parseDouble(Validacao.Formulario(request.getParameter("txtAltura")));
        double comprimento = Double.parseDouble(Validacao.Formulario(request.getParameter("txtComprimento")));
        double largura = Double.parseDouble(Validacao.Formulario(request.getParameter("txtLargura")));
        double peso = Double.parseDouble(Validacao.Formulario(request.getParameter("txtPeso")));
        String data_agenda = Validacao.Formulario(request.getParameter("txtDataPartida"));

        //recupera cliente logado na sessão 
        String idCliente = Validacao.Formulario(request.getParameter("txtIdCliente"));

        //instancio todos os objetos 
        Cliente cliente = new Cliente();
        Pacote pacote = new Pacote();
        Veiculo veiculo = new Veiculo();
        Agenda_Veiculo agVeic = new Agenda_Veiculo();

        PacoteDAO daoP = new PacoteDAO();
        VeiculoDAO veicDAO = new VeiculoDAO();
        Agenda_VeiculoDAO agVeicDAO = new Agenda_VeiculoDAO();

        //Seto os parametros trazidos da View
        pacote.setAltura(altura);
        pacote.setComprimento(comprimento);
        pacote.setLargura(largura);
        pacote.setPeso(peso);
        agVeic.setData_agenda(data_agenda);

        //cadastra Pacote
        daoP.cadastraNovoPacote(pacote);  // cadastro o novo pacote

        //Classifica Pacote
        pacote.classificaPacote(pacote); // classifico o tipo de pacote 
        daoP.setTipoPacote(pacote);

        //Aloca Veiculo
        veiculo.classificaTipoVeiculo(pacote); // passo o pacote na assinatura para encontrar o veiculo adequado
        veiculo = veicDAO.consultarPorTipo(veiculo);//consulto qual veiculo mais adequado

        agVeic.setVeiculo(veiculo.getId()); // informo dentro do objeto, o ID do veiculo selecionado

        //verifica disponibilidade 
        List<String> datas = new ArrayList<String>();

        if (agVeicDAO.verificaDispAgenda(agVeic)) {  // Se True = Não tem disp / Se False = Tem disp
            int dias = 1;
            for (int i = 1; i <= 10;) { // Varrer as proximas datas disponiveis 
                Agenda_Veiculo agV = new Agenda_Veiculo();
                agV.setVeiculo(agVeic.getVeiculo());
                agV.setData_agenda(agVeicDAO.verificaProxAgenda(agVeic, dias++));

                if (!agVeicDAO.verificaDispAgenda(agV)) { // Verifica quais das proximas datas estão disponiveis 
                    i++;
                    datas.add(agV.getData_agenda());

                }
            }


        } 
        
         request.setAttribute("retornaDatas", datas);
         request.setAttribute("data_dados", agVeic);
         
         HttpSession pacote_os = request.getSession();
         pacote_os.setAttribute("pacote_os", pacote);
         
         HttpSession veiculo_os = request.getSession();
         veiculo_os.setAttribute("veiculo_os", veiculo);
         
         RequestDispatcher rd = request.getRequestDispatcher("/cliente/verifica_disp.jsp");
         rd.forward(request, response);

        
        
    }
    
    
    private void cadastraAgenda(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        
        
         int idCliente = Integer.parseInt(Validacao.Formulario(request.getParameter("idCliente")));
         int idVeiculo = Integer.parseInt(Validacao.Formulario(request.getParameter("idVeiculo")));
         String dataReq = Validacao.Formulario(request.getParameter("dataReq"));
         
         Agenda_Veiculo agV = new Agenda_Veiculo();
         
         
         Agenda_VeiculoDAO agVDAO = new Agenda_VeiculoDAO();
         
         
         agV.setData_disp(dataReq);
         agV.setVeiculo(idVeiculo);
         agV.setCliente(idCliente);
         
         agVDAO.cadastraAgendaVeic(agV);
         
         HttpSession dados_os = request.getSession();
         dados_os.setAttribute("dados_para_cadastro_os", agV);
         RequestDispatcher rd = request.getRequestDispatcher("/cliente/cadastro_Frete.jsp");
         rd.forward(request, response);
         
         
         
    }

    
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   

}
