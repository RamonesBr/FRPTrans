/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Date;

/**
 *
 * @author Ramon Cordeiro
 */
public class Agenda_Veiculo {
    
    private int id;
    private int veiculo;
    private int cliente;
    private String data_agenda;
    private String data_disp;
    private Ordem_Servico ordem_servico = new Ordem_Servico();
    private Status_Frete status_agenda;
    private String status;
    private String modelo_veic;
    private String placa_veic;
    private String nome_cliente;

    public String getModelo_veic() {
        return modelo_veic;
    }

    public void setModelo_veic(String modelo_veic) {
        this.modelo_veic = modelo_veic;
    }

    public String getPlaca_veic() {
        return placa_veic;
    }

    public void setPlaca_veic(String placa_veic) {
        this.placa_veic = placa_veic;
    }

    public String getNome_cliente() {
        return nome_cliente;
    }

    public void setNome_cliente(String nome_cliente) {
        this.nome_cliente = nome_cliente;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Status_Frete getStatus_agenda() {
        return status_agenda;
    }

    public void setStatus_agenda(Status_Frete status_agenda) {
        this.status_agenda = status_agenda;
    }
    
    

    public Ordem_Servico getOrdem_servico() {
        return ordem_servico;
    }

    public void setOrdem_servico(Ordem_Servico ordem_servico) {
        this.ordem_servico = ordem_servico;
    }

    
    
    public String getData_disp() {
        return data_disp;
    }

    public void setData_disp(String data_disp) {
        this.data_disp = data_disp;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVeiculo() {
        return veiculo;
    }

    public void setVeiculo(int veiculo) {
        this.veiculo = veiculo;
    }

    public int getCliente() {
        return cliente;
    }

    public void setCliente(int cliente) {
        this.cliente = cliente;
    }

    public String getData_agenda() {
        return data_agenda;
    }

    public void setData_agenda(String data_agenda) {
        this.data_agenda = data_agenda;
    }
    
    
    
    
    
    
}
