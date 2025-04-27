/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DAO.DAO_Products; // DAO thao tác với database liên quan đến sản phẩm, danh mục
import Models.Categories; // Model đại diện cho bảng Categories (danh mục)
import Models.Products;   // Model đại diện cho bảng Products (sản phẩm)
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List; // Dùng để lưu danh sách danh mục

/**
 *
 * @author Fpt
 */
@WebServlet(name="LoadAddProduct", urlPatterns={"/loadaddproduct"}) // Định nghĩa servlet với url-pattern là /loadaddproduct
public class LoadAddProduct extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Hàm xử lý chung cho cả GET và POST (hiện tại chỉ xuất HTML demo, không dùng thực tế)
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Demo xuất HTML đơn giản
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoadAddProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadAddProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Hàm xử lý khi có request GET tới /loadaddproduct
     * - Lấy danh sách tất cả category từ database
     * - Đưa danh sách này vào thuộc tính 'cat' của request để JSP sử dụng
     * - Chuyển tiếp (forward) request sang trang AddProduct.jsp để hiển thị giao diện thêm sản phẩm/danh mục
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy danh sách tất cả các danh mục từ DB
        List<Categories> cat = DAO_Products.INSTANCE.loadCategory("");
        request.setAttribute("cat", cat); // Truyền danh sách category cho JSP
        request.getRequestDispatcher("AddProduct.jsp").forward(request, response); // Chuyển tiếp về trang giao diện thêm sản phẩm
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Hàm xử lý khi có request POST tới /loadaddproduct
     * - Thường dùng khi vừa thêm danh mục xong, cần load lại giao diện thêm sản phẩm
     * - Cũng lấy danh sách category và forward về AddProduct.jsp
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<Categories> cat = DAO_Products.INSTANCE.loadCategory(""); // Lấy danh sách danh mục
        request.setAttribute("cat", cat); // Truyền cho JSP
        request.getRequestDispatcher("AddProduct.jsp").forward(request, response); // Chuyển tiếp về giao diện thêm sản phẩm
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
