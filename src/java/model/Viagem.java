/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Ramon Cordeiro
 */
public class Viagem {
    
    private int id;
    private Agenda_Veiculo agenda_veiculo = new Agenda_Veiculo();
    private Ordem_Servico ordem_servico = new Ordem_Servico();
    private Status_Frete status_viagem;
    private String status;
   

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Agenda_Veiculo getAgenda_veiculo() {
        return agenda_veiculo;
    }

    public void setAgenda_veiculo(Agenda_Veiculo agenda_veiculo) {
        this.agenda_veiculo = agenda_veiculo;
    }

    public Ordem_Servico getOrdem_servico() {
        return ordem_servico;
    }

    public void setOrdem_servico(Ordem_Servico ordem_servico) {
        this.ordem_servico = ordem_servico;
    }

    public Status_Frete getStatus_viagem() {
        return status_viagem;
    }

    public void setStatus_viagem(Status_Frete status_viagem) {
        this.status_viagem = status_viagem;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
    
}
