package com.jspgou.cms.action.admin;

import com.ifunpay.portal.ProjectXml;
import com.ifunpay.util.common.StringUtil;
import com.ifunpay.util.image.ImageUtil;
import com.jspgou.cms.manager.ImageMng;
import com.jspgou.cms.web.SiteUtils;
import com.jspgou.common.file.FileNameUtils;
import com.jspgou.common.image.ImageUtils;
import com.jspgou.core.entity.Website;
import com.jspgou.core.web.WebErrors;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

import static com.jspgou.common.web.Constants.SPT;
import static com.jspgou.common.web.Constants.UPLOAD_PATH;
/**
* This class should preserve.
* @preserve
*/
@Controller
public class ImageUploadAct implements ServletContextAware {
	private static final Logger log = LoggerFactory
			.getLogger(ImageUploadAct.class);
	/**
	 * 结果页
	 */
	private static final String RESULT_PAGE = "/common/iframe_upload";
	
	private static final String RESULT_SWITCH_PAGE = "/common/iframe_switch_upload";
	
	private static final String RESULT_BIG_PAGE = "/common/iframe_big_upload";
	
	private static final String RESULT_AMP_PAGE = "/common/iframe_amp_upload";

	/**
	 * 错误信息参数
	 */
	public static final String ERROR = "error";

	@RequestMapping("/common/o_upload_image.do")
	public String execute(
			String fileName,
			Integer uploadNum,
			Integer zoomWidth,
			Integer zoomHeight,
			@RequestParam(value = "uploadFile", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) {
		WebErrors errors = validate(fileName, file, request);
		if (errors.hasErrors()) {
			model.addAttribute(ERROR, errors.getErrors().get(0));
			return RESULT_PAGE;
		}
		Website web = SiteUtils.getWeb(request);
//		String real = servletContext.getRealPath(web.getUploadRel());
        String real = ProjectXml.getValue("img_path")+web.getUploadRel();
		String dateDir = FileNameUtils.genPathName();
		// 创建目录
		File root = new File(real, dateDir);
		if (!root.exists()) {
			root.mkdirs();
		}
		// 取文件名
		if (StringUtils.isBlank(fileName)) {
			String ext = FilenameUtils.getExtension(file.getOriginalFilename());
			fileName = FileNameUtils.genFileName(ext);
		} else {
			fileName = FilenameUtils.getName(fileName);
		}
		// 保存为临时文件
		File tempFile = new File(root, fileName);
		// 相对路径
		String ctx = request.getContextPath();
		String relPath =ctx+ SPT+UPLOAD_PATH+SPT + dateDir + SPT + fileName;
        String basePath = ProjectXml.getValue("base_path_upload");
        String md5 = null;


		model.addAttribute("zoomWidth",zoomWidth);
		model.addAttribute("zoomHeight",zoomHeight);
		try {
			file.transferTo(tempFile);
//            if(100==uploadNum){ //封面图片  裁剪
//                ImageUtil.resizeImage(root + "/" + fileName, 160, 160, root + "/" + fileName);
//            }
			model.addAttribute("uploadPath", relPath);
			model.addAttribute("uploadNum", uploadNum);
            model.addAttribute("basePath",basePath);
		} catch (IllegalStateException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		} catch (IOException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		}
            md5=StringUtil.getMd5HexByUtf8Encoding(tempFile.toString());
        imageMng.save(fileName,relPath,md5);
		return RESULT_PAGE;
	}
	
	//切换图片上传
	@RequestMapping("/common/o_upload_switch_image.do")
	public String executeSwitch(
			String fileName,
			Integer uploadNum,
			@RequestParam(value = "uploadFileSwitch", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) {
		WebErrors errors = validate(fileName, file, request);
		if (errors.hasErrors()) {
			model.addAttribute(ERROR, errors.getErrors().get(0));
			return RESULT_SWITCH_PAGE;
		}
		Website web = SiteUtils.getWeb(request);
//		String real = servletContext.getRealPath(web.getUploadRel());
        String real = ProjectXml.getValue("img_path")+web.getUploadRel();
        String basePath = ProjectXml.getValue("base_path_upload");
		String dateDir = FileNameUtils.genPathName();
		// 创建目录
		File root = new File(real, dateDir);
		if (!root.exists()) {
			root.mkdirs();
		}
		// 取文件名
        String fileName2 = "";
        String fileName3 = "";
		if (StringUtils.isBlank(fileName)) {
			String ext = FilenameUtils.getExtension(file.getOriginalFilename());
			fileName = FileNameUtils.genFileName(ext);
            fileName2 = FileNameUtils.genFileName(ext);
            fileName3 = FileNameUtils.genFileName(ext);
		} else {
			fileName = FilenameUtils.getName(fileName);
		}
		// 保存为临时文件
		File tempFile = new File(root, fileName);
		// 相对路径
		String ctx = request.getContextPath();
		String relPath = ctx+SPT+UPLOAD_PATH+SPT + dateDir + SPT + fileName;
        String relPath2 = ctx+SPT+UPLOAD_PATH+SPT + dateDir + SPT + fileName2;
        String relPath3 = ctx+SPT+UPLOAD_PATH+SPT + dateDir + SPT + fileName3;
        String md5 = null;
        String md52 = null;
        String md53 = null;
        File tempFile2 = new File(root, fileName2);
        File tempFile3 = new File(root, fileName3);




		try {
			file.transferTo(tempFile);

            ImageUtil.resizeImage(root + "/" + fileName, 380, 380, root + "/" + fileName2);
            ImageUtil.resizeImage(root+"/"+fileName,600,600,root+"/"+fileName3);
            ImageUtil.resizeImage(root + "/" + fileName, 60, 60, root + "/" + fileName);
		} catch (IllegalStateException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		} catch (IOException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		}
//        try {
////            md5=StringUtil.getMd5Hex(file.getBytes());
//
//
//        } catch (IOException e) {
//            log.info("get md5 false"+e);
//        }
        md5=StringUtil.getMd5HexByUtf8Encoding(tempFile.toString());
        md52=StringUtil.getMd5HexByUtf8Encoding(tempFile2.toString());
        md53=StringUtil.getMd5HexByUtf8Encoding(tempFile3.toString());
        imageMng.save(fileName,relPath,md5);
        imageMng.save(fileName2,relPath2,md52);
        imageMng.save(fileName3,relPath3,md53);

        model.addAttribute("uploadPath", relPath);
        model.addAttribute("uploadPath2", relPath2);
        model.addAttribute("uploadPath3", relPath3);
        model.addAttribute("uploadNum", uploadNum);
        model.addAttribute("basePath",basePath);

		return RESULT_SWITCH_PAGE;
	}
	
	//大图片上传
	@RequestMapping("/common/o_upload_big_image.do")
	public String executeBig(
			String fileName,
			Integer uploadNum,
			@RequestParam(value = "uploadFileBig", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) {
		WebErrors errors = validate(fileName, file, request);
		if (errors.hasErrors()) {
			model.addAttribute(ERROR, errors.getErrors().get(0));
			return RESULT_BIG_PAGE;
		}
		Website web = SiteUtils.getWeb(request);
//		String real = servletContext.getRealPath(web.getUploadRel());
        String real = ProjectXml.getValue("img_path")+web.getUploadRel();
		String dateDir = FileNameUtils.genPathName();
		// 创建目录
		File root = new File(real, dateDir);
		if (!root.exists()) {
			root.mkdirs();
		}
		// 取文件名
		if (StringUtils.isBlank(fileName)) {
			String ext = FilenameUtils.getExtension(file.getOriginalFilename());
			fileName = FileNameUtils.genFileName(ext);
		} else {
			fileName = FilenameUtils.getName(fileName);
		}
		// 保存为临时文件
		File tempFile = new File(root, fileName);
		// 相对路径
		String ctx = request.getContextPath();
		String relPath =ctx + SPT+UPLOAD_PATH+SPT + dateDir + SPT + fileName;
        String basePath = ProjectXml.getValue("base_path_upload");
        String md5 = null;
        try {
            md5=StringUtil.getMd5Hex(file.getBytes());
        } catch (IOException e) {
            log.info("get md5 false"+e);
        }
        imageMng.save(fileName,relPath,md5);
		try {
			file.transferTo(tempFile);
			model.addAttribute("uploadPath", relPath);
			model.addAttribute("uploadNum", uploadNum);
            model.addAttribute("basePath",basePath);
		} catch (IllegalStateException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		} catch (IOException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		}
		return RESULT_BIG_PAGE;
	}
	
	//放大图片上传
	@RequestMapping("/common/o_upload_amp_image.do")
	public String executeAmp(
			String fileName,
			Integer uploadNum,
			@RequestParam(value = "uploadFileAmp", required = false) MultipartFile file,
			HttpServletRequest request, ModelMap model) {
		WebErrors errors = validate(fileName, file, request);
		if (errors.hasErrors()) {
			model.addAttribute(ERROR, errors.getErrors().get(0));
			return RESULT_AMP_PAGE;
		}
		Website web = SiteUtils.getWeb(request);
//		String real = servletContext.getRealPath(web.getUploadRel());
        String real = ProjectXml.getValue("img_path")+web.getUploadRel();
		String dateDir = FileNameUtils.genPathName();
		// 创建目录
		File root = new File(real, dateDir);
		if (!root.exists()) {
			root.mkdirs();
		}
		// 取文件名
		if (StringUtils.isBlank(fileName)) {
			String ext = FilenameUtils.getExtension(file.getOriginalFilename());
			fileName = FileNameUtils.genFileName(ext);
		} else {
			fileName = FilenameUtils.getName(fileName);
		}
		// 保存为临时文件
		File tempFile = new File(root, fileName);
		// 相对路径
		String ctx = request.getContextPath();
		String relPath =ctx+ SPT+UPLOAD_PATH+SPT + dateDir + SPT + fileName;
        String basePath = ProjectXml.getValue("base_path_upload");
        String md5 = null;
        try {
            md5=StringUtil.getMd5Hex(file.getBytes());
        } catch (IOException e) {
            log.info("get md5 false"+e);
        }
        imageMng.save(fileName,relPath,md5);
		try {
			file.transferTo(tempFile);
			model.addAttribute("uploadPath", relPath);
			model.addAttribute("uploadNum", uploadNum);
            model.addAttribute("basePath",basePath);
		} catch (IllegalStateException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		} catch (IOException e) {
			model.addAttribute(ERROR, e.getMessage());
			log.error("upload file error!", e);
		}
		return RESULT_AMP_PAGE;
	}
	
	private WebErrors validate(String fileName, MultipartFile file,
			HttpServletRequest request) {
		WebErrors errors = WebErrors.create(request);
		if (file == null) {
			errors.addErrorCode("imageupload.error.noFileToUpload");
			return errors;
		}
		if (StringUtils.isBlank(fileName)) {
			fileName = file.getOriginalFilename();
		}
		String ext = FilenameUtils.getExtension(fileName);
		if (!ImageUtils.isImage(ext)) {
			errors.addErrorCode("imageupload.error.notSupportExt", ext);
			return errors;
		}
		return errors;
	}

	private ServletContext servletContext;
    @Resource
    private ImageMng imageMng;

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}
