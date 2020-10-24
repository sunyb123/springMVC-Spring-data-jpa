package com.lagou.demo.controller;

import com.lagou.edu.mvcframework.annotations.LagouController;
import com.lagou.edu.mvcframework.annotations.LagouRequestMapping;
import com.lagou.edu.mvcframework.annotations.Security;

@LagouController
@LagouRequestMapping("/securityTwo")
public class SecurityControllerTwo {

    @Security("小李")
    @LagouRequestMapping("/byXiaoli")
    public String adoptByXiaoli(){
        return "Successful visit";
    }

    @Security({"小王","小李"})
    @LagouRequestMapping("/byXiaowangAndXiaoli")
    public String adoptByXiaowang(){
        return "Successful visit";
    }

}
