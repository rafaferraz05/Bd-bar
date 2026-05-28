package com.rafael.bar.dao;

import com.rafael.bar.model.Comanda;
import com.rafael.bar.util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComandaDAO {

    public void inserir(Comanda c) throws SQLException {
        String sql = "INSERT INTO comanda (id_cliente, id_mesa, status) VALUES (?, ?, ?)";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, c.getId_cliente());
            stmt.setInt(2, c.getId_mesa());
            stmt.setString(3, c.getStatus() != null ? c.getStatus() : "aberta");
            stmt.executeUpdate();
        }
    }

    public List<Comanda> listar() throws SQLException {
        String sql = "SELECT * FROM comanda";
        List<Comanda> lista = new ArrayList<>();
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Comanda c = new Comanda();
                c.setId_comanda(rs.getInt("id_comanda"));
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setId_mesa(rs.getInt("id_mesa"));
                c.setStatus(rs.getString("status"));
                lista.add(c);
            }
        }
        return lista;
    }

    public void atualizar(Comanda c) throws SQLException {
        String sql = "UPDATE comanda SET id_cliente = ?, id_mesa = ?, status = ? WHERE id_comanda = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, c.getId_cliente());
            stmt.setInt(2, c.getId_mesa());
            stmt.setString(3, c.getStatus());
            stmt.setInt(4, c.getId_comanda());
            stmt.executeUpdate();
        }
    }

    public void remover(int id) throws SQLException {
        String sql = "DELETE FROM comanda WHERE id_comanda = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}