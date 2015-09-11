package com.jspgou.core.tpl;

import com.ifunpay.portal.ProjectXml;
import com.jspgou.common.web.springmvc.RealPathResolver;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.ArrayList;
import java.util.List;


/**
* This class should preserve.
* @preserve
*/
public class FileTplManagerImpl implements TplManager {
	private static Logger log = LoggerFactory
			.getLogger(FileTplManagerImpl.class);

	public int delete(String[] names) {
		File f;
		int count = 0;
		for (String name : names) {
			f = new File(realPathResolver.get(name));
			if (f.isDirectory()) {
				if (FileUtils.deleteQuietly(f)) {
					count++;
				}
			} else {
				if (f.delete()) {
					count++;
				}
			}
		}
		return count;
	}

	public Tpl get(String name) {
		File f = new File(realPathResolver.get(name));
		if (f.exists()) {
			return new FileTpl(f, root);
		} else {
			return null;
		}
	}

	public List<Tpl> getListByPrefix(String prefix) {
		File f = new File(realPathResolver.get(prefix));
		String name = prefix.substring(prefix.lastIndexOf("/") + 1);
		File parent;
		if (prefix.endsWith("/")) {
			name = "";
			parent = f;
		} else {
			parent = f.getParentFile();
		}
		if (parent.exists()) {
			File[] files = parent.listFiles(new PrefixFilter(name));
			if (files != null) {
				List<Tpl> list = new ArrayList<Tpl>();
				for (File file : files) {
					list.add(new FileTpl(file, root));
				}
				return list;
			} else {
				return new ArrayList<Tpl>(0);
			}
		} else {
			return new ArrayList<Tpl>(0);
		}
	}

	public List<String> getNameListByPrefix(String prefix) {
		List<Tpl> list = getListByPrefix(prefix);
		List<String> result = new ArrayList<String>(list.size());
		for (Tpl tpl : list) {
			result.add(tpl.getName());
		}
		return result;
	}

	public List<Tpl> getChild(String path) {
		File file = new File(realPathResolver.get(path));
		File[] child = file.listFiles();
		if (child != null) {
			List<Tpl> list = new ArrayList<Tpl>(child.length);
			for (File f : child) {
				list.add(new FileTpl(f, root));
			}
			return list;
		} else {
			return new ArrayList<Tpl>(0);
		}
	}

	public void rename(String orig, String dist) {
		String os = realPathResolver.get(orig);
		File of = new File(os);
		String ds = realPathResolver.get(dist);
		File df = new File(ds);
		try {
			if (of.isDirectory()) {
				FileUtils.moveDirectory(of, df);
			} else {
				FileUtils.moveFile(of, df);
			}
		} catch (IOException e) {
			log.error("Move template error: " + orig + " to " + dist, e);
		}
	}

	public void save(String name, String source, boolean isDirectory) {
		String real = realPathResolver.get(name);
		File f = new File(real);
		if (isDirectory) {
			f.mkdirs();
		} else {
			try {
				FileUtils.writeStringToFile(f, source, "UTF-8");
			} catch (IOException e) {
				log.error("Save template error: " + name, e);
				throw new RuntimeException(e);
			}
		}
	}

	public void save(String path, MultipartFile file) {
		File f = new File(realPathResolver.get(path), file
				.getOriginalFilename());  // 上传到本地
        File f1 = new File(ProjectXml.getValue("file_path")+path);  // 上传到文件服务器
        if(!f1.exists()){
            f1.mkdirs();
        }
		try {

			file.transferTo(f);
		} catch (IllegalStateException e) {
			log.error("upload template error!", e);
		} catch (IOException e) {
			log.error("upload template error!", e);
		}

        try {
            FileUtils.copyFile(new File(realPathResolver.get(path)+"/"+file.getOriginalFilename()),new File(ProjectXml.getValue("file_path")+path+"/"+file.getOriginalFilename()));
//            int bytesum = 0;
//            int byteread = 0;
//            if (f.exists()) { //文件存在时
//                InputStream inStream = new FileInputStream(realPathResolver.get(path)+"/"+file.getOriginalFilename()); //读入原文件
//                FileOutputStream fs = new FileOutputStream(ProjectXml.getValue("file_path")+path+"/"+file.getOriginalFilename());
//
//                byte[] buffer = new byte[1444];
//                int length;
//                while ( (byteread = inStream.read(buffer)) != -1) {
//                    bytesum += byteread; //字节数 文件大小
//                    System.out.println(bytesum);
//                    fs.write(buffer, 0, byteread);
//                }
//                inStream.close();
//            }
        }
        catch (Exception e) {
            log.info("copy the file false",e);

        }
    }

	public void update(String name, String source) {
		String real = realPathResolver.get(name);
		File f = new File(real);
		try {
			FileUtils.writeStringToFile(f, source, "UTF-8");
		} catch (IOException e) {
			log.error("Save template error: " + name, e);
			throw new RuntimeException(e);
		}
	}

	private String root;

	private RealPathResolver realPathResolver;

	@Autowired
	public void setRealPathResolver(RealPathResolver realPathResolver) {
		this.realPathResolver = realPathResolver;
		root = realPathResolver.get("");
	}

	/**
	* This class should preserve.
	* @preserve
	*/
	private static class PrefixFilter implements FileFilter {
		private String prefix;

		public PrefixFilter(String prefix) {
			this.prefix = prefix;
		}

		public boolean accept(File file) {
			String name = file.getName();
			return file.isFile() && name.startsWith(prefix);
		}
	}

}
