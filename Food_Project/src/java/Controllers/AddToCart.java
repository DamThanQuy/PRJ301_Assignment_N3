

package Controllers; // Gói chứa các controller xử lý request từ client

import DAO.DAO_Products; // DAO thao tác với database bảng sản phẩm, đơn hàng
import Models.*; // Import các model: Users, Orders, ...
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Quản lý session người dùng


@WebServlet(name="AddToCart", urlPatterns={"/addtocart"}) 
public class AddToCart extends HttpServlet {
   
   
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeAdminServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeAdminServlet at " + request.getContextPath () + "</h1>"); // Demo, không liên quan logic thêm giỏ hàng
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Chỉ gọi processRequest (hiển thị demo HTML)
        processRequest(request, response);
    } // Kết thúc hàm doGet

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
        // Lấy id sản phẩm và số lượng từ request (từ client gửi lên)
        String product_id = request.getParameter("product_id");
        String quantity = request.getParameter("quantity");
        // Lấy session hiện tại của người dùng
        HttpSession session = request.getSession();
        // Lấy thông tin user đang đăng nhập từ session
        Users u = (Users)session.getAttribute("acc");
        // Kiểm tra xem user đã có đơn hàng "chưa hoàn thành" (giỏ hàng) chưa
        Orders o = DAO_Products.INSTANCE.checkOrderStatus(u.getUser_id());
        if(o == null){
            // Nếu chưa có giỏ hàng: tạo mới đơn hàng (Order) trạng thái chưa hoàn thành
            DAO_Products.INSTANCE.InsertNewOrder(u.getUser_id());
            // Lấy lại order vừa tạo
            Orders o1 = DAO_Products.INSTANCE.checkOrderStatus(u.getUser_id());
            // Thêm sản phẩm vừa chọn vào chi tiết đơn hàng (OrderDetail)
            DAO_Products.INSTANCE.InsertNewOrderDetail(o1.getOrderID(), Integer.parseInt(product_id), Integer.parseInt(quantity));
            // Chuyển hướng sang trang giỏ hàng
            response.sendRedirect("cart");
        }else{
            // Nếu đã có giỏ hàng: thêm sản phẩm vào chi tiết đơn hàng hiện tại
            DAO_Products.INSTANCE.InsertNewOrderDetail(o.getOrderID(), Integer.parseInt(product_id), Integer.parseInt(quantity));
            // Chuyển hướng sang trang giỏ hàng
            response.sendRedirect("cart");
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet thêm sản phẩm vào giỏ hàng";
    }// </editor-fold>

}
