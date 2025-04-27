/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 *
 * DAO_Products: Lớp Data Access Object cho các thao tác với cơ sở dữ liệu
 * - Thiết kế theo mẫu Singleton (chỉ có một instance duy nhất)
 * - Chứa các phương thức thao tác với các bảng: Products, Categories, Users, Orders, OrderDetails
 * - Đóng vai trò trung gian giữa tầng Controller và Database
 */
package DAO;

import java.sql.*;
import java.util.List;
import java.util.Vector;
import Models.*;

/**
 *
 * @author Adim
 */
/**
 * Lớp DAO_Products cung cấp các phương thức truy xuất dữ liệu cho toàn bộ ứng dụng
 * Được thiết kế theo mẫu Singleton để đảm bảo chỉ có một instance duy nhất trong toàn bộ ứng dụng
 * Quản lý kết nối đến cơ sở dữ liệu và cung cấp các phương thức CRUD cho các đối tượng
 */
public class DAO_Products {

    // Biến static INSTANCE đảm bảo chỉ có một instance duy nhất của DAO_Products trong toàn bộ ứng dụng (Singleton pattern)
    public static DAO_Products INSTANCE = new DAO_Products();
    // Kết nối đến cơ sở dữ liệu
    public Connection con;
    // Biến lưu trạng thái của các thao tác với database, dùng để theo dõi lỗi
    private String status = "OK";

    /**
     * Constructor của DAO_Products
     * Khởi tạo kết nối đến cơ sở dữ liệu thông qua DBContext
     * Chỉ tạo kết nối mới nếu INSTANCE chưa được khởi tạo
     */
    public DAO_Products() {
        if (INSTANCE == null) {
            try {
                con = new DBContext().getConnection();
                System.out.println("Kết nối database: " + con.isClosed());
            } catch (Exception e) {
                status = "Error ar connection" + e.getMessage();
            }
        }
    }

    /**
     * Lấy trạng thái hiện tại của DAO
     * @return Chuỗi trạng thái (OK hoặc thông báo lỗi)
     */
    public String getStatus() {
        return status;
    }

    /**
     * Cập nhật trạng thái của DAO
     * @param status Trạng thái mới
     */
    public void setStatus(String status) {
        this.status = status;
    }
    //=========================================================================================
    //                                  QUẢN LÝ SẢN PHẨM
    //=========================================================================================

    /**
     * Lấy danh sách sản phẩm theo điều kiện
     * @param s Chuỗi điều kiện SQL (WHERE, ORDER BY, ...)
     * @return Danh sách sản phẩm
     */
    public List<Products> loadProduct(String s) {
        List<Products> prd = new Vector<>();
        String sql = "select * from Products " + s;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                prd.add(new Products(
                        rs.getInt(1),
                        rs.getString(2), //Name
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return prd;
    }
    
    /**
     * Lấy danh sách sản phẩm có sẵn cho khách hàng (số lượng tồn kho > 0)
     * @return Danh sách sản phẩm có sẵn
     */
    public List<Products> loadProductForCustomer() {
        List<Products> prd = new Vector<>();
        String sql = "Select * from Products where quantity_in_stock > 0";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                prd.add(new Products(
                        rs.getInt(1),
                        rs.getString(2), //Name
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return prd;
    }

    /**
     * Lấy sản phẩm bán chạy nhất (có số lượng đã bán cao nhất)
     * @return Danh sách chứa sản phẩm bán chạy nhất
     */
    public List<Products> loadProductTop1() {
        List<Products> prd = new Vector<>();
        String sql = "select top 1 * from Products order by quantity_sold desc";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                prd.add(new Products(
                        rs.getInt(1),
                        rs.getString(2), //Name
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getInt(8)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return prd;
    }

    /**
     * Cập nhật thông tin sản phẩm
     * @param id ID của sản phẩm cần cập nhật
     * @param name Tên sản phẩm mới
     * @param description Mô tả mới
     * @param category_id ID danh mục mới
     * @param quantity_sold Số lượng đã bán mới
     * @param quantity_in_stock Số lượng tồn kho mới
     * @param price Giá mới
     */
    public void changeProduct(String id, String name, String description, String category_id, String quantity_sold, String quantity_in_stock, String price) {
        String sql = "UPDATE Products\n"
                + "SET product_name = ?, \n"
                + "    description = ?,\n"
                + "    price = ?, \n"
                + "    category_id = ?,\n"
                + "    quantity_in_stock = ?,\n"
                + "    quantity_sold = ?\n"
                + "WHERE product_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, Double.parseDouble(price));
            ps.setInt(4, Integer.parseInt(category_id));
            ps.setInt(5, Integer.parseInt(quantity_in_stock));
            ps.setInt(6, Integer.parseInt(quantity_sold));
            ps.setInt(7, Integer.parseInt(id));
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Cập nhật số lượng sản phẩm sau khi bán
     * @param id ID của sản phẩm
     * @param sold_quantity Số lượng đã bán thêm
     */
    public void updateProduct(int id, int sold_quantity) {
        String sql = "update Products set quantity_sold += ?, quantity_in_stock -= ? where product_id = ? ";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, sold_quantity);
            ps.setInt(2, sold_quantity);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Xóa sản phẩm khỏi cơ sở dữ liệu
     * @param id ID của sản phẩm cần xóa
     */
    public void deleteProduct(String id) {
        String sql = "delete Products where product_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Thêm sản phẩm mới vào cơ sở dữ liệu
     * @param name Tên sản phẩm
     * @param description Mô tả sản phẩm
     * @param price Giá sản phẩm
     * @param category_id ID danh mục
     * @param image_url URL hình ảnh sản phẩm
     * @param quantity_sold Số lượng đã bán
     * @param quantity_in_stock Số lượng tồn kho
     */
    public void insertProduct(String name, String description, String price, String category_id, String image_url, String quantity_sold, String quantity_in_stock) {
        String sql = "INSERT INTO Products (product_name, description, price, category_id, image_url, \n"
                + "  quantity_in_stock, quantity_sold)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?);";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, Double.parseDouble(price));
            ps.setInt(4, Integer.parseInt(category_id));
            ps.setString(5, image_url);
            ps.setInt(6, Integer.parseInt(quantity_in_stock));
            ps.setInt(7, Integer.parseInt(quantity_sold));
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    //=========================================================================================
    //                                  QUẢN LÝ DANH MỤC
    //=========================================================================================
    /**
     * Lấy danh sách danh mục theo điều kiện
     * @param s Chuỗi điều kiện SQL (WHERE, ORDER BY, ...)
     * @return Danh sách danh mục
     */
    public List<Categories> loadCategory(String s) {
        List<Categories> cat = new Vector<>();
        String sql = "select * from Categories " + s;
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cat.add(new Categories(
                        rs.getInt(1),
                        rs.getString(2), //Name
                        rs.getString(3)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Categories " + e.getMessage();
        }

        return cat;

    }

    /**
     * Kiểm tra xem danh mục đã tồn tại hay chưa
     * @param category_name Tên danh mục cần kiểm tra
     * @return Đối tượng Categories nếu tồn tại, null nếu không
     */
    public Categories checkCategory(String category_name) {
        String sql = "select * from Categories where category_name = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, category_name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Categories(
                        rs.getInt(1),
                        rs.getString(2), //Name
                        rs.getString(3)
                );
            }
        } catch (Exception e) {
            status = "Error ar read Categories " + e.getMessage();
        }

        return null;

    }

    /**
     * Thêm danh mục mới vào cơ sở dữ liệu
     * @param category_name Tên danh mục
     * @param description Mô tả danh mục
     */
    public void insertCategory(String category_name, String description) {
        String sql = "insert into Categories(category_name, description) values (?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, category_name);
            ps.setString(2, description);
            ps.executeUpdate();

        } catch (Exception e) {
            status = "Error ar read Categories " + e.getMessage();
        }

    }

    //=========================================================================================
    //                              QUẢN LÝ NGƯỜI DÙNG VÀ ĐĂNG NHẬP
    //=========================================================================================
    /**
     * Xác thực người dùng đăng nhập
     * @param user Tên đăng nhập
     * @param pass Mật khẩu
     * @return Đối tượng Users nếu đăng nhập thành công, null nếu thất bại
     */
    public Users login(String user, String pass) {
        String sql = "select * from Users where username = ? and password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Users(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                );
            }
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }
        return null;

    }

    /**
     * Kiểm tra xem tên đăng nhập đã tồn tại hay chưa
     * @param user Tên đăng nhập cần kiểm tra
     * @return Đối tượng Users nếu tồn tại, null nếu không
     */
    public Users checkSignUp(String user) {
        String sql = "select * from Users where username = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Users(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                );
            }
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }
        return null;

    }

    /**
     * Tìm lại mật khẩu dựa trên thông tin người dùng
     * @param username Tên đăng nhập
     * @param email Email
     * @param name Họ tên
     * @param phonenumber Số điện thoại
     * @return Mật khẩu nếu thông tin chính xác, null nếu không
     */
    public String checkPassWord(String username, String email, String name, String phonenumber) {
        String sql = "select * from Users where username = ? and email = ? and phone_number = ? and full_name = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phonenumber);
            ps.setString(4, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return (new Users(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)).getPassword());
            }
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }
        return null;

    }

    /**
     * Kiểm tra thông tin trước khi đổi mật khẩu
     * @param username Tên đăng nhập
     * @param oldpassword Mật khẩu cũ
     * @param name Họ tên
     * @param phonenumber Số điện thoại
     * @param email Email
     * @return Đối tượng Users nếu thông tin chính xác, null nếu không
     */
    public Users checkChangePassWord(String username, String oldpassword, String name, String phonenumber, String email) {
        String sql = "select * from Users where username = ? and [password] = ? and email = ? and full_name = ? \n"
                + "and phone_number = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, oldpassword);
            ps.setString(3, email);
            ps.setString(4, name);
            ps.setString(5, phonenumber);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return (new Users(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }
        return null;

    }

    /**
     * Cập nhật mật khẩu mới cho người dùng
     * @param username Tên đăng nhập
     * @param newpasword Mật khẩu mới
     */
    public void changePassWord(String username, String newpasword) {
        String sql = "UPDATE Users  SET password = ?  WHERE username = ? ";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newpasword);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }

    }

    /**
     * Đăng ký tài khoản mới
     * @param name Họ tên
     * @param phonenumber Số điện thoại
     * @param email Email
     * @param username Tên đăng nhập
     * @param pass Mật khẩu
     */
    public void signUp(String name, String phonenumber, String email, String username, String pass) {
        String sql = "INSERT INTO Users (username, password, email, full_name, phone_number, isAdmin) \n"
                + "VALUES(?,?,?,?,?,0)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, email);
            ps.setString(4, name);
            ps.setString(5, phonenumber);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }

    }

    //=========================================================================================
    //                                  QUẢN LÝ GIỎ HÀNG
    //=========================================================================================
    /**
     * Kiểm tra xem người dùng đã có đơn hàng chưa hoàn thành (giỏ hàng) hay chưa
     * @param user_id ID của người dùng
     * @return Đơn hàng chưa hoàn thành (status = 1) hoặc null nếu không có
     */
    public Orders checkOrderStatus(int user_id) {
        String sql = "select * from Orders where [status] = 1 and user_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Orders(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7)
                );
            }
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }
        return null;

    }

    /**
     * Tạo đơn hàng mới cho người dùng với trạng thái là 1 (chưa hoàn thành/giỏ hàng)
     * @param user_id ID của người dùng
     */
    public void InsertNewOrder(int user_id) {
        String sql = "insert into Orders (user_id, status) values (? , 1);";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }

    }

    /**
     * Thêm sản phẩm vào chi tiết đơn hàng
     * @param orderID ID của đơn hàng
     * @param product_id ID của sản phẩm
     * @param quantity Số lượng sản phẩm
     */
    public void InsertNewOrderDetail(int orderID, int product_id, int quantity) {
        String sql = "insert into OrderDetails(orderID, product_id, quantity) values(?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderID);
            ps.setInt(2, product_id);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }

    }

    /**
     * Lấy danh sách sản phẩm trong giỏ hàng của người dùng
     * @param user_id ID của người dùng
     * @return Danh sách các mục trong giỏ hàng
     */
    public List<CartItem> loadCartItem(int user_id) {
        List<CartItem> cat = new Vector<>();
        String sql = "select  o.product_id, p.image_url, p.product_name, p.price, o.quantity,p.quantity_in_stock, o.id from OrderDetails o\n"
                + "join Products p on o.product_id = p.product_id\n"
                + "join Orders oo on oo.orderID = o.orderID\n"
                + "where oo.user_id = ? and oo.status = 1";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cat.add(new CartItem(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return cat;
    }

    /**
     * Xóa một sản phẩm khỏi giỏ hàng
     * @param id ID của chi tiết đơn hàng cần xóa
     */
    public void deleteOrderDetail(String id) {
        String sql = "delete OrderDetails where id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Cập nhật số lượng sản phẩm trong giỏ hàng
     * @param id ID của chi tiết đơn hàng
     * @param quantity Số lượng mới
     */
    public void UpdateQuantityOrderDetail(String id, String quantity) {
        String sql = "update OrderDetails set quantity = ? where id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(quantity));
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Hoàn thành đơn hàng, chuyển trạng thái từ 1 (chưa hoàn thành) sang 0 (đã hoàn thành)
     * @param user_id ID của người dùng
     * @param date Ngày đặt hàng
     * @param address Địa chỉ giao hàng
     * @param phonenumber Số điện thoại
     * @param totalmoney Tổng tiền đơn hàng
     */
    public void InsertOrderComplete(int user_id, String date, String address, String phonenumber, double totalmoney) {
        String sql = "update Orders set status = 0, date = ? ,address=?, phonenumber= ?, totalmoney = ? where user_id = ? and status = 1";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, address);
            ps.setString(3, phonenumber);
            ps.setDouble(4, totalmoney);
            ps.setInt(5, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }

    }

    /**
     * Lấy danh sách đơn hàng của người dùng
     * @param user_id ID của người dùng
     * @return Danh sách đơn hàng
     */
    public List<Orders> loadOrders(int user_id) {
        List<Orders> ord = new Vector<>();
        String sql = "select * from Orders where user_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ord.add(new Orders(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return ord;
    }

    /**
     * Lấy danh sách tất cả đơn hàng trong hệ thống
     * @return Danh sách tất cả đơn hàng
     */
    public List<Orders> loadAllOrders() {
        List<Orders> ord = new Vector<>();
        String sql = "select * from Orders";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ord.add(new Orders(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDouble(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return ord;
    }

    /**
     * Cập nhật trạng thái đơn hàng sang đã giao (status = 2)
     * @param order_id ID của đơn hàng
     */
    public void updateOrderStatus(int order_id) {
        String sql = "update Orders set [status] = 2 where orderID = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, order_id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Orders " + e.getMessage();
        }

    }

    /**
     * Lấy chi tiết đơn hàng
     * @param orderID ID của đơn hàng
     * @return Danh sách chi tiết đơn hàng
     */
    public List<DetailYourOrder> loadOrderDetail(int orderID) {
        List<DetailYourOrder> ord = new Vector<>();
        String sql = "select p.image_url,p.product_name, p.price, sum(o.quantity) quantity, p.product_id, oo.status from OrderDetails o\n"
                + "join Products p on o.product_id = p.product_id\n"
                + "join Orders oo on oo.orderID = o.orderID\n"
                + "where oo.orderID = ?\n"
                + "group by p.image_url,p.product_name, p.price,p.product_id, oo.status";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ord.add(new DetailYourOrder(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return ord;
    }

    //=========================================================================================
    //                                  QUẢN LÝ NGƯỜI DÙNG
    //=========================================================================================
    /**
     * Lấy danh sách tất cả người dùng trong hệ thống
     * @return Danh sách người dùng
     */
    public List<Users> loadAllUsers() {
        List<Users> user = new Vector<>();
        String sql = "select * from Users";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                user.add(new Users(
                        rs.getInt(1),
                        rs.getString(2), //Name
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return user;
    }

    /**
     * Xóa người dùng khỏi hệ thống
     * @param user_id ID của người dùng cần xóa
     */
    public void deleteUser(String user_id) {
        String sql = "delete from Users where user_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(user_id));
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Users " + e.getMessage();
        }

    }

    /**
     * Kiểm tra xem người dùng đã đánh giá sản phẩm chưa
     * @param user_id ID của người dùng
     * @param product_id ID của sản phẩm
     * @return Đối tượng Reviews nếu đã đánh giá, null nếu chưa
     */
    public Reviews checkReview(int user_id, int product_id) {
        String sql = "select * from Reviews where user_id = ? and product_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.setInt(2, product_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Reviews(
                        rs.getInt(1),
                        rs.getInt(2), //Name
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5)
                );
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return null;
    }

    /**
     * Thêm đánh giá mới cho sản phẩm
     * @param product_id ID của sản phẩm
     * @param user_id ID của người dùng
     * @param rating Điểm đánh giá
     * @param comment Nội dung đánh giá
     * @param review_date Ngày đánh giá
     */
    public void insertReview(int product_id, int user_id, int rating, String comment, String review_date) {
        String sql = "insert into Reviews(product_id,user_id, rating, comment, review_date)\n"
                + "values (?,?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, product_id);
            ps.setInt(2, user_id);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            ps.setString(5, review_date);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Cập nhật đánh giá của người dùng cho sản phẩm
     * @param product_id ID của sản phẩm
     * @param user_id ID của người dùng
     * @param rating Điểm đánh giá mới
     * @param comment Nội dung đánh giá mới
     * @param review_date Ngày cập nhật đánh giá
     */
    public void updateReview(int product_id, int user_id, int rating, String comment, String review_date) {
        String sql = "update Reviews set rating = ?, comment = ?, review_date = ? where product_id = ? and user_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, rating);
            ps.setString(2, comment);
            ps.setString(3, review_date);
            ps.setInt(4, product_id);
            ps.setInt(5, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

    }

    /**
     * Lấy tất cả đánh giá của một sản phẩm
     * @param product_id ID của sản phẩm
     * @return Danh sách đánh giá kèm thông tin người dùng
     */
    public List<ReviewsUser> loadAllReviews(int product_id) {
        List<ReviewsUser> rew = new Vector<>();
        String sql = "select r.product_id, r.user_id, r.rating, r.comment, r.review_date, u.username from Reviews r\n"
                + "join Users u on r.user_id = u.user_id\n"
                + "where r.product_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, product_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rew.add(new ReviewsUser(
                        rs.getInt(1),
                        rs.getInt(2), //Name
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                ));
            }
        } catch (Exception e) {
            status = "Error ar read Products " + e.getMessage();
        }

        return rew;
    }

    /**
     * Xóa đánh giá của người dùng cho sản phẩm
     * @param user_id ID của người dùng
     * @param product_id ID của sản phẩm
     */
    public void deleteReview(int user_id, int product_id) {
        String sql = "delete Reviews where user_id = ? and product_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.setInt(2, product_id);
            ps.executeUpdate();
        } catch (Exception e) {
            status = "Error ar read Reviews " + e.getMessage();
        }

    }

}
