package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.util.Constant;
import java.io.*;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }

        File file = new File(Constant.DIR + "/" + fileName);
        if (!file.exists() || !file.isFile()) {
            String realPath = getServletContext().getRealPath("/upload/" + fileName);
            if (realPath != null) {
                File fallbackFile = new File(realPath);
                if (fallbackFile.exists() && fallbackFile.isFile()) {
                    file = fallbackFile;
                }
            }
        }
        if (file.exists() && file.isFile()) {
            String mimeType = getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "image/jpeg";
            }
            resp.setContentType(mimeType);

            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = resp.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}