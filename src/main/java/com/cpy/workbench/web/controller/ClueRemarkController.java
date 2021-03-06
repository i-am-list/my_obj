package com.cpy.workbench.web.controller;

import com.cpy.commons.contants.Contants;
import com.cpy.commons.domain.ReturnObject;
import com.cpy.commons.utils.DateUtils;
import com.cpy.commons.utils.UUIDUtils;
import com.cpy.settings.domain.User;
import com.cpy.workbench.domain.Activity;
import com.cpy.workbench.domain.ActivityRemark;
import com.cpy.workbench.domain.ClueActivityRelation;
import com.cpy.workbench.domain.ClueRemark;
import com.cpy.workbench.service.ActivityService;
import com.cpy.workbench.service.ClueActivityRelationService;
import com.cpy.workbench.service.ClueRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ClueRemarkController {

    @Autowired
    private ClueRemarkService clueRemarkService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ClueActivityRelationService clueActivityRelationService;

    @RequestMapping("/workbench/clue/saveClueRemark.do")
    public @ResponseBody Object saveClueRemark(ClueRemark clueRemark, HttpSession session){
//        封装参数
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        clueRemark.setCreateBy(user.getId());
        clueRemark.setId(UUIDUtils.createUUID());
        clueRemark.setCreateTime(DateUtils.formatDateTime(new Date()));
        clueRemark.setEditFlag(Contants.EDIT_FLAG_FALSE);

        //        执行service层方法
        ReturnObject ret = new ReturnObject();
        try{
            int i = clueRemarkService.saveCreateClueRemark(clueRemark);
            if (i <= 0){
                ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                ret.setMessage("添加备注失败");
            }else {
                ret.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
                ret.setRetData(clueRemark);
            }
        }catch(Exception e){
            e.printStackTrace();
            ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            ret.setMessage("添加备注失败");
        }
        return ret;
    }

    @RequestMapping("/workbench/clue/deleteClueRemarkById.do")
    public @ResponseBody Object deleteClueRemarkById(String id){
        ReturnObject ret = new ReturnObject();
        try {
//            调用service层实现
            int i = clueRemarkService.deleteClueRemarkById(id);
            if (i > 0){
                ret.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
            }else {
                ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                ret.setMessage("删除失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            ret.setMessage("删除失败");
        }
        return ret;
    }

    @RequestMapping("/workbench/activity/saveEditClueRemark.do")
    public @ResponseBody Object saveEditActivityRemark(ClueRemark clueRemark, HttpSession session){
        ReturnObject ret = new ReturnObject();
//        封装参数
        clueRemark.setEditFlag(Contants.EDIT_FLAG_TRUE);
        clueRemark.setEditTime(DateUtils.formatDateTime(new Date()));
        User user = (User) session.getAttribute(Contants.SESSION_USER);

        clueRemark.setEditBy(user.getId());
        try{
            //        调用service层方法
            int success = clueRemarkService.updateClueRemarkById(clueRemark);
            if (success > 0){
//            更新成功
                ret.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
                ret.setRetData(clueRemark);
            }else {
                ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                ret.setMessage("更新失败，请稍后重试");
            }
        }catch (Exception e){
            ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            ret.setMessage("更新失败，请稍后重试");
            e.printStackTrace();

        }
        return ret;
    }

    /**
     * 实现保存关联的市场活动
     * @param activityId
     * @param clueId
     * @return
     */
    @RequestMapping("/workbench/activity/saveBund.do")
    public @ResponseBody Object saveBund(String[] activityId, String clueId){
        List<ClueActivityRelation> list = new ArrayList<>();
        ClueActivityRelation clueActivityRelation = null;
        for (int i = 0; i < activityId.length; i++) {
            clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setActivityId(activityId[i]);
            clueActivityRelation.setClueId(clueId);
            clueActivityRelation.setId(UUIDUtils.createUUID());
            list.add(clueActivityRelation);
        }
//        调用service层
        List<Activity> activityList = null;
        ReturnObject ret = new ReturnObject();
        try {
            int i = clueActivityRelationService.saveCreateActivityRelationServices(list);
            if (i > 0) {
                activityList = activityService.queryActivityForDetailByIds(activityId);
                ret.setCode(Contants.RETURN_OBJECT_CODE_SUCCESS);
                ret.setRetData(activityList);
            }else {
                ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
                ret.setMessage("系统忙，请稍后重试");
            }
        }catch (Exception e){
            e.printStackTrace();
            ret.setCode(Contants.RETURN_OBJECT_CODE_FAIL);
            ret.setMessage("系统忙，请稍后重试");
        }
        return ret;
    }
}
