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
import model.Status_Frete;
import util.Conf;
import util.Validacao;

/**
 *
 * @author Ramon Cordeiro
 */
public class ControleAgenda extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String acao = Validacao.Formulario(request.getParameter("acao"));
            
            if(acao.equals("ExibeAgendaFunc")){
                exbibeAgendaFunc(request, response);
            }

        } catch (Exception erro) {
            erro.printStackTrace();
            RequestDispatcher rd = request.getRequestDispatcher("/erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }

    }

    private void exbibeAgendaFunc(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {
        
        Agenda_VeiculoDAO agVDAO = new Agenda_VeiculoDAO();
        
      List<Agenda_Veiculo> listaAgenda = agVDAO.consultaTodasAgendasPorData();
        
        HttpSession retornaListaAgenda = request.getSession();
        retornaListaAgenda.setAttribute("retornaListaAgenda", listaAgenda);
        
        response.sendRedirect(Conf.getCaminhoContexto() + "logistica/principal_func_logistica.jsp");
        
        
        
    }
    
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
