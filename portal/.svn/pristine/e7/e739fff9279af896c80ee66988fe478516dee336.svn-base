package com.ifunpay.portal.service.interact;

import com.ifunpay.portal.controller.interact.ResponseContent;
import com.ifunpay.portal.service.ImageService;
import com.ifunpay.util.cache.BooleanCacheService;
import com.ifunpay.util.common.NumberUtil;
import com.ifunpay.util.enums.InteractType;
import com.ifunpay.util.sdk.oms.TerminalChannelClient;
import com.jspgou.cms.entity.Product;
import com.jspgou.cms.manager.ProductMng;
import lombok.extern.log4j.Log4j;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * 终端机更新本地商品
 * Created by ZHENGJIANG on 2014/11/28.
 */
@Service
@Log4j
public class MerchandiseService {

    @Resource
    private ProductMng productMng;

    @Resource
    private ImageService imageService;

    TerminalChannelClient terminalChannelClient = new TerminalChannelClient();

    @Resource
    BooleanCacheService booleanCacheService;

    /**
     * 返回终端机商品信息
     *
     * @param requestJson
     * @param responseContent
     * @throws Exception
     */
    public void getMerchandises(String requestJson, ResponseContent responseContent) throws Exception {
        try {
            JSONObject par = JSONObject.fromObject(requestJson);
            JSONObject datas = par.getJSONObject("header");
            String softwareNumber = datas.getString("terminal_id");
            Optional<String> merchantID = terminalChannelClient.getMerchantId(softwareNumber);
            AtomicInteger index = new AtomicInteger();
            if (merchantID.isPresent()) {
                List<?> list = booleanCacheService.getObjectThroughCache(
                        InteractType.MERCHANDISE,
                        merchantID.get(),
                        () -> productMng.fetchLocalProductByCommerceId(merchantID.get())
                                .stream()
                                .map(p -> productToMap(p, index))
                                .collect(Collectors.toList()),
                        ArrayList.class
                );
                log.debug("got " + list.size() + " product(s) for terminal " + softwareNumber);
                responseContent.setBody(list);
            } else {
                responseContent.getHeader().setStatus(1);
                responseContent.getHeader().setError_message("no merchant for this terminal");
            }
        } catch (Exception e) {
            log.error("获取数据失败", e);
            responseContent.getHeader().setStatus(1);
            responseContent.getHeader().setError_message("获取数据失败");
        }
    }


    public Map<String, Object> productToMap(Product pt, AtomicInteger currentIndex) {
        Map<String, Object> productObject = new HashMap<>();

        productObject.put("id", pt.getId());
        productObject.put("sequence", currentIndex.incrementAndGet());
        productObject.put("name", pt.getName());
        if (null != pt.getBrand()) {
            productObject.put("brand", pt.getBrand().getName());
        }
        productObject.put("specification", "");//pt.getText1());
        productObject.put("country", "");
        productObject.put("package", "");
        productObject.put("price", NumberUtil.yuanToFen(pt.getMarketPrice()));
        productObject.put("price_pos", NumberUtil.yuanToFen(pt.getScreenPrice()));
        productObject.put("price_flashpay", NumberUtil.yuanToFen(pt.getFlashPrice()));
        productObject.put("price_qrcode", NumberUtil.yuanToFen(pt.getLittlePrice()));
        productObject.put("price_scan", NumberUtil.yuanToFen(pt.getScanningPrice()));

        List<ImageService.ImageWrapper> detail_images = new ArrayList<>();
        imageService.getImageWrapper(pt.getDetailImgUrl()).ifPresent(detail_images::add);
        imageService.getImageWrapper(pt.getListImgUrl()).ifPresent(detail_images::add);
        imageService.getImageWrapper(pt.getMinImgUrl()).ifPresent(detail_images::add);

        Optional<ImageService.ImageWrapper> optionalImage = imageService.getImageWrapper(pt.getCoverImgUrl());
        if (!optionalImage.isPresent() && detail_images.size() > 0) {
            optionalImage = Optional.of(detail_images.get(0));
        } else if (optionalImage.isPresent() && detail_images.isEmpty()) {
            detail_images.add(optionalImage.get());
        }
        productObject.put("cover_image", optionalImage.orElse(null));
        productObject.put("detail_images", detail_images);
        return productObject;
    }

}
