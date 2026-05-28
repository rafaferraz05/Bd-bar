package com.rafael.bar.model;

public class Comanda {

    private int id_comanda;
    private int id_cliente;
    private int id_mesa;
    private String status;

    public int getId_comanda() { return id_comanda; }
    public void setId_comanda(int id_comanda) { this.id_comanda = id_comanda; }

    public int getId_cliente() { return id_cliente; }
    public void setId_cliente(int id_cliente) { this.id_cliente = id_cliente; }

    public int getId_mesa() { return id_mesa; }
    public void setId_mesa(int id_mesa) { this.id_mesa = id_mesa; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}