package com.jspgou.common.web.springmvc;

import org.springframework.web.servlet.view.AbstractTemplateViewResolver;
import org.springframework.web.servlet.view.AbstractUrlBasedView;

/**
 * ViewResolver for RichFreeMarkerView
 * 
 * Override buildView, if viewName start with / , then ignore prefix.
 * 
 * @author liufang
 * This class should preserve.
 * @preserve
*/
public class RichFreeMarkerViewResolver extends AbstractTemplateViewResolver{

	/**
	 * Set default viewClass
	 */
	public RichFreeMarkerViewResolver() {
		setViewClass(RichFreeMarkerView.class);
	}

	/**
	 * if viewName start with / , then ignore prefix.
	 */
	@Override
    protected AbstractUrlBasedView buildView(String viewName) throws Exception{
		AbstractUrlBasedView view = super.buildView(viewName);
		// start with / ignore prefix
		if (viewName.startsWith("/")) {
			view.setUrl(viewName + getSuffix());
		}

        logger.debug("show details :"+viewName +" ,suffix :"+ getSuffix());
		return view;
    }
}
