package vn.iotstar.util;

import java.io.File;

public class Constant {
    public static final String DIR = "D:\\ltweb\\24110252_VoCaoQuocKhanh_BT02\\upload";
    
    static {
        File uploadDir = new File(DIR);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        File cateDir = new File(DIR + "/category");
        if (!cateDir.exists()) cateDir.mkdirs();
        File prodDir = new File(DIR + "/product");
        if (!prodDir.exists()) prodDir.mkdirs();
        File userDir = new File(DIR + "/user");
        if (!userDir.exists()) userDir.mkdirs();
    }
}