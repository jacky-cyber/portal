package com.ifunpay.portal.controller.interact;

/**
 * Created by Yu on 2014/11/21.
 */
public class RequestContent {
    RequestContentHeader header;
    RequestContentBody body;

    public RequestContentHeader getHeader() {
        return header;
    }

    public void setHeader(RequestContentHeader header) {
        this.header = header;
    }

    public RequestContentBody getBody() {
        return body;
    }

    public void setBody(RequestContentBody body) {
        this.body = body;
    }
}
