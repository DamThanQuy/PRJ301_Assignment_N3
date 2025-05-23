/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DAO.DAO_Products;
import Models.Categories;
import Models.Products;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Fpt
 */
public class HomeAdminSubServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeAdminSubServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeAdminSubServlet at " + request.getContextPath () + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int category = Integer.parseInt(request.getParameter("category"));
        if (category != -1) {
            request.setAttribute("tag", category);
            String str = "where category_id = " + category;
            List<Products> prd = DAO_Products.INSTANCE.loadProduct(str);
            request.setAttribute("prd", prd);
            List<Categories> cat = DAO_Products.INSTANCE.loadCategory("");
            request.setAttribute("cat", cat);
            List<Products> prd1 = DAO_Products.INSTANCE.loadProductTop1();
            request.setAttribute("prd1", prd1);
            request.getRequestDispatcher("HomeAdmin.jsp").forward(request, response);
        }else{
            // SỬA ĐOẠN NÀY: Nếu không có search thì trả về toàn bộ sản phẩm khi chọn 'All'
            request.setCharacterEncoding("UTF-8");// tim tieng viet
            request.setAttribute("tag", -1);
            String str2 = request.getParameter("search");
            List<Products> prd;
            if (str2 == null || str2.trim().isEmpty()) {
                // Nếu không search, lấy tất cả sản phẩm
                prd = DAO_Products.INSTANCE.loadProduct("");
            } else {
                // Nếu có search, lọc theo tên
                String str = "where product_name like '%"+ str2 +"%'";
                prd = DAO_Products.INSTANCE.loadProduct(str);
            }
            request.setAttribute("prd", prd);
            List<Categories> cat = DAO_Products.INSTANCE.loadCategory("");
            request.setAttribute("cat", cat);
            List<Products> prd1 = DAO_Products.INSTANCE.loadProductTop1();
            request.setAttribute("prd1", prd1);
            request.getRequestDispatcher("HomeAdmin.jsp").forward(request, response);
        } 

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
