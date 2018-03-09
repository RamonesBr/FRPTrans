/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.ConectaBanco;

/**
 *
 * @author Ramon Cordeiro
 */
public class PacoteDAO {

    private static final String CADASTRA_PACOTE = "INSERT INTO pacote  (comprimento,altura,largura,tipo,peso) VALUES (?,?,?,?,?) returning id";
    private static final String CONSULTA_PACOTE = "SELECT *FROM PACOTE WHERE ID=?";
    private static final String ATUALIZA_TIPO_PACOTE = "UPDATE pacote set tipo = ?,metros_cubicos = ? where id = ?";
    private static final String EXCLUI_PACOTE_OS = "DELETE FROM PACOTE WHERE ID=?";

    
    
    public void cadastraNovoPacote(Pacote pacote) { 
        Connection conexao = null; 
        PreparedStatement pstmt = null;     
        try { 
            conexao = ConectaBanco.getConexao(); 
            pstmt = conexao.prepareStatement(CADASTRA_PACOTE);            
            pstmt.setDouble(1, pacote.getComprimento());            
            pstmt.setDouble(2, pacote.getAltura());             
            pstmt.setDouble(3, pacote.getLargura()); 
            pstmt.setString(4, pacote.getTipo()); 
            pstmt.setDouble(5, pacote.getPeso()); 

            

            ResultSet resultadoPk = pstmt.executeQuery(); 
            
             if(resultadoPk.next()){
                    pacote.setId(resultadoPk.getInt("id"));
                }
            
 
        } catch (SQLException sqlErro) {          
            throw new RuntimeException(sqlErro); 
        } finally { 
            if (conexao != null) {                
                try { 
                    conexao.close(); 
                } catch (SQLException ex) { 
                    throw new RuntimeException(ex); 
 
                } 
            } 
        } 
 
 
 
    }
       public Pacote setTipoPacote(Pacote pacote) {

        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(ATUALIZA_TIPO_PACOTE);

            pstm.setString(1, pacote.getTipo());
            
            pstm.setDouble(2, pacote.getMetros_cubicos());
            
            pstm.setInt(3, pacote.getId());

            pstm.execute();

        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            //Fecha as conexões
            try {
                if (pstm != null) {

                    pstm.close();
                }

                if (conn != null) {
                    conn.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
        return pacote;
    }
        public void excluirPacote(Pacote pacote) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement pstm = null;

        try {
            //Cria uma conexão com o banco
            conn = ConectaBanco.getConexao();

            //Cria um PreparedStatment, classe usada para executar a query
            pstm = conn.prepareStatement(EXCLUI_PACOTE_OS);

            pstm.setInt(1, pacote.getId());

            pstm.execute();

        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            //Fecha as conexões
            try {
                if (pstm != null) {

                    pstm.close();
                }

                if (conn != null) {
                    conn.close();
                }

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
        
    }

    
   
}
