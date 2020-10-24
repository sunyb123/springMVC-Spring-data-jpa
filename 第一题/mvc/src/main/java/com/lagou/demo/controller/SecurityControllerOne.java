package com.lagou.demo.controller;

import com.lagou.edu.mvcframework.annotations.LagouController;
import com.lagou.edu.mvcframework.annotations.LagouRequestMapping;
import com.lagou.edu.mvcframework.annotations.Security;

@LagouController
@LagouRequestMapping("/securityOne")
@Security({"小马","小王"})
public class SecurityControllerOne {

    @LagouRequestMapping("/byXiaomaAndXiaowang")
    public String adoptByXiaoma(){
        return "Successful visit";
    }

}
