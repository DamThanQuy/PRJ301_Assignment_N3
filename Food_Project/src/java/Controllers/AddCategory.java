/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;
import DAO.DAO_Products;
import Models.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Fpt
 */
// Servlet xử lý chức năng thêm danh mục sản phẩm mới
// Nhận dữ liệu từ form AddProduct.jsp, kiểm tra trùng lặp và thêm mới vào database
@WebServlet(name="AddCategory", urlPatterns={"/addcategory"})
public class AddCategory extends HttpServlet {
   
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
            out.println("<title>Servlet HomeAdminServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeAdminServlet at " + request.getContextPath () + "</h1>");
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
    /**
     * Xử lý khi người dùng gửi form thêm danh mục (HTTP POST)
     * Lấy dữ liệu từ form, kiểm tra trùng lặp, thêm mới nếu hợp lệ và trả về thông báo
     */
    @Override
    /**
 * Nhận dữ liệu từ form thêm danh mục (AddProduct.jsp) gửi lên khi người dùng bấm nút "Add"
 * Lấy các tham số như tên danh mục, mô tả
 * Kiểm tra trùng lặp, thêm mới vào database nếu hợp lệ và trả về thông báo.
 */
protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy tên danh mục và mô tả từ form gửi lên
        String category_name = request.getParameter("category_name");
        String description = request.getParameter("description");
        // Kiểm tra xem danh mục này đã tồn tại trong CSDL chưa
        Categories cat = DAO_Products.INSTANCE.checkCategory(category_name);
        if(cat != null){
            // Nếu đã tồn tại, gửi thông báo lỗi và giữ lại dữ liệu nhập
            String mess = "Category is already exist!";
            request.setAttribute("mess", mess);
            request.setAttribute("category_name", category_name);
            request.setAttribute("description", description);
            // Chuyển hướng về trang thêm sản phẩm, hiển thị thông báo lỗi
            request.getRequestDispatcher("loadaddproduct").forward(request, response);
        } else{
            // Nếu chưa tồn tại, tiến hành thêm mới vào CSDL
            String mess = "Category is update!"; // Thông báo thành công (nên sửa thành 'added successfully' cho đúng nghĩa)
            request.setAttribute("mess", mess);
            request.setAttribute("category_name", category_name);
            request.setAttribute("description", description);
            DAO_Products.INSTANCE.insertCategory(category_name, description); // Thêm vào CSDL
            // Chuyển hướng về trang thêm sản phẩm, hiển thị thông báo thành công
            request.getRequestDispatcher("loadaddproduct").forward(request, response);
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
