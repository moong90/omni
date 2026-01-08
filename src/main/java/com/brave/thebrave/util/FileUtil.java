package com.brave.thebrave.util;

import com.brave.thebrave.api.vo.FileVo;
import com.brave.thebrave.exception.runtime.ServerBrvRuntimException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class FileUtil {

    protected Logger log = LoggerFactory.getLogger(this.getClass());

//    public FileVo uploadFile(MultipartFile file, String filePath) throws Exception {
//        FileVo fileVo = new FileVo();
//
//        File fileFolder = new File(filePath);
//        if (!fileFolder.exists()) {
//            fileFolder.mkdirs();
//        }
//        String newName = "";
//        String orginFileName = file.getOriginalFilename();
//        int index = orginFileName.lastIndexOf(".");
//        String fileExt = orginFileName.substring(index + 1);
//        long size = file.getSize();
//        newName = this.getTimeStamp() + "." + fileExt;
//        this.writeFile(file, newName, filePath);
//        fileVo.setFileId("");
//        fileVo.setFileName(newName);
//        fileVo.setOrgName(orginFileName);
//        fileVo.setFileExt(fileExt);
//        fileVo.setFilePath(filePath);
//        fileVo.setFileSize(String.valueOf(size));
//        return fileVo;
//    }
    
    public FileVo uploadFile(MultipartFile file, String filePath) throws Exception {
        FileVo fileVo = new FileVo();

        File fileFolder = new File(filePath);
        if (!fileFolder.exists()) {
            fileFolder.mkdirs();
        }

        String originFileName = file.getOriginalFilename();
        int index = originFileName.lastIndexOf(".");
        String fileExt = originFileName.substring(index + 1);
        long size = file.getSize();

        String randomSuffix = String.valueOf((int)(Math.random() * 9000) + 1000);
        String newName = this.getTimeStamp() + "_" + randomSuffix + "." + fileExt;

        this.writeFile(file, newName, filePath);

        fileVo.setFileId("");
        fileVo.setFileName(newName);
        fileVo.setOrgName(originFileName);
        fileVo.setFileExt(fileExt);
        fileVo.setFilePath(filePath);
        fileVo.setFileSize(String.valueOf(size));

        return fileVo;
    }

    protected void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
        InputStream stream = null;
        OutputStream bos = null;

        try {
            stream = file.getInputStream();
            File cFile = new File(this.filePathBlackList(stordFilePath));
            if (!cFile.isDirectory()) {
                cFile.mkdirs();
            }

            bos = new FileOutputStream(this.filePathBlackList(stordFilePath + File.separator + this.getName(newName)));
            byte[] buffer = new byte[2048];

            int bytesRead;
            while((bytesRead = stream.read(buffer, 0, 2048)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
        } catch (Exception var21) {
            this.log.debug("IGNORED: " + var21.getMessage());
        } finally {
            if (bos != null) {
                try {
                    bos.close();
                } catch (Exception var20) {
                    this.log.debug("IGNORED: " + var20.getMessage());
                }
            }

            if (stream != null) {
                try {
                    stream.close();
                } catch (Exception var19) {
                    this.log.debug("IGNORED: " + var19.getMessage());
                }
            }

        }

    }

    public void downFile(HttpServletResponse response, String streFileNm, String orignFileNm) throws Exception {
        String orgFileName = orignFileNm;
        File file = new File(streFileNm);
        if (!file.exists()) {
            throw new FileNotFoundException(streFileNm);
        } else if (!file.isFile()) {
            throw new FileNotFoundException(streFileNm);
        } else {
            int fSize = (int)file.length();
            if (fSize > 0) {
                BufferedInputStream in = null;

                try {
                    in = new BufferedInputStream(new FileInputStream(file));
                    String mimetype = "application/octet-stream";
                    response.setBufferSize(fSize);
                    response.setContentType(mimetype);
                    response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(orignFileNm, "UTF-8"));
                    response.setContentLength(fSize);
                    FileCopyUtils.copy(in, response.getOutputStream());
                } finally {
                    if (in != null) {
                        try {
                            in.close();
                        } catch (Exception var15) {
                            this.log.debug("IGNORED: " + var15.getMessage());
                        }
                    }

                }

                response.getOutputStream().flush();
                response.getOutputStream().close();
            }

        }
    }

    /**
     * 파일 삭제
     */
    public void deleteFile(String filePath, String fileName) {

        File file = new File(filePath+"/"+fileName);

        if (file.exists()) {
            if (file.delete()) {
                // 성공 메시지
            } else {
                throw new ServerBrvRuntimException("파일삭제가 실패하였습니다.");
            }
        } else {
            throw new ServerBrvRuntimException("파일이 존재하지 않습니다.");
        }
    }

    public String getTimeStamp() {
        String rtnStr = null;
        String pattern = "yyyyMMddhhmmssSSS";

        try {
            SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
            Timestamp ts = new Timestamp(System.currentTimeMillis());
            rtnStr = sdfCurrent.format(ts.getTime());
        } catch (Exception var5) {
            System.out.println("Exception : " + var5.getMessage());
        }

        return rtnStr;
    }

    public static String filePathBlackList(String value) {
        if (value != null && !value.trim().equals("")) {
            String returnValue = value.replaceAll("\\.\\./", "");
            returnValue = returnValue.replaceAll("\\.\\.\\\\", "");
            return returnValue;
        } else {
            return "";
        }
    }

    public static String getName(String filename) {
        if (filename == null) {
            return null;
        } else {
            failIfNullBytePresent(filename);
            int index = indexOfLastSeparator(filename);
            return filename.substring(index + 1);
        }
    }

    private static void failIfNullBytePresent(String path) {
        int len = path.length();

        for(int i = 0; i < len; ++i) {
            if (path.charAt(i) == 0) {
                throw new IllegalArgumentException("Null byte present in file/path name. There are no known legitimate use cases for such data, but several injection attacks may use it");
            }
        }
    }

    public static int indexOfLastSeparator(String filename) {
        if (filename == null) {
            return -1;
        } else {
            int lastUnixPos = filename.lastIndexOf(47);
            int lastWindowsPos = filename.lastIndexOf(92);
            return Math.max(lastUnixPos, lastWindowsPos);
        }
    }
}
