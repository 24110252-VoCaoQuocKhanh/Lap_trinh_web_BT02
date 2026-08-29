package vn.iotstar.util;

public final class Constant {
    private Constant() {
    }

    /**
     * Thư mục upload dùng chung cho project.
     * Không hard-code ổ D để project chạy được trên máy khác.
     */
    public static final String DIR =
            System.getProperty("user.home") + java.io.File.separator + "CRUD_upload";
}
