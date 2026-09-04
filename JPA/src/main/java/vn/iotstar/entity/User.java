package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(unique = true, nullable = false, length = 100)
    private String username;

    @Column(nullable = false, length = 255)
    private String password;

    @Column(unique = true, length = 150)
    private String email;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String fullname;

    @Column(length = 20)
    private String phone;

    @Column(length = 255)
    private String images;

    // 1: Admin, 2: User thông thường
    @Column(name = "role")
    private int role = 2;

    // 0: Chờ kích hoạt OTP, 1: Đã kích hoạt
    @Column(name = "status")
    private int status = 0;

    @Column(name = "otp", length = 10)
    private String otp;

    public User() {}

    public User(String username, String password, String email, String fullname, int role, int status) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.role = role;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getOtp() { return otp; }
    public void setOtp(String otp) { this.otp = otp; }
}