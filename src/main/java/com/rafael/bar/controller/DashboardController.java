package com.rafael.bar.controller;


import com.rafael.bar.util.ConnectionFactory;
import org.springframework.web.bind.annotation.*;
import java.sql.*;
import java.util.*;
 
/**
 * DashboardController
 * Endpoints usados pelo dashboard.html
 * Cada método executa uma VIEW, FUNÇÃO ou PROCEDIMENTO do banco.
 */
@RestController
@RequestMapping("/dashboard")

public class DashboardController {
	
	// ─── VIEW: vw_comandas_abertas ─────────────────────────────
    @GetMapping("/comandas-abertas")
    public List<Map<String, Object>> getComandasAbertas() throws Exception {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT * FROM vw_comandas_abertas";
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("id_comanda",  rs.getInt("id_comanda"));
                row.put("cliente",     rs.getString("cliente"));
                row.put("id_mesa",     rs.getInt("id_mesa"));
                row.put("produto",     rs.getString("produto"));
                row.put("quantidade",  rs.getInt("quantidade"));
                row.put("observacao",  rs.getString("observacao"));
                row.put("funcionario", rs.getString("funcionario"));
                row.put("status",      rs.getString("status"));
                lista.add(row);
            }
        }
        return lista;
    }
 
    // ─── VIEW: vw_produtos_acima_media ────────────────────────
    @GetMapping("/produtos-acima-media")
    public List<Map<String, Object>> getProdutosAcimaDaMedia() throws Exception {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT * FROM vw_produtos_acima_media";
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("id_produto", rs.getInt("id_produto"));
                row.put("produto",    rs.getString("produto"));
                row.put("preco",      rs.getBigDecimal("preco"));
                row.put("categoria",  rs.getString("categoria"));
                lista.add(row);
            }
        }
        return lista;
    }
 
    // ─── FUNÇÃO: calcular_total_comanda(id) ───────────────────
    @GetMapping("/total-comanda/{id}")
    public String getTotalComanda(@PathVariable int id) throws Exception {
        String sql = "SELECT calcular_total_comanda(?) AS total";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("total").toPlainString();
            }
        }
        return "0";
    }
 
    // ─── FUNÇÃO: calcular_idade_cliente(data_nascimento) ──────
    @GetMapping("/idade-cliente/{id}")
    public String getIdadeCliente(@PathVariable int id) throws Exception {
        String sql = "SELECT calcular_idade_cliente(data_nascimento) AS idade " +
                     "FROM cliente WHERE id_cliente = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return String.valueOf(rs.getInt("idade"));
            }
        }
        return "0";
    }
 
    // ─── PROCEDIMENTO: atualizar_salario_funcionario ──────────
    // O trigger log_alteracao_salario dispara automaticamente após esse CALL
    @PostMapping("/atualizar-salario")
    public String atualizarSalario(@RequestBody Map<String, Object> body) throws Exception {
        String cpf = (String) body.get("cpf");
        double novoSalario = Double.parseDouble(body.get("novoSalario").toString());
        String sql = "CALL atualizar_salario_funcionario(?, ?)";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cpf);
            ps.setDouble(2, novoSalario);
            ps.execute();
        }
        return "Salário atualizado! Trigger registrou o log automaticamente.";
    }
 
    // ─── LOG SALÁRIO (tabela gerada pelo trigger) ─────────────
    @GetMapping("/log-salario")
    public List<Map<String, Object>> getLogSalario() throws Exception {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT * FROM log_salario ORDER BY data_alteracao DESC LIMIT 20";
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("id_log",           rs.getInt("id_log"));
                row.put("cpf_funcionario",  rs.getString("cpf_funcionario"));
                row.put("salario_antigo",   rs.getBigDecimal("salario_antigo"));
                row.put("salario_novo",     rs.getBigDecimal("salario_novo"));
                row.put("data_alteracao",   rs.getString("data_alteracao"));
                lista.add(row);
            }
        }
        return lista;
    }
 
    // ─── KPI: funcionários (para o card do dashboard) ─────────
    @GetMapping("/funcionarios")
    public List<Map<String, Object>> getFuncionarios() throws Exception {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT CPF, nome, salario FROM funcionario";
        try (Connection conn = ConnectionFactory.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("cpf",     rs.getString("CPF"));
                row.put("nome",    rs.getString("nome"));
                row.put("salario", rs.getBigDecimal("salario"));
                lista.add(row);
            }
        }
        return lista;
    }

}
