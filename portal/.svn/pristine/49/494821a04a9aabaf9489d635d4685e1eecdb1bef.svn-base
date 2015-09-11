package com.jspgou.common.upload;

import java.io.*;

import javax.servlet.ServletContext;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
/**
* This class should preserve.
* @preserve
*/
public class FileRepository implements Repository, ServletContextAware{
	private Logger log = LoggerFactory.getLogger(FileRepository.class);
	private ServletContext ctx;

	public String storeByExt(String path, String ext, MultipartFile file)
	throws IOException {
		String filename = UploadUtils.generateFilename(path, ext);
		File dest = new File(ctx.getRealPath(filename));
		dest = UploadUtils.getUniqueFile(dest);
		stores(file, dest);
		return filename;
	}
	
	private void stores(MultipartFile file, File dest) throws IOException {
		try {
			UploadUtils.checkDirAndCreate(dest.getParentFile());
			file.transferTo(dest);
		} catch (IOException e) {
			log.error("Transfer file error when upload file", e);
			throw e;
		}
	}
	
	public void setServletContext(ServletContext servletContext) {
		this.ctx = servletContext;
	}

    public boolean store(String s, InputStream inputstream)
        throws FileNotFoundException, IOException{
        IOUtils.copy(inputstream, new FileOutputStream(ctx.getRealPath(s)));
        return true;
    }

    public boolean retrieve(String s, OutputStream outputstream){
        return false;
    }
}
