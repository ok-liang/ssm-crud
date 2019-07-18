package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 定义一个 通用的返回类
 */
public class Msg {
    // 状态吗 100--成功  200--失败
    private int code;
    // 提示信息
    private String msg;
    // 用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    // 执行成功
    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("执行成功...");
        return msg;
    }

    // 执行失败
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("执行失败...");
        return msg;
    }

    // 追加返回的数据
    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    @Override
    public String toString() {
        return "Msg{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", extend=" + extend +
                '}';
    }
}
